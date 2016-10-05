/**
 * ...
 * @author 
 */

import com.scaleform.PveMoneyInfoCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveMoneyInfo extends Panel
{
	public var moneyInfoCont:PveMoneyInfoCont;
	
    public function PveMoneyInfo()
    {         
        super();  
    }
	
	public function show(value:Number):Void
	{
		moneyInfoCont.setMoney(value);
		gotoAndPlay("show");
	}
	
	public function changeMoney(value:Number):Void
	{
		moneyInfoCont.changeMoney(value);
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
		moneyInfoCont.initCont();
	}
}