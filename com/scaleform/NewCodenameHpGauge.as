/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.EventDialogContents;
import gfx.controls.StatusIndicator;

[InspectableList("disabled", "visible", "minimum", "maximum", "value", "overWall", "enableInitCallback")]
class com.scaleform.NewCodenameHpGauge extends StatusIndicator
{
	public var gauge:MovieClip;
	public var arrow:MovieClip;
	
	private var _overWall:Boolean = false;
	
	public function NewCodenameHpGauge()
	{         
		super();  
	}
    
    [Inspectable(defaultValue="0")]
	public function get value():Number { return _value; }
	public function set value(value:Number):Void {
		//if (value == this.value) { return; }
		var range = Math.max(_minimum, Math.min(_maximum, value));
		if (_value == range) { return; } 
		_value = range;
		updatePosition();
	}
    
    [Inspectable(defaultValue="false")]
	public function get overWall():Boolean { return _overWall; }
	public function set overWall(value:Boolean):Void
	{
		if (_overWall == value) { return; }
		_overWall = value;
		if (_overWall) { gauge.gotoAndStop(2); arrow._visible = false; }
		else { gauge.gotoAndStop(1); arrow._visible = true; }
	}
    
    private function configUI():Void
    {
    	super.configUI();
    	
	}
	
	private function updatePosition():Void
	{
		if (_disabled) { return; }
		var percent:Number = (_value - _minimum) / (_maximum - _minimum);
		gauge._xscale = Math.max(0, Math.round(percent * 100));
	}
}