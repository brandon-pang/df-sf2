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

class com.scaleform.udk.controls.ClanSettingInitListItem extends ListItemRenderer {
	private var _index:String;//리스트 번호
	private var _RankIndex:String;//계급인덱스
	private var _iconImgPath:String = "imgset_class.swf";	
	private var txt1:TextField;
	private var txt2:TextField;
	private var classicon:MovieClip;
	private var _hit:MovieClip;	
	private var initOkBtn:MovieClip;
	private var initCancleBtn:MovieClip;
	private var paperBtn:MovieClip;
	private var recomBtn:MovieClip;

	public function ClanSettingInitListItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		_index = data.Index;
		_RankIndex = data.RankIndex;
		txt1.text = data.CodeName;
		txt2.text = data.DateTimes;
		if(data.recom==""||data.recom=="0"||data.recom==null){
			paperBtn._visible=true
			recomBtn._visible=!true
		}else{
			paperBtn._visible=!true
			recomBtn._visible=true
		}

		lvLoader();
	}

	private function lvLoader() {
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(_iconImgPath,classicon);
	}

	private function onLoadInit(mc:MovieClip) {
		var lvNo:String = _RankIndex;
		if (lvNo != "" && lvNo != undefined) {			
			classicon.set_level(lvNo)
		}
	}
	public function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}
		validateNow();
		_index = data.Index;
		_RankIndex = data.RankIndex;
		txt1.text = data.CodeName;
		txt2.text = data.DateTimes;
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void {
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		paperBtn.addEventListener("click",this,"paperPress");
		recomBtn.addEventListener("click",this,"recomPress");
		initOkBtn.addEventListener("click",this,"okPress");
		initCancleBtn.addEventListener("click",this,"canclePress");
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw() {
		super.draw();

	}
	private function recomPress(e:Object):Void{
		_global.OnClanSettingInitRecomBtn(_index);
	}
	private function paperPress(e:Object):Void {
		//trace("신청서 보기"+index);
		_global.OnClanSettingInitPaperBtn(_index);
	}
	private function okPress(e:Object):Void {
		//trace("수락");
		_global.OnClanSettingInitinitOkBtn(_index);
	}
	private function canclePress(e:Object):Void {
		//trace("거절");
		_global.OnClanSettinginitCancleBtn(_index);
	}
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		setState("down");
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void {
		setState("release");
		handleClick(mouseIndex,button);
	}
}