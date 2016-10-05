/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveModeInfo extends Panel
{
	public var wave:MovieClip;
	public var totalWave:MovieClip;
	
	
    public function PveModeInfo()
    {         
        super();  
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
		_parent.pve_Linetop.gotoAndPlay("open");
	}
	
	public function setDifficulty(value:String):Void
	{
		wave.difficultyTxt.text = value;
	}
	
	public function setWave(value:Number):Void
	{
		wave.waveTxt.waveTxtMC.textField.text = value.toString();
		wave.waveTxt.gotoAndPlay("show");
	}
	
	public function setTotalWave(value:Number):Void
	{
		totalWave.textField.text = value.toString();
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
		_parent.pve_Linetop.gotoAndPlay(1);
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		wave.difficultyTxt.text = "";
		wave.waveTxt.waveTxtMC.textField.text = "";
		totalWave.textField.text = "";
	}
}