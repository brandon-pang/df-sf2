import gfx.controls.ScrollingList;
import gfx.controls.ListItemRenderer;
import mx.transitions.easing.Strong;
import gfx.motion.Tween;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.FocusItemRenderer extends ListItemRenderer
{

	var owner:ScrollingList;
	//var selectedZ:Number = -300;
	var selectedZ:Number = -300;
	var arrow:MovieClip;
	var normalZ:Number = this._parent._y

	public function FocusItemRenderer()
	{
		super();
		Tween.init();
	}

	public function setListData(index:Number, label:String, selected:Boolean):Void
	{
		super.setListData(index,label,selected);
	}

	// A public version of parent method updateAfterStateChange() (Button.as).
	public function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized) {
			return;
		}
		validateNow();// Ensure that the width/height is up to date.

		//arrow._z = -450;
		//arrow._y = -50;
        //trace (_label)
		
		if (textField != null && _label != null) {
			textField.text = _label;
		}
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	public function setData(data:Object):Void
	{
		// If we received null data, hide this renderer.

		if (data == undefined) {
			this._visible = false;
			return;
		}

		this.data = data;
		invalidate();
		this._visible = true;
	}

	// Overides handleMouseRollOver to include Selection.setFocus(this) when appropriate.
	// #state RollOver is only called by mouse interaction. Focus change happens in changeFocus.
	private function handleMouseRollOver(mouseIndex:Number):Void
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

	/*
	     * Customized logic in changeFocus() to:
	     * A. Display a focusIndicator.
	     * B. Tween on the Z.
	     */
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
				trace (MovieClip(this)._y)
				MovieClip(this).tweenTo(0.5,{_xscale:102,_yscale:102,_x:-5},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			} else {
				focusIndicator.gotoAndPlay("hide");
				MovieClip(this).tweenTo(0.4,{_xscale:100,_yscale:100,_x:0},Strong.easeOut);
				//MovieClip(this).tweenTo(0.5,{_z:selectedZ},Strong.easeOut);
			}
			if (pressedByKeyboard && !_focused) {
				setState("kb_release");
				pressedByKeyboard = false;
			}
		}
	}
}