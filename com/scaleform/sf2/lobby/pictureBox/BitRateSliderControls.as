/**
 * ...
 * @author 
 */


import flash.external.ExternalInterface;
import gfx.controls.TextInput;
import gfx.controls.Slider;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "liveDragging", "minimum", "maximum", "value", "snapping", "snapInterval", "offsetLeft", "offsetRight", "enableInitCallback", "soundMap")]
class com.scaleform.sf2.lobby.pictureBox.BitRateSliderControls extends UIComponent
{
    public var slider:Slider
	public var inputText:TextInput
	
	public function BitRateSliderControls()
	{
		super();				
	}

	public function initValue(max:Number,min:Number,snap:Number)
	{
		slider.maximum=(max==""||max==null) ? 100 : max;
		slider.minimum=(min==""||min==null) ? 0 : min;
		slider.snapInterval=(snap==""||snap==null) ? 1 : snap;
	}

	public function setValue($sliderStat:Number){
		var v=$sliderStat;
		slider.value= v;
		inputText.text=v;
	}

	private function onChgSlider(e:Object){
		var v=e.target.value
		inputText.text=v;
		ExternalInterface.call(this._name+"_SliderValue",v)
	}

	private function onTxtChg(e:Object){
		var v=e.target.text
		slider.value=v;
		ExternalInterface.call(this._name+"_SliderValue",v)
	}
	
	private function configUI():Void
	{
		super.configUI();
		slider.disabled=false;	
		slider.addEventListener("change",this,"onChgSlider")
		inputText.addEventListener("textChange",this,"onTxtChg")
		
	}
}