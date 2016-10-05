/**
 * ...
 * @author 
 */

import gfx.controls.StatusIndicator;

[InspectableList("disabled", "visible", "minimum", "maximum", "value", "enableInitCallback")]
class com.scaleform.StatusIndicatorEx extends StatusIndicator
{
	
	public var bar:MovieClip;
	
	private var _barWidth:Number;
	
    public function StatusIndicatorEx()
    {         
        super();
        _barWidth = bar._width;
    }
	
	private function updatePosition():Void 
	{
		if (_disabled) { return; }
		var percent:Number = (_value - _minimum) / (_maximum - _minimum);
		bar._width = Math.min(_barWidth, Math.round(percent * _barWidth));
	}
}