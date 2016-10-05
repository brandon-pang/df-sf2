/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorPlayTimer extends Panel
{
	
	public var playTimerCont:MovieClip;
	
    public function WarriorPlayTimer()
    {         
        super();
        
        playTimerCont.timeTxt.noTranslate = true;
		playTimerCont.timeTxt.verticalAlign = "center";
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setTime(time:String, status:Number):Void
	{
		playTimerCont.timeTxt.text = time;
		
		if (status == 0)
		{
			playTimerCont.timeTxt.textColor = 0xffffff;
			playTimerCont.bg.gotoAndStop(1);
		}
		else if (status == 1)
		{
			playTimerCont.timeTxt.textColor = 0xde0000;
			playTimerCont.bg.gotoAndStop(2);
		}
		
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
}