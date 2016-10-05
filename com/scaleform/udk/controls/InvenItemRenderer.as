﻿/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.StatusIndicator;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.controls.Button;
import gfx.controls.CheckBox
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.controls.ScrollingList;
import mx.transitions.easing.Strong;
import gfx.motion.Tween;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.InvenItemRenderer extends ListItemRenderer
{

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var txt_type:TextField;
	private var txt_name:TextField;
	private var txt_weight:TextField;	
	private var txt_option:TextField;
	private var stat:StatusIndicator
	private var itemimg:MovieClip;
	private var rightBtn:Button;
	private var _hit:MovieClip;
	private var checkBox:CheckBox
	private var selectMc:MovieClip

	private var _type:String;
	private var _itemname:String;
	private var _weight:String;
	private var _option:String;

	private var _itemimg:String;
	private var _chk:String
	private var _stat:String

	private var selectedZ:Number = -300;
	private var arrow:MovieClip;
	private var normalZ:Number = this._parent._y;
	
	private var _chkValue:Array;
	// Initialization:

	public function InvenItemRenderer()
	{
		super();
		Tween.init();		
	}

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);
		trace(data.ClassIcon);

		_type = data.Type;
		_itemname = data.ItemName;
		_weight = data.Weight;
		_option = data.Option;
		//		
		_itemimg = data.ItemImg;		
		_chk = data.Chk;
		_stat=data.stat

		UpdateTextFields();
	}
	private function lvLoader()
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);		
		var cutChr:String = _itemimg.substring(0, 2);
		trace(cutChr);
		var imgPath:String;
		if (cutChr == "KA" || cutChr == "KG") {
			imgPath = "imgset_weapon.swf";
		} else {
			imgPath = "imgset_armor.swf";
		}
		mcLoader.loadClip(imgPath,itemimg);
		
	}

	private function onLoadInit(mc:MovieClip)
	{
		var imgName:String = _itemimg;
		itemimg.gotoAndStop(imgName);		
	}
	private function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized) {
			return;
		}
		//validateNow();// Ensure that the width/height is up to date.  

		//arrow._z = -450;
		//arrow._y = -50;
		//trace (_label)
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	// Public Methods:
	/** @exclude */
	public function toString():String
	{
		return "[Scaleform InvenItemRenderer "+_name+"]";
	}

	// Private Methods:    
	private function UpdateTextFields()
	{
		checkBox.disableFocus=true
		
		txt_type.htmlText = _type;
		txt_name.text = _itemname;
		txt_weight.text = _weight;
		txt_option.htmlText = _option;
		
		stat.value=Number(_stat)
		
		var boo:Boolean
		if (_chk == "0") {			
			boo = false;
			checkBox._alpha=100
			selectMc.gotoAndPlay(1)			
		}else {
			boo = true;	
			checkBox._alpha=0
			selectMc.gotoAndPlay("start")
		}		
		checkBox.selected=boo
		lvLoader()
		this._parent.gotoAndPlay("open")
	}

	private function configUI():Void
	{
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

		rightBtn.addEventListener("click", this, "onClickButton");
		
		checkBox.addEventListener("click", this, "onChkHandler")

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	

	public function draw()
	{
		super.draw();
		
	}

	public function onClickButton(e:Object):Void
	{
		trace (this.index)
		//trace(this._name.substring(4)+","+this._parent._name+"p_event.target._name:  "+this._parent.list.renderers[this._name.substring(3)].index);
	}
	
    private function onChkHandler(e:Object) {
		var boo:Number;
		if (e.target.selected) {			
			boo = 1			
		}else {
			boo = 0	
		}
		//this._parent.list._dataProvider[this.index].Chk = boo
		trace ("index:="+this.index+","+ boo)
		//
		_global.OnInvenChkData(this.index, boo);
	}
	
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		if (_disabled) {
			return;
		}
		if ((!_focused && !_displayFocus) || focusIndicator != null) {
			setState("over");
		}
		// Otherwise it is focused, and has no focusIndicator, so do nothing.       
		//dispatchEventAndSound({type:"rollOver", mouseIndex:mouseIndex});

		if ((!_focused && !_displayFocus) || focusIndicator != null) {
			Selection.setFocus(this);
		}
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});		
		handleClick(mouseIndex, button);
		//_hit.toggle = _hit.toggle;
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		//setState("release");
	}

	/*private function changeFocus():Void
	{
		if (_disabled) {
			return;
		}
		if (focusIndicator == null) {
			setState((_focused || _displayFocus) ? "over" : "out");
		}
		if (focusIndicator != null) {
			if (owner.focused && this.selected) {
				//focusIndicator.gotoAndPlay("show");
				//trace(MovieClip(this)._y);
				MovieClip(this).tweenTo(0.5,{_xscale:102, _yscale:102,_x:this._x},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			} else {
				//focusIndicator.gotoAndPlay("hide");
				MovieClip(this).tweenTo(0.4,{_xscale:100, _yscale:100,_x:this._x},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			}
			if (pressedByKeyboard && !_focused) {
				setState("kb_release");
				pressedByKeyboard = false;
			}
		}
	}*/
}