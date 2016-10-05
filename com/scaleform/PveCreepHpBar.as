/**
 * ...
 * @author 
 */

import com.scaleform.PveCreepHpBarCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveCreepHpBar extends Panel
{
	public var hpBarCont:PveCreepHpBarCont;
	
    public function PveCreepHpBar()
    {         
        super();  
    }
	
	public function show(high:Number, middle:Number, low:Number):Void
	{
		if (high != null && middle != null && low != null && (high+middle+low == 100))
		{
			hpBarCont.high = high;
			hpBarCont.middle = middle;
			hpBarCont.low = low;
		}
		gotoAndPlay("show");
	}
	
	public function setName(value:String):Void
	{
		hpBarCont.setName(value);
	}
	
	public function setHp(hp:Number, totalHp:Number):Void
	{
		hpBarCont.setHp(hp, totalHp);
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
		hpBarCont.initCont();
	}
}