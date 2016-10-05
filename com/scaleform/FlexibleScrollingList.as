import gfx.data.DataProvider;
import gfx.core.UIComponent;
import gfx.managers.DragManager;
import gfx.utils.Delegate;
import gfx.utils.Constraints;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import flash.geom.Rectangle;

/**
 * @author noww
 */
[InspectableList("disabled", "visible", "itemRenderer", "inspectableScrollBar", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "enableInitCallback", "soundMap")]
class com.scaleform.FlexibleScrollingList extends UIComponent 
{	
	public var mask:MovieClip;
	public var contents:MovieClip;
	
	private var _dataProvider:Object;
	private var _itemRenderer:String = "ListItemRenderer";
	private var _selectedIndex:Number = -1;
	private var _labelField:String = "label";
	private var _labelFunction:Function;
	public var renderers:Array;
	private var deferredScrollIndex:Number = -1;
	private var totalRenderers:Number = 0;
	
	private var _scrollBar:MovieClip;
	private var container:MovieClip;
	
	private var _scrollPosition:Number = 0;
	
	[Inspectable(name="scrollBar", type="String")]
	private var inspectableScrollBar:Object;
	private var autoScrollBar:Boolean = false;
	
	[Inspectable(defaultValue="1", verbose=1)]
	private var margin:Number = 1;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingBottom:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingLeft:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingRight:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetBottom:Number = 0;
	[Inspectable(defaultValue="1.0", verbose=1)]
	private var thumbSizeFactor:Number = 1.0;
	[Inspectable(defaultValue="10", verbose=1)]
	private var scrollingUnit:Number = 34;
	
	private var constraints:Constraints;
	
	private var scrollDisabled:Boolean = false;
	
	public function FlexibleScrollingList() 
	{
		super();
		
		renderers = [];
		dataProvider = [];
		
		if (container == undefined) { 
			container = createEmptyMovieClip("container", 1); 
		}
		container.scale9Grid = new Rectangle(0,0,1,1);
		tabEnabled = focusEnabled = true;
	}
	
	[Inspectable(defaultValue="ListItemRenderer")]
	public function get itemRenderer():String { return _itemRenderer; }
	public function set itemRenderer(value:String):Void {
		if (value == _itemRenderer || value == "") { return; }
		_itemRenderer = value;
		resetRenderers();
		invalidate();
	}
	
	public function get dataProvider():Object { return _dataProvider; }
	public function set dataProvider(value:Object):Void {
		if (_dataProvider == value) { return; }
		if (_dataProvider != null) {
			_dataProvider.removeEventListener("change", this, "onDataChange");
		}
		_dataProvider = value;
		if (_dataProvider == null) { return; }
		
		if ((value instanceof Array) && !value.isDataProvider) { 
			DataProvider.initialize(_dataProvider);
		} else {
			return;
		}
		
		_dataProvider.addEventListener("change", this, "onDataChange");  // Do a full redraw
		invalidate();
	}
	
	public function get selectedIndex():Number { return _selectedIndex; }
	public function set selectedIndex(value:Number):Void {
		if (value == _selectedIndex) { return; }
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) {
            renderer.selected = false; // Only reset items in range			
		}
		
		var lastIndex:Number = _selectedIndex;
		_selectedIndex = value;
		dispatchEventAndSound({type:"change", index:_selectedIndex, lastIndex:lastIndex});
		if (totalRenderers == 0) { return; }
		renderer = getRendererAt(_selectedIndex);			
		renderer.selected = true; // Item is in range. Just set it.            
		
		scrollToIndex(_selectedIndex);
	}
	
	public function scrollToIndex(index:Number):Void {
		if (totalRenderers == 0) { return; }
		var renderer:MovieClip = getRendererAt(index);
		var targetH:Number = renderer._y + renderer._height - _scrollPosition;
		
		if (targetH > mask._height)
		{
			onPosChangeContents(-(targetH-mask._height));
		}
		else if (renderer._y - _scrollPosition < 0)
		{
			onPosChangeContents(_scrollPosition - renderer._y);
		}
	}
	
	public function get scrollBar():Object { return _scrollBar; }
	public function set scrollBar(value:Object):Void 
	{	
		if (!initialized) { 
			inspectableScrollBar = value;
			return;
		}
		
		if (_scrollBar != null) {
			_scrollBar.removeEventListener("scroll", this, "handleScroll");
			_scrollBar.removeEventListener("change", this, "handleScroll");
			_scrollBar.focusTarget = null;
			if (autoScrollBar) { _scrollBar.removeMovieClip(); } // Clean up auto-created scrollbars only!
		}
		
		autoScrollBar = false; // Reset
		if (typeof(value) == "string") {
			_scrollBar = MovieClip(_parent[value.toString()]); // Outside reference by name
			if (_scrollBar == null) {
				_scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000, {offsetTop:thumbOffsetTop, offsetBottom:thumbOffsetBottom}); // Created using linkage
				if (_scrollBar != null) { 
					autoScrollBar = true;
					//if (_scrollBar.scale9Grid == null) { _scrollBar.scale9Grid = new Rectangle(0,16,1,1); }
				}
			}
		} else { // Outside reference
			_scrollBar = MovieClip(value);
		}
		
		invalidate(); // Redraw to reset scrollbar bounds, even if there is no scrollBar.
		
		if (_scrollBar == null) { return; }
		
		// Now that we have a scrollBar, lets set it up.
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.addEventListener("scroll", this, "handleScroll");
		} else {
			_scrollBar.addEventListener("change", this, "handleScroll");
		}
		_scrollBar.pageScrollSize = scrollingUnit;
		_scrollBar.focusTarget = this;
		_scrollBar.tabEnabled = false;
		updateScrollBar();
	}
	
	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void 
	{
		value = Math.max(-paddingTop, Math.min((contents._height + paddingBottom) - mask._height, Math.round(value)));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		updateScrollBar();
		invalidatePosition();
	}
	
	public function get labelField():String { return _labelField; }
	public function set labelField(value:String):Void {
		_labelField = value;
		invalidateData();
	}
	
	/**
	 * The function used to determine the label for itemRenderers. A {@code labelFunction} will override a {@code labelField} if it is defined.
	 * @see #itemToLabel
	 */
	public function get labelFunction():Function { return _labelFunction; }
	public function set labelFunction(value:Function):Void {
		_labelFunction = value;
		invalidateData();
	}
	
	/**
	 * Convert an item to a label string using the {@code labelField} and {@code labelFunction}.
	 * @param item The item to convert to a label.
	 * @returns The converted label string.
	 * @see #labelField
	 * @see #labelFunction
	 */
	public function itemToLabel(item:Object):String {
		if (item == null) { return ""; }
		if (_labelFunction != null) {
			return _labelFunction(item);
		} else if (_labelField != null && item[_labelField] != null) {
			return item[_labelField];
		}
		return item.toString();
	}
	
	public function getItemAt(index:Number):Object
	{
		if (index < 0 && index >= _dataProvider.length) { return; }
		return _dataProvider[index];
	}
	
	public function setItemAt(index:Number, value:Object):Void
	{
		if (index < 0 && index >= _dataProvider.length) { return; }
		var renderer:MovieClip = renderers[index];
		renderer.setData(value);
		
		var horizPadding:Number = paddingLeft + paddingRight + (margin * 2);
		var rendererWidth:Number = availableWidth - horizPadding;
		for (var i:Number=0; i<renderers.length; i++) {
			renderers[i]._x = margin + paddingLeft;
			renderers[i]._y = (i==0)?0:(renderers[i-1]._y + renderers[i-1]._height) + margin + paddingTop;
			if (index == i) { renderers[i].setSize(renderers[i]._width, renderers[i]._height); }			
		}
	}
	
	public function invalidateData():Void {
		_scrollPosition = Math.min(Math.max(-paddingTop, (contents._height + paddingBottom) - mask._height), _scrollPosition);
		selectedIndex = Math.min(_dataProvider.length-1, _selectedIndex);
		_dataProvider.requestItemRange(0, _dataProvider.length-1, this, "populateData");
		// Set pending items to "waiting" state.
	}
	
	public function get availableWidth():Number { 
		return autoScrollBar ? __width - _scrollBar._width : __width;
	}
	
	public function toString():String 
	{
		return "[Scaleform ObjectScrollingList " + _name + "]";
	}
	
	private function configUI():Void 
	{
		super.configUI();
		
		//Mouse.addListener(this);
		
		if (_selectedIndex > -1) { deferredScrollIndex = _selectedIndex; }
		
		constraints = new Constraints(this);
		constraints.addElement(mask, Constraints.ALL);
		
		_scrollPosition  = -paddingTop;
		
		if (inspectableScrollBar != '' && inspectableScrollBar != null) {
			scrollBar = inspectableScrollBar;
			inspectableScrollBar = null;
		}
	}
	
	private function createItemRenderer(index:Number):MovieClip {
		var clip:MovieClip = contents.attachMovie(_itemRenderer, "renderer"+index, index);
		if (clip == null) { return null; }
		setUpRenderer(clip);
		return clip;
	}
	
	private function setUpRenderer(clip:MovieClip):Void {
		clip.owner = this;
		clip.tabEnabled = false; // Children can still be tabEnabled, or the renderer could re-enable this.
		clip.doubleClickEnabled = true;
		clip.addEventListener("press", this, "dispatchItemEvent");
		clip.addEventListener("click", this, "handleItemClick");
		clip.addEventListener("doubleClick", this, "dispatchItemEvent");		
		clip.addEventListener("rollOver", this, "dispatchItemEvent");
		clip.addEventListener("rollOut", this, "dispatchItemEvent");
	}
	
	private function draw():Void 
	{
		constraints.update(__width, __height);
		totalRenderers = _dataProvider.length;
		drawRenderers(totalRenderers);
		invalidateData();
		drawLayout(availableWidth);
		setState();
		updateScrollBar();
		scrollToPosition();
		if (deferredScrollIndex != -1) {
			scrollToIndex(deferredScrollIndex);
			deferredScrollIndex = -1;
		}
	}
	
	private function drawRenderers(totalRenderers:Number):Void {
		// Remove extra renderers
		while (renderers.length > totalRenderers) {
			renderers.pop().removeMovieClip();
		}
		
		// Add new renderers
		while (renderers.length < totalRenderers) {
			renderers.push(createItemRenderer(renderers.length));
		}
	}	
	
	private function drawLayout(rendererWidth:Number):Void {
		var horizPadding:Number = paddingLeft + paddingRight + (margin * 2);
		rendererWidth = rendererWidth - horizPadding;
		for (var i:Number=0; i<renderers.length; i++) {
			renderers[i]._x = margin + paddingLeft;
			renderers[i]._y = (i==0)?0:(renderers[i-1]._y + renderers[i-1]._height) + margin + paddingTop;
			renderers[i].setSize(renderers[i]._width, renderers[i]._height);			
		}
		drawScrollBar();
	}
	
	private function drawScrollBar():Void {		
		if (!autoScrollBar) { return; }
		_scrollBar._x = __width - _scrollBar._width - margin;
		_scrollBar._y = margin;
		_scrollBar.height = __height - (margin * 2);
	}
	
	private function resetRenderers():Void {
		while (renderers.length > 0) { renderers.pop().removeMovieClip(); }
	}
	
	private function getRendererAt(index:Number):MovieClip {
		return renderers[index];
	}
	
	private function onResizeContents():Void
	{
		updateScrollBar();
		invalidatePosition();
	}
	
	private function onPosChangeContents(yPos:Number):Void
	{
		_scrollPosition = Math.max(-paddingTop, Math.min((contents._height + paddingBottom) - mask._height, Math.round(_scrollPosition - yPos)));
		updateScrollBar();
		scrollToPosition();
	}
	
	public function invalidatePosition():Void 
	{
		_scrollPosition = Math.min(Math.max(-paddingTop, (contents._height + paddingBottom) - mask._height), _scrollPosition);
		
		//if (-paddingTop == _scrollPosition) { trace("exist new"); } // 스크롤 맨위로 올라갔을 경우
		//if ((contents._height + paddingBottom) - mask._height == _scrollPosition) { trace("exist old"); } // 스크롤 맨아래로 내려갔을 경우
		
		scrollToPosition();
	}
	
	private function scrollToPosition():Void
	{
		//contents._y = -_scrollPosition;
		TweenMax.to(contents, 0.5, {_y:-_scrollPosition, ease:Cubic.easeOut});
	}
	
	private function updateScrollBar():Void 
	{		
		var max:Number = Math.max(-paddingTop, Math.floor((contents._height + paddingBottom) - mask._height));
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.setScrollProperties(mask._height*thumbSizeFactor, -paddingTop, max);
		} else {
			_scrollBar.minimum = -paddingTop;
			_scrollBar.maximum = max;
		}
		_scrollBar.position = _scrollPosition;
		_scrollBar.trackScrollPageSize = Math.max(1, mask._height);
	}
	
	private function handleScroll(event:Object):Void 
	{
		var newPosition:Number = event.target.position;
		if (isNaN(newPosition)) { return; }
		scrollPosition = newPosition;
	}
	
	private function onDataChange(event:Object):Void {
		// Full data refresh
		invalidateData();
	}
	
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
			index:event.target.index,
			controllerIdx: event.controllerIdx
		};
		dispatchEventAndSound(newEvent);	
	}
	
	private function handleItemClick(event:Object):Void {
		var index:Number = event.target.index;
		if (isNaN(index)) { return; } // If the data has not been populated, but the listItemRenderer is clicked, it will have no index.
		selectedIndex = index;
		dispatchItemEvent(event);		
	}
	
	private function populateData(data:Array):Void {
		for (var i:Number=0; i<renderers.length; i++) {
			var renderer:MovieClip = renderers[i];
			renderer.setListData(i, itemToLabel(data[i]), _selectedIndex == i); //LM: Consider passing renderer position also. (Support animation)
			renderer.setData(data[i]);
		}
		updateScrollBar();
	}
	
	private function scrollWheel(delta:Number):Void 
	{
		if (_disabled || scrollDisabled) { return; }
		scrollPosition = _scrollPosition - (delta * scrollingUnit);
	}
	
	private function setState():Void {
		tabEnabled = focusEnabled = !_disabled;
		gotoAndPlay(_disabled ? "disabled" : _focused ? "focused" : "default");		
		if (_scrollBar) { 
			_scrollBar.disabled =_disabled; 
			_scrollBar.tabEnabled = false;
		}
		for (var i:Number=0; i<renderers.length; i++) {
			renderers[i].disabled = _disabled;
			renderers[i].tabEnabled = false;
		}
	}
}
