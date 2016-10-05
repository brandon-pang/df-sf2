﻿/**
/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

import flash.external.ExternalInterface; 
import flash.geom.Rectangle;
import gfx.controls.CoreList;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.controls.ScrollingList;

[InspectableList("disabled", "visible", "itemRenderer", "inspectableScrollBar", "rowHeight", "inspectableRendererInstanceName", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "bindingEnabled")]
class com.scaleform.MaskedList extends ScrollingList {
		
	private var itemContainer:MovieClip;
	private var mask:MovieClip;
	private var bg:MovieClip;

	private var _itemHeight:Number; //The height of the item renderer.
	private var _viewRendererCount:Number; //The number of renderers that will be displayed in the view.
	private var _drawnRendererCount:Number; //The number of drawn renderers (displayed + cached) in our list.
	private var _bottomFlatPixelShift:Number;  //The pixel shift so any bottom renderer offscreen is 100% displayed flat against the bottom.
	
	private var _lastPosition:Number; //The last _scrollPosition of the list. 
	private var _topRenderer:Number; //The index of the _topRenderer.
	
	private var _startIndex:Number; //Used for repopulating data for invalidated renderers.
	private var _endIndex:Number; //Used for repopulating data for invalidated renderers.
	
	private var _targetWidth:Number;

// Initialization:
	public function MaskedList() { 
		super();
		itemContainer =	container.createEmptyMovieClip("itemContainer", container.getNextHighestDepth());
		itemContainer.scale9Grid = new Rectangle(0,0,1,1); 		
	}

// Public Methods:	
	//20120227 senariel begin - GameDataProvider 방식 적용하면서 검출된 버그 수정
	public function get totalRenderers():Number
	{
		if( _dataProvider != null )
			return _dataProvider.length;
		else
			return super.totalRenderers;
	}
	//20120227 senariel end
	
	public function set totalRenderers(value:Number):Void
	{
		super.totalRenderers = value;
	}

		
	public function get selectedIndex():Number { return _selectedIndex; }
	public function set selectedIndex(value:Number):Void {
		if (value == _selectedIndex) { return; }
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) {
			renderer.selected = false; // Only reset items in range
		}
		
		_selectedIndex = value;
		if (totalRenderers == 0) { return; }
		renderer = getRendererAt(_selectedIndex);
		if (renderer != null && value > _topRenderer && value < (Math.floor(_viewRendererCount) + _topRenderer)) {
			renderer.selected = true; // Item is in range. Just set it.
		} else {
			scrollToIndex(_selectedIndex); 
			renderer.selected = true;
		}
	}
	
	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void {
		value = Math.max(0, Math.round(value));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		
		//invalidateData();
		//updateScrollBar();
	}
	
	public function columsWidth(value:Number):Void{
		_targetWidth = value;
	}
	
    public function scrollToTop():Void {
		scrollPixel(0); //Scroll back up to the top.
	}
		
	public function scrollToIndex(index:Number):Void {
		if (totalRenderers == 0) { return; }
		if (index > totalRenderers || index < 0) { return; }
		
		//Calculate the bounds of whats on screen.
		var lastFullRend:Number = Math.floor(_viewRendererCount) + _topRenderer - 1;
		
		//If the index is larger than (below) the _topRenderer and the index is less than(above) the 2nd to last renderer 
		//just return, it's a clean move. We use the 2nd to last because the last may be partially offscreen.
		if (index > _topRenderer && index < lastFullRend) {
			return;
		} else if (index >= lastFullRend) {
			scrollPixel( ((index - Math.floor(_viewRendererCount)) * _itemHeight) + _bottomFlatPixelShift );
		} else {
			scrollPixel(index * _itemHeight);
		}
		
		//Ensure that our position is mirrored by the scrollBar.
		if (_scrollBar.position != _scrollPosition) { _scrollBar.position = _scrollPosition; }
		repositionCheck(_topRenderer);
	}
	
// Private Methods:
	private function draw():Void {
		if (externalRenderers) {
			totalRenderers = _dataProvider.length;
		} else {
			container._xscale = 10000/_xscale; // Counter scale the list items.
			container._yscale = 10000/_yscale;
			var h:Number = _rowHeight;
			if (h == null) {
				var temp:MovieClip = createItemRenderer(99);
				h = temp._height;
				temp.removeMovieClip();
			}
			_itemHeight = h;
			
			var vertPadding:Number = (margin * 2) + paddingTop + paddingBottom;
			totalRenderers = _dataProvider.length;
			
			//Calculate the number of renderers we can ever have at once.
			_drawnRendererCount = int((__height / _itemHeight) + 2);
			_viewRendererCount = (__height / _itemHeight);
			
			//Calculate the pixel shift neeed.
			var precentOffscreen:Number = _viewRendererCount % 1;
			_bottomFlatPixelShift = (1 - precentOffscreen) * _itemHeight;
			
			//Draw enough renderers to fill the view + a few cached.
			drawRenderers(_drawnRendererCount);
			drawLayout(_targetWidth, h);
			
			var nw:Number = __width * (100/_xscale), nh:Number = __height * (100/_yscale);
			mask._width = nw;
			mask._height = nh;
			
			if (bg) {
				bg._width = nw;
				bg._height = nh;
			}
		}
		
		updateScrollBar();
		invalidateData();
		
		//_dataProvider.requestItemRange(0, _drawnRendererCount, this, "populateDataNew");
		
		setState();
		
	}
	
	private function drawLayout(rendererWidth:Number, rendererHeight:Number):Void {
		var horizPadding:Number = paddingLeft + paddingRight + (margin * 2);
		rendererWidth = rendererWidth - horizPadding;
		for (var i:Number=0; i<renderers.length; i++) {
			renderers[i]._x = margin + paddingLeft;
			renderers[i]._y = ((i+_topRenderer) * rendererHeight) + margin + paddingTop;
			renderers[i].setSize(rendererWidth, rendererHeight);			
		}
		
		drawScrollBar();
	}
	
	private function createItemRenderer(index:Number):MovieClip {
		var clip:MovieClip = itemContainer.attachMovie(_itemRenderer, "renderer"+index, index);
		if (clip == null) { return null; }
		setUpRenderer(clip);
		return clip;
	}
	
	private function populateData(data:Array):Void {
		for (var i:Number=0; i < renderers.length; i++) {
			var renderer:MovieClip = renderers[i];
			//var index:Number = _scrollPosition + i;
			
			var index:Number = _topRenderer + i;
			renderers[i].setListData(index, itemToLabel(data[i]), _selectedIndex == index); //LM: Consider passing renderer position also. (Support animation)
			renderer.setData(data[i]);
			
			//dpId will be our identification for the index within the dataProvider, used for tracking and identifying our 
			//"selectedIndex"
			renderer.dpId = _topRenderer + i;
			
			//Ensure that all renderers within the _drawnRendererCount are no longer selected.
			renderer.selected = false; 

			//If the selectedIndex is within the _drawnRendererCount, set that renderer with its data to selected.
			if (selectedIndex == renderer.dpId){ renderer.selected = true; } 
		}
		
		//20120227 senariel begin - 데이터 갱신시 스크롤도 갱신
		updateScrollBar();
		//20120227 senariel end
	}
	
	private function populateDataFromTo(data:Array):Void {
		for (var i:Number = _startIndex; i <= _endIndex; i++) {
			var renderer:MovieClip = renderers[i];
			
			var index:Number = _topRenderer + i;
			
			//renderers[i].setListData(index, itemToLabel(data[i]), _selectedIndex == index);
			renderers[i].setListData(index, itemToLabel(data[i-_startIndex]), _selectedIndex == index);		//20120305 senariel - bugfix
			renderer.setData(data[i-_startIndex]);
			
			//dpId will be our identification for the index within the dataProvider, used for tracking and identifying our "selectedIndex"
			renderer.dpId = _topRenderer + i;
			
			//Ensure that all renderers within the _drawnRendererCount are no longer selected.
			renderer.selected = false; 

			//If the selectedIndex is within the _drawnRendererCount, set that renderer with its data to selected.
			if (selectedIndex == renderer.dpId) { renderer.selected = true; }
		}
	}
	
	private function drawRenderers(totalRenderers:Number):Void {
		// Remove extra renderers
		while (renderers.length > totalRenderers) {
			renderers.pop().removeMovieClip();
		}
		
		// Add new renderers
		while (renderers.length < _drawnRendererCount) {
			renderers.push(createItemRenderer(renderers.length));
		}
	}	
	
	public function destroyRenderers():Void {		
		for (var i:Number = 0; i < renderers.length; i++){			
			renderers[i].visible = false;
			renderers[i].removeMovieClip();			
		}
		renderers = new Array();
	}
		
	
	private function repositionCheck(topIndex:Number):Void {
		//trace ("repositionCheck = "+topIndex)
		var startIndex:Number = -1;
		var endIndex:Number = _drawnRendererCount;
		
		var valid:Array = [];  //Used to keep track of renderers that do not need to be shifted/invalidated.
		var invalid:Array = [];  //Used to keep track of renderers that should be shifted/invalidated.
		var newRenderers = [];  //Used to maintain the position of the renderers in the renderers array.
		
		for (var i:Number = 0; i < renderers.length; i++) {
			var renderer:MovieClip = renderers[i];
			
			//If the renderer is above the scrollPosition
			if ((renderer._y + _itemHeight) < _scrollPosition){
				invalid.push(renderer);
				if (startIndex == -1) {
					startIndex = _drawnRendererCount;
					endIndex = startIndex-1;
				}
				startIndex--;
			}
			
			//If the renderer is below the position of the new last drawnRenderer
			else if (renderer._y > ((topIndex + _drawnRendererCount - 1) * _itemHeight + 1)){
				invalid.push(renderer);
				if (endIndex == _drawnRendererCount) {
					endIndex = -1;
					startIndex = 0;
				}
				endIndex++;
			}
			//If the renderer is valid.
			else
				valid.push(renderer); 
		}
		
		if (startIndex != -1) {
			//Reconstruct the renderers array using newRenderers.
			for (var j:Number = 0; j < startIndex; j++) {
				newRenderers.push(valid[j]);
			}
			for (var j:Number = startIndex; j <= endIndex; j++){
				var renderer:MovieClip = MovieClip(invalid.pop());
				renderer._y = (topIndex * _itemHeight) + (j * _itemHeight);  //Shift all renderers that are invalid.
				newRenderers.push(renderer);
			}
			var ei:Number = endIndex+1;
			for (var j:Number = endIndex+1; j < _drawnRendererCount; j++) {
				newRenderers.push(valid[j-ei]);
			}
			_startIndex = startIndex;
			_endIndex = endIndex;			
			renderers = newRenderers;
			//Invalidate the data for renderers that were invalid.
			_dataProvider.requestItemRange((topIndex + startIndex), (topIndex + endIndex), this, "populateDataFromTo");
		}
	}
	
	// 20120307 senariel begin - MaskedList 에서는 _scrollPosition 을 이용하지 않고 _topRenderer 를 이용합니다.
	// _topRenderer 가 현재 리스트 상태에서 최상단 아이템의 인덱스이므로 따로 계산할 필요가 없음.
	// 고로케 재정의 합니다.
	public function invalidateData():Void
	{
		// MaskedList 에서는 scrollIndex와 selectedIndex를 따로 처리합니다. (item 단위가 아닌 pixel 단위이기 때문에)
		//_scrollPosition = Math.min(Math.max(0, _dataProvider.length - totalRenderers), _scrollPosition);
		//selectedIndex = Math.min(_dataProvider.length-1, _selectedIndex);
		_dataProvider.requestItemRange(_topRenderer, Math.min(_dataProvider.length-1, _topRenderer+_drawnRendererCount-1), this, "populateData");
	}
	// 20120307 senariel end

	
	public function scrollPixel(scrollPos:Number):Void {
		_scrollPosition = scrollPos;
		if (_scrollPosition == _lastPosition) { return; }
		else {
			_topRenderer = find_topRenderer();
			repositionCheck(_topRenderer);
			itemContainer._y = (-_scrollPosition);
		}
		_lastPosition = scrollPos;
	}
	
	private function find_topRenderer():Number {
		if (_itemHeight == undefined) { return 0; }
		//return int(scrollPosition / _itemHeight);
		return Math.max( 0, Math.ceil(scrollPosition / _itemHeight) - 1 );		// 20120327 senariel - topRenderer 의 인덱스가 잘못되던 것 수정
	}
	
	//Returns the renderer for _dataProvider[index] if it currently exists.
	public function getRendererAt(index:Number):MovieClip {
		if (index > totalRenderers || index < 0) { return null; }
		for (var i:Number=0; i < _drawnRendererCount; i++) {
			var renderer:MovieClip = renderers[i];
			if (renderer.dpId == index){ return renderer; }
		}
	}
	
	//When a user clicks, the index of that data in the dataProvider is stored as the selected index. 
	//It will later be compared against the dpId property of all renderers in the _drawnRendererCount to ensure it's selected when
	//it returns within the _drawnRendererCount.
	private function handleItemClick(event:Object):Void {
		var index:Number = event.target.index;
		if (isNaN(index)) { return; } // If the data hasy not been populated, but the listItemRenderer is clicked, it will have no index.
		selectedIndex = event.target.dpId;
		event.target.selected = true;
		dispatchItemEvent(event);		
	}	
	
	private function updateScrollBar():Void {		
		var max:Number = Math.max(0, dataProvider.length-totalRenderers);
		//
		//_scrollBar._visible=false
		//
		//_scrollBar._y = 8;
		
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.setScrollProperties(_itemHeight*3, 0, (((totalRenderers-1 - Math.floor(_viewRendererCount)) * _itemHeight) + _bottomFlatPixelShift), __height/10);			
		} else {
			_scrollBar.minimum = 0;
			_scrollBar.maximum = max;
		}
		_scrollBar.position = _scrollPosition;
		_scrollBar.trackScrollPageSize = __height;
	}
	
	private function drawScrollBar():Void {		
		if (!autoScrollBar) { return; }
		_scrollBar._x = __width - _scrollBar._width - margin;
		_scrollBar._y = margin + 8;
		_scrollBar.height = __height - (margin * 2);
	}
	
	private function scrollWheel(delta:Number):Void {
		if (_disabled) { return; }
		scrollPosition = _scrollPosition - delta * _scrollBar.pageScrollSize;
		
		//Ensure that our position is mirrored by the scrollBar.
		if (_scrollBar.position != _scrollPosition) { _scrollBar.position = _scrollPosition; }
		scrollPixel(scrollPosition);
	}
	
	private function handleScroll(event:Object):Void
	{
		//scrollPosition = _scrollBar.position;
		if (_scrollBar.maxPosition >= _scrollBar.position) { scrollPosition = _scrollBar.position; }
		else if (_itemHeight*_dataProvider.length <= this._height) { scrollPosition = 0; }
		scrollPixel(scrollPosition);
	}
	
	// 20120327 senariel begin - 이벤트 인덱스 값 -_-; 통째로 재정의합니다. 이건 뭐 방법이 없어...
	// Dispatch a mouse event that comes from an itemRenderer.
	private function dispatchItemEvent(event:Object):Void {
		var type:String;
		switch (event.type) {
			case "press":
				type = "itemPress"; break;
			case "click":
				type = "itemClick"; break;
			case "rollOver":
				type = "itemRollOver"; break;
			case "rollOut":
				type = "itemRollOut"; break;
			case "doubleClick":
				type = "itemDoubleClick"; break;
			default:
				return;
		}
		var newEvent:Object = {
			target:this,
			type:type,
			item:event.target.data, 
			renderer:event.target, 
			index:event.target.dpId,
			controllerIdx: event.controllerIdx
		};
		dispatchEventAndSound(newEvent);
		
	}
	// 20120327 senariel end
}