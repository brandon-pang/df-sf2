/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveCreepInfo extends Panel
{
	
	public var creepInfoCont:MovieClip;
	
    public function PveCreepInfo()
    {         
        super();
        
        creepInfoCont.txt0.noTranslate = true;
        creepInfoCont.txt1.noTranslate = true;
        creepInfoCont.txt2.noTranslate = true;
        creepInfoCont.txt3.noTranslate = true;
        
        creepInfoCont.txt0.text = "1";
        creepInfoCont.txt1.text = "2";
        creepInfoCont.txt2.text = "3";
        creepInfoCont.txt3.text = "4";
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setLevel(value:Number):Void
	{
		setCreepIcon(value);
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		
	}
	
	private function setCreepIcon(level:Number):Void
	{
		if (level == 0)
		{
			creepInfoCont.txt0._visible = true;
			creepInfoCont.txt1._visible = true;
			creepInfoCont.txt2._visible = true;
			creepInfoCont.txt3._visible = true;
			
			creepInfoCont.cross0.gotoAndStop(2);
			creepInfoCont.cross1.gotoAndStop(2);
			creepInfoCont.cross2.gotoAndStop(2);
			creepInfoCont.cross3.gotoAndStop(2);
			
			creepInfoCont.creep0._visible = true;
			creepInfoCont.creep1._visible = true;
			creepInfoCont.creep2._visible = true;
			creepInfoCont.creep3._visible = true;
			
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep1._alpha = 50;
			creepInfoCont.creep2._alpha = 50;
			creepInfoCont.creep3._alpha = 50;
			
			creepInfoCont.arrow1.gotoAndStop(2);
			creepInfoCont.arrow2.gotoAndStop(2);
			creepInfoCont.arrow3.gotoAndStop(2);
			
			creepInfoCont.arrow1._alpha = 50;
			creepInfoCont.arrow2._alpha = 50;
			creepInfoCont.arrow3._alpha = 50;
		}
		else if (level == 1)
		{
			creepInfoCont.txt0._visible = false;
			creepInfoCont.txt1._visible = true;
			creepInfoCont.txt2._visible = true;
			creepInfoCont.txt3._visible = true;
			
			creepInfoCont.cross0.gotoAndPlay("show");
			creepInfoCont.cross1.gotoAndStop(2);
			creepInfoCont.cross2.gotoAndStop(2);
			creepInfoCont.cross3.gotoAndStop(2);
			
			creepInfoCont.creep0._visible = false;
			creepInfoCont.creep1._visible = true;
			creepInfoCont.creep2._visible = true;
			creepInfoCont.creep3._visible = true;
			
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep2._alpha = 50;
			creepInfoCont.creep3._alpha = 50;
			
			creepInfoCont.arrow1.gotoAndPlay("show");
			creepInfoCont.arrow2.gotoAndStop(2);
			creepInfoCont.arrow3.gotoAndStop(2);
			
			creepInfoCont.arrow1._alpha = 100;
			creepInfoCont.arrow2._alpha = 50;
			creepInfoCont.arrow3._alpha = 50;
		}
		else if (level == 2)
		{
			creepInfoCont.txt0._visible = false;
			creepInfoCont.txt1._visible = false;
			creepInfoCont.txt2._visible = true;
			creepInfoCont.txt3._visible = true;
			
			creepInfoCont.cross0.gotoAndStop(12);
			creepInfoCont.cross1.gotoAndPlay("show");
			creepInfoCont.cross2.gotoAndStop(2);
			creepInfoCont.cross3.gotoAndStop(2);
			
			creepInfoCont.creep0._visible = false;
			creepInfoCont.creep1._visible = false;
			creepInfoCont.creep2._visible = true;
			creepInfoCont.creep3._visible = true;
			
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep2._alpha = 100;
			creepInfoCont.creep3._alpha = 50;
			
			creepInfoCont.arrow1.gotoAndStop(2);
			creepInfoCont.arrow2.gotoAndPlay("show");
			creepInfoCont.arrow3.gotoAndStop(2);
			
			creepInfoCont.arrow1._alpha = 50;
			creepInfoCont.arrow2._alpha = 100;
			creepInfoCont.arrow3._alpha = 50;
		}
		else if (level == 3)
		{
			creepInfoCont.txt0._visible = false;
			creepInfoCont.txt1._visible = false;
			creepInfoCont.txt2._visible = false;
			creepInfoCont.txt3._visible = true;
			
			creepInfoCont.cross0.gotoAndStop(12);
			creepInfoCont.cross1.gotoAndStop(12);
			creepInfoCont.cross2.gotoAndPlay("show");
			creepInfoCont.cross3.gotoAndStop(2);
			
			creepInfoCont.creep0._visible = false;
			creepInfoCont.creep1._visible = false;
			creepInfoCont.creep2._visible = false;
			creepInfoCont.creep3._visible = true;
			
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep2._alpha = 100;
			creepInfoCont.creep3._alpha = 100;
			
			creepInfoCont.arrow1.gotoAndStop(2);
			creepInfoCont.arrow2.gotoAndStop(2);
			creepInfoCont.arrow3.gotoAndPlay("show");
			
			creepInfoCont.arrow1._alpha = 50;
			creepInfoCont.arrow2._alpha = 50;
			creepInfoCont.arrow3._alpha = 100;
		}
		else if (level == 4)
		{
			creepInfoCont.txt0._visible = false;
			creepInfoCont.txt1._visible = false;
			creepInfoCont.txt2._visible = false;
			creepInfoCont.txt3._visible = false;
			
			creepInfoCont.cross0.gotoAndStop(12);
			creepInfoCont.cross1.gotoAndStop(12);
			creepInfoCont.cross2.gotoAndStop(12);
			creepInfoCont.cross3.gotoAndPlay("show");
			
			creepInfoCont.creep0._visible = false;
			creepInfoCont.creep1._visible = false;
			creepInfoCont.creep2._visible = false;
			creepInfoCont.creep3._visible = false;
			
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep1._alpha = 100;
			creepInfoCont.creep2._alpha = 100;
			creepInfoCont.creep3._alpha = 100;
			
			creepInfoCont.arrow1.gotoAndStop(2);
			creepInfoCont.arrow2.gotoAndStop(2);
			creepInfoCont.arrow3.gotoAndStop(2);
			
			creepInfoCont.arrow1._alpha = 50;
			creepInfoCont.arrow2._alpha = 50;
			creepInfoCont.arrow3._alpha = 50;
		}
		
	}
	
	
}