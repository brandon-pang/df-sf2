/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.controls.Button;
import gfx.controls.CoreList;
import gfx.utils.Constraints;
import gfx.utils.Delegate;

class com.scaleform.udk.controls.MsnChatListRenderer extends ListItemRenderer
{
	/*int idx 창 idx
	string UserName 이름
	string UserImage 개인 이미지
	string msg 메시지
	string time 입력한 시간*/


	private var imgNick:MovieClip;

	private var txtName:TextField;
	private var txtMsg:TextField;
    private var txtTime:TextField;
	private var _imgNick:String;
	private var _idx:String;
	private var _msgTime:String;

	//private var userImgPath:String = "gfx_imgset_personal_small.swf";

	private var _hit:MovieClip;

	// Initialization:
	public function MsnChatListRenderer()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;
		
		
		txtName.noTranslate=true
		txtMsg.noTranslate=true
    	txtTime.noTranslate=true
	
		txtTime._visible=false
		_idx = data.idx;
		txtName.htmlText = data.username;
		_imgNick = data.userimage;
		txtMsg.text = data.msg;
		txtTime.text=data.time
		var userImgPath="img://Imgset_Personal."+data.userimage
		lvLoader(userImgPath,imgNick);
		
	}


	private function updateAfterStateChange():Void
	{
		txtTime._visible=false
		_idx = data.idx;
		txtName.htmlText = data.username;
		_imgNick = data.userimage;
		txtMsg.text = data.msg;
		txtTime.text=data.time
		var userImgPath="img://Imgset_Personal."+data.userimage
		lvLoader(userImgPath,imgNick);
	}

	private function lvLoader(imgPath:String, imgMc:MovieClip)
	{
		var ImgMc = imgMc;
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPath,imgMc);
	}

	private function onLoadInit(mc:MovieClip)
	{
		mc._width=mc._height=48
	}

	private function configUI():Void
	{
		constraints = new Constraints(this, true);

		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}

		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		/*
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	public function draw()
	{
		super.draw();
	}

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		//
		var root:MovieClip = _parent._parent._parent._parent._parent._parent._parent;
		txtTime._visible=true
	}


	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{		
		txtTime._visible=false
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		var root:MovieClip = _parent._parent._parent._parent._parent._parent._parent;
	}
	/*
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
	//---------------------------------------------- 비어있을때 안되게
	//if(_codename.length > 0) {
	targetMc.gotoAndPlay("up");
	//}
	
	if(_mechk=="1"){
	setTextColors(0xfff696);
	}else{
	if(_mastericon == "0"){
	setTextColors(0xdcdcdc);
	}else{
	setTextColors(0xffffff);
	}
	}
	
	}
	private function handleReleaseOutside(mouseIndex:Number, button:Number):Void
	{
	delete onMouseUp;
	targetMc.gotoAndPlay("out");
	if(_mechk=="1"){
	setTextColors(0xe7c486);
	}else{
	if(_mastericon == "0"){
	setTextColors(0x828282);
	}else{
	setTextColors(0xffffff);
	}
	}
	}*/
	/*private function handleMouseUp(btn, target, idx):Void
	{
	clickValue = this._name.substring(4);
	if (_codename != "")
	{
	trace("Mouse Click Number: " + btn + "," + clickValue);
	_global.OnSlotListPress(Number(clickValue) - 1,btn);
	
	//this._parent._parent._parent._parent.setRightMenuDp((this.index)+1,["ID 카드보기","강퇴하기"])
	}
	else
	{
	trace("Mouse Click None Number: " + btn + "," + clickValue);
	_global.OnSlotBtnPress(Number(clickValue) - 1,btn);
	}
	if(btn==2){
	trace(_root._name)
	_root.setRightMenuDp(clickValue,["ID 카드보기","강퇴하기"])
	}
	if(_mechk=="1"){
	setTextColors(0xe7c486);
	}else{
	if(_mastericon == "0"){
	setTextColors(0x828282);
	}else{
	setTextColors(0xffffff);
	}
	}
	}*/
}