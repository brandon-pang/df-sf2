/**
 * ...
 * @author 
 */


import flash.external.ExternalInterface;
import gfx.controls.TextInput;
import gfx.controls.Slider;
import gfx.controls.Button;
import gfx.core.UIComponent;


class com.scaleform.sf2.lobby.pictureBox.VolumeSliderControls extends UIComponent
{
	public var btn:Button
    public var slider:Slider
	public var inputText:TextInput
	
	public function VolumeSliderControls()
	{
		super();

	}
	public  function initValue(max:Number,min:Number,snap:Number)
	{
		slider.maximum=(max==""||max==null) ? 100 : max;
		slider.minimum=(min==""||min==null) ? 0 : min;
		slider.snapInterval=(snap==""||snap==null) ? 1 : snap;
	}

	public function setValue($btnStat:Boolean,$sliderStat:Number){
		var v=$sliderStat;
		var b=$btnStat;
		btn.selected=b;
		slider.disabled=b;
		inputText.disabled=b;
		slider.value= v;
		inputText.text=v;
	}

	private function onBtnClick(e:Object){
		slider.disabled=btn.selected
		inputText.disabled=btn.selected
		trace (btn.selected)
		ExternalInterface.call(this._name+"_BtnEnable",btn.selected)
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
		btn.addEventListener("click",this,"onBtnClick")
		slider.addEventListener("change",this,"onChgSlider")
		inputText.addEventListener("textChange",this,"onTxtChg")
	}
}