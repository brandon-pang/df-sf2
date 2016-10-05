/**
 * ...
 * @author 
 */

import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.PveWaveSpeedCont extends UIComponent
{
	public var waveSpeedMC:MovieClip;
	
    public function PveWaveSpeedCont()
    {         
        super();
        
        waveSpeedMC.xTxt.noTranslate = true;
		waveSpeedMC.xTxt.verticalAlign = "center";
		waveSpeedMC.speedTxt.noTranslate = true;
		waveSpeedMC.speedTxt.verticalAlign = "center";
		waveSpeedMC.xTxt.textAutoSize = "shrink";
		waveSpeedMC.speedTxt.textAutoSize = "shrink";
    }
	
	public function initCont():Void
	{
		waveSpeedMC.effect.gotoAndStop(2);
		waveSpeedMC.radar.gotoAndStop(2);
		waveSpeedMC.speedTxt.text = "";
		waveSpeedMC.xTxt.text = "";
	}
	
	public function setSpeed(speed:Number):Void
	{
		waveSpeedMC.speedTxt.text = speed.toString();
		waveSpeedMC.xTxt.text = "x";
		waveSpeedMC.effect.gotoAndPlay("show");
		waveSpeedMC.radar.gotoAndPlay("show");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
	
	
}