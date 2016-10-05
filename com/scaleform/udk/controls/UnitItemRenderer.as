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
import gfx.controls.Button;
import gfx.controls.CheckBox
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import mx.transitions.easing.Strong;
import gfx.motion.Tween;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.UnitItemRenderer extends ListItemRenderer
{

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var unit_text:TextField;
	private var unit_line:MovieClip;
	private var unit_img:MovieClip;

	private var _hit:MovieClip;
	
	private var _text:String;
	private var _img:String;
	private var _line:String;
	
	//var owner:ScrollingList;
	//var selectedZ:Number = -300;
	private var selectedZ:Number = -300;
	private var arrow:MovieClip;
	private var normalZ:Number = this._parent._y;

	// Initialization:

	public function UnitItemRenderer()
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

		_text = data.Text
		_img = data.Img;
		_line = data.Line;

		UpdateTextFields();
	}
	private function lvLoader(caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);				
		mcLoader.loadClip("imgset_armor.swf",unit_img);		
	}
	private function onLoadInit(mc:MovieClip)
	{		
		var imgName:String = _img
		unit_img.gotoAndStop(imgName);		
		unit_img._xscale=60
		unit_img._yscale=60
	}
	private function updateAfterStateChange():Void
	{	
		if (!initialized) {
			return;
		}
	
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	// Private Methods:    
	private function UpdateTextFields()
	{
		unit_text.htmlText = _text;
		if (_line == "1") {
			unit_line._visible = true;
		} else {			
			unit_line._visible = false;
		}		
		lvLoader()
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
        
		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	public function handleInput(details:InputDetails, pathToFocus:Array):Boolean
	{
		var nextItem:MovieClip = MovieClip(pathToFocus.shift());

		var handled:Boolean;
		if (nextItem != null) {
			handled = nextItem.handleInput(details, pathToFocus);
			if (handled) {
				return true;
			}
		}

		if (details.navEquivalent == "enter") {
			handled = false;
			if (handled) {
				return true;
			}
		}

		if (details.navEquivalent == "left") {
		}

		{
			handled = false;
			if (handled) {
				return true;
			}
		};
		return false;// or true if handled
	}

	public function draw()
	{
		super.draw();
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
		handleClick(mouseIndex,button);
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		//setState("release");
	}

	private function changeFocus():Void
	{
		if (_disabled) {
			return;
		}
		if (focusIndicator == null) {
			setState((_focused || _displayFocus) ? "over" : "out");
		}
		if (focusIndicator != null) {
			if (owner.focused && this.selected) {
				focusIndicator.gotoAndPlay("show");
				//trace(MovieClip(this)._y);
				MovieClip(this).tweenTo(0.5,{_xscale:102, _yscale:102},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			} else {
				focusIndicator.gotoAndPlay("hide");
				MovieClip(this).tweenTo(0.4,{_xscale:100, _yscale:100},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			}
			if (pressedByKeyboard && !_focused) {
				setState("kb_release");
				pressedByKeyboard = false;
			}
		}
	}
}