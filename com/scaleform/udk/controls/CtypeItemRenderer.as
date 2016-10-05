/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.controls.ScrollingList;
import mx.transitions.easing.Strong;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.CtypeItemRenderer extends ListItemRenderer
{

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var txt_0:TextField;
	private var txt_1:TextField;
	private var txt_2:TextField;
	private var txt_3:TextField;

	private var itemimg0:MovieClip;
	private var itemimg1:MovieClip;
	private var itemimg2:MovieClip;
	private var itemimg3:MovieClip;

	private var imgFlag:Boolean;

	private var _hit:MovieClip;

	private var _itemname0:String;
	private var _itemname1:String;
	private var _itemname2:String;
	private var _itemname3:String;

	private var _itemimg0:String;
	private var _itemimg1:String;
	private var _itemimg2:String;
	private var _itemimg3:String;

	public function CtypeItemRenderer()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);

		_itemname0 = data.ItemName0;
		_itemname1 = data.ItemName1;
		_itemname2 = data.ItemName2;
		_itemname3 = data.ItemName3;

		_itemimg0 = data.ItemImg0;
		_itemimg1 = data.ItemImg1;
		_itemimg2 = data.ItemImg2;
		_itemimg3 = data.ItemImg3;

		UpdateTextFields();
	}
	private function lvLoader(mc:MovieClip)
	{
		var n = mc._name.substring(7);
		trace(n);
		this["mcLoader" + n] = new MovieClipLoader();
		this["mcLoader" + n].addListener(this);
		if (imgFlag)
		{
			this["mcLoader" + n].loadClip("imgset_weapon.swf",mc);
		}
		else
		{
			this["mcLoader" + n].unloadClip(mc);
		}

	}

	private function onLoadInit(mc:MovieClip)
	{
		var str = mc._name.substring(7);
		trace(str);
		var imgName:String;
		switch (str)
		{
			case "0" :
				mc._xscale = 60;
				mc._yscale = 60;
				mc.gotoAndStop(_itemimg0);
				break;
			case "1" :
				mc._xscale = 60;
				mc._yscale = 60;
				mc.gotoAndStop(_itemimg1);
				break;
			case "2" :
				mc._xscale = 60;
				mc._yscale = 60;
				mc.gotoAndStop(_itemimg2);
				break;
			case "3" :
				mc._xscale = 60;
				mc._yscale = 60;
				mc.gotoAndStop(_itemimg3);
				break;
		}


	}
	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}
		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	// Public Methods:
	/** @exclude */
	public function toString():String
	{
		return "[Scaleform CtypeItemRenderer " + _name + "]";
	}

	// Private Methods:    
	private function UpdateTextFields()
	{

		if (_itemimg0 != "")
		{
			//itemimg0._visible = true;
			txt_0.text = _itemname0;
			imgFlag=true
			lvLoader(itemimg0);
		}
		else
		{
			txt_0.text = "";
			//itemimg0._visible = false;
			imgFlag=false
			lvLoader(itemimg0);
		}
		if (_itemimg1 != "")
		{
			//itemimg1._visible = true;
			txt_1.text = _itemname1;
			imgFlag=true
			lvLoader(itemimg1);
		}
		else
		{
			txt_1.text = "";
			//itemimg1._visible = false;
			imgFlag=false
			lvLoader(itemimg1);
		}
		if (_itemimg2 != "")
		{
			//itemimg2._visible = true;
			txt_2.text = _itemname2;
			imgFlag=true
			lvLoader(itemimg2);
		}
		else
		{
			txt_2.text = "";
			//itemimg2._visible = false;
			imgFlag=false
			lvLoader(itemimg2);
		}
		if (_itemimg3 != "")
		{
			//itemimg3._visible = true;
			txt_3.text = _itemname3;
			imgFlag=true
			lvLoader(itemimg3);
		}
		else
		{
			txt_3.text = "";
			imgFlag=false
			lvLoader(itemimg3);
		}

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
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

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
		if (_disabled)
		{
			return;
		}
		if ((!_focused && !_displayFocus) || focusIndicator != null)
		{
			setState("over");
		}
		// Otherwise it is focused, and has no focusIndicator, so do nothing.             
		//dispatchEventAndSound({type:"rollOver", mouseIndex:mouseIndex});

		if ((!_focused && !_displayFocus) || focusIndicator != null)
		{
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
		//handleClick(mouseIndex, button);
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