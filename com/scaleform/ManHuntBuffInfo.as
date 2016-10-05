/**
 * ...
 * @author 
 */

import com.scaleform.ManHuntBeastChgCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ManHuntBuffInfo extends Panel
{
	public var buffInfoCont:MovieClip;
	
    public function ManHuntBuffInfo()
    {         
        super();
        
        buffInfoCont.subWeaponName.verticalAlign = "center";
        buffInfoCont.subWeaponName.textAutoSize = "shrink";
		buffInfoCont.subWeaponName.noTranslate = true;
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setBuff(beastType:String, subWeapnName:String):Void
	{
		buffInfoCont.classIcon.subWeaponMC.gotoAndStop(beastType);
		buffInfoCont.classIcon.gotoAndPlay("show");
		buffInfoCont.subWeaponName.text = subWeapnName;
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
		buffInfoCont.classIcon.gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		buffInfoCont.classIcon.subWeaponMC.gotoAndStop(1);
		buffInfoCont.classIcon.gotoAndStop(2);
		buffInfoCont.subWeaponName.text = "";
	}
}