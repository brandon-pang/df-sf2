/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.Button;
import gfx.controls.UILoader;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.MiniGameItem extends ListItemRenderer {

	
	//타이틀 튜토리얼 // 미니게임 // 커밍순
	private var txtTitle:MovieClip;
	private var txtTitle2:MovieClip;
	//타이틀 부분 배경
	private var txtTapBg:MovieClip;
	//상단 설명 제목
	private var txtTopContext:MovieClip;
	//점수내용
	private var txtScore:MovieClip;
	//상단 설명 내용
	private var txtContent:MovieClip;


	//콤보박스
	private var cbMap:MovieClip;
	//콤보박스 배경
	//private var imgbox:MovieClip;
	//버튼색상
	private var btnStart:MovieClip;
	//배경 모양
	private var line:MovieClip;
	private var imgName:String;	
	public var imgbox:UILoader;
	
	private var mapNumberMC:MovieClip;
	
	public function MiniGameItem() {
		super();
	}

	public function setData(data:Object):Void {		
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;		
		
		if (data.BackGround != "0") {
			setVisible(true);
			txtTitle2._visible = false;
			txtTitle.text = data.Title;
			txtTapBg.gotoAndStop(Number(data.BackGround)+1);
			txtTopContext.text = data.ContextTitle;
			txtScore.htmlText = data.Score;
			txtContent.text = data.Context;
						
			if (data.CbTxt != "") {
				cbMap._visible = true;
				cbMap["mapCB"].label = data.CbTxt;
			} else {
				cbMap._visible = false;
			}
			//imgbox._visible = true
			lvLoader(data.BgImgName);
		} else {
			setVisible(false);
			txtTitle2._visible = true;
			txtTitle2.text = data.Title;
		}
		
		//---- 노출하는 리스트 갯수 표시하기 4월 4일 추가
		if (data.MapNumber != "0" && data.MapNumber != null && data.MapNumber != undefined) {
			mapNumberMC._visible = true;
			mapNumberMC.textField.text = data.MapNumber;
			
		} else {
			mapNumberMC._visible = false;
		}
		//invalidate();
	}
	private function lvLoader(n:String) {
		imgName = n;
		var imgPath
		if(imgName==undefined){
			imgPath=""
		}else{
			imgPath="img://Imgset_Map."+imgName
		}		
		imgbox.source = imgPath
	}

	private function onLoaderComplete(e:Object):Void
	{
		//mc.gotoAndStop(imgName);
		//e.target.x=-40
		//mc._height=220
	}

	private function updateAfterStateChange():Void {
		if (data.BackGround != "0") {
			setVisible(true);
			txtTitle2._visible = false;
			txtTitle.text = data.Title;
			txtTapBg.gotoAndStop(Number(data.BackGround)+1);
			txtTopContext.text = data.ContextTitle;
			txtScore.htmlText = data.Score;
			txtContent.text = data.Context;
			
			if (data.CbTxt != "") {
				cbMap._visible = true;
				cbMap["mapCB"].label = data.CbTxt;
			} else {
				cbMap._visible = false;
			}
			lvLoader(data.BgImgName);

		} else {
			setVisible(false);
			txtTitle2._visible = true;
			txtTitle2.text = data.Title;
		}
	}


	private function setVisible(boo:Boolean):Void {
		txtTitle._visible = boo;
		txtTapBg._visible = boo;
		txtTopContext._visible = boo;
		txtScore._visible = boo;
		txtContent._visible = boo;
		cbMap._visible = boo;
		
		line._visible = boo;
		//btnSet._visible = boo;
	}

	private function configUI():Void {
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		
		//_hit.onRollOver = Delegate.create(this, handleMouseRollOver);      
		//_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		//_hit.onPress = Delegate.create(this, handleMousePress);
		//_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.onDragOver = Delegate.create(this, handleDragOver);
		//_hit.onDragOut = Delegate.create(this, handleDragOut);
		//_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		
		cbMap["mapCB"].addEventListener("click",this,"onMapCbRelease");
		//cbMap["mapCB"].addEventListener("rollOver",this,"onMapCbOver");
		btnStart.addEventListener("click",this,"onClickButton");		
		
		imgbox.addEventListener("complete", this, "onLoaderComplete");
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw() {
		super.draw();
	}
	
	public function onClickButton(e:Object):Void {
		//trace (this.index);
		_global.OnMiniGameStartClick(this.index);
	}
	
	/*public function onMapCbOver(e:Object) {
		//cbMap["mapCB"].textField.text = data.CbTxt;
	}*/
	
	public function onMapCbRelease(e:Object) {
		var arrowPoz:Object = {x:0, y:0};
		this.localToGlobal (arrowPoz);	
		
		//trace (Math.ceil(arrowPoz.x) + " , " + arrowPoz.y);	
		var root = _parent._parent._parent._parent._parent;
		var _level0 = _parent._parent._parent._parent._parent._parent._parent
		_level0.minigame_arrowPoz(arrowPoz.x,arrowPoz.y)
		_level0.minigame_GetMapDp(this.index)
		
		if (e.target.selected) {
			/*for(var i:Number=0;i<root.mapSelectMc.mapList.dataProvider.length;i++){
				trace ("++++++++++++"+i)
				if(root.mapSelectMc.mapList.dataProvider[i].Title==e.target.textField.text){
					root.mapSelectMc.mapList.selectedIndex=i
				}
			}*/
			root.mapSelectMc._visible = true;
			root.mapSelectMc.noBtn._x = -600;
			root.mapSelectMc.noBtn.onRelease = function() {
				trace("xxxx");
				root.mapSelectMc._visible = false;
				e.target.selected = false;
				root.mapSelectMc.noBtn._x = 0;
			};
			_level0.setMapCbIndex(this.index)
		} else {
			root.mapSelectMc._visible = false;
			root.mapSelectMc.noBtn._x = 0;
			root.mapSelectMc._visible = false;
			delete root.mapSelectMc.noBtn.onRelease;			
		}
	}
}