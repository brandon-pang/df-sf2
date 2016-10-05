import gfx.controls.CheckBox;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;


class com.scaleform.ClanAdminDataGridItem2 extends ListItemRenderer
{

	public var field1:TextField;// Pass
	public var field2:TextField;// diff
	public var field3:TextField;// no
	public var field4:TextField;// stat
	public var field5:TextField;// subject
	public var field6:TextField;// subject

	public var _checkbox:CheckBox;
	var _hit:MovieClip;

	private function ClanAdminDataGridItem2()
	{
		super();
	}

	// Public Methods:
	public function setData(data:Object):Void
	{

		//trace(data.subscribe);

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		field1.text = data.checkbox;
		field2.text = data.lv;
		field3.text = data.codeName;
		field4.text = data.grade;
		field5.text = data.joinDate;
		field6.text = data.lastDate;

		invalidate();

	}

	/*private function updateAfterStateChange():Void
	{
	if (!initialized) {
	return;
	}
	validateNow();
	
	field1.text = data.checkbox;
	field2.text = data.lv;
	field3.text = data.codeName;
	field4.text = data.grade;
	field5.text = data.joinDate;
	field6.text = data.lastDate;
	
	if (constraints != null) {
	constraints.update(width,height);
	}
	dispatchEvent({type:"stateChange", state:state});
	}*/
	// Private Methods: 
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

		_checkbox.addEventListener("click",this,"onClickCheckbox");

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
		//===========================
		var chk:Boolean;
		if (data.checkbox == "0") {
			chk = false;
		} else {
			chk = true;
		}		
		_checkbox.selected = chk;
		
	}

	public function onClickCheckbox(p_event:Object):Void
	{
		trace("p_event.target.selected:  "+p_event.target.selected);
		trace("p_event.target._name:  "+this.data);
		//trace("p_event.target._name:  " + _root.listArray[1]);
		var chk:String;
		if (p_event.target.selected == true) {
			chk = "1";
		} else {
			chk = "0";
		}
		data.checkbox = chk;
	}
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		setState("release");
		handleClick(mouseIndex,button);
	}
}