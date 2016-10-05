/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMaskPerFrame;
import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.sf2.hud.shooter.ShooterPlayerInfoSlot extends UIComponent
{
	public var imgIcon:MovieClip;
	public var coolDown:MovieClip;
	public var coolTxt:TextField;
	
	public var _dead:Boolean = false;
	
	private var coolDownMask:CoolDownMaskPerFrame;
	
    public function ShooterPlayerInfoSlot()
    {         
        super();
        coolTxt.noTranslate = true;
		coolTxt.verticalAlign = "center";
    }
	
	public function setCoolDown(deltaTime:Number, coolTime:Number):Void
	{
		coolDownMask.start(deltaTime, coolTime);
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		coolDownMask = new CoolDownMaskPerFrame(coolDown, 77, 77, false);
		coolDownMask.setMaskColor(0x1d000050, 0x1d000050, 0);
		coolDownMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");
	}
	
	private function onCoolDownEnd():Void
	{
		coolTxt.text = "";
		this.gotoAndPlay("show");
	}
	
	private function onCoolDownProgress(e:Object):Void
	{
		var time:Number = Math.round(e.remainTime/1000);
		coolTxt.text = time.toString();
	}
	
	
}