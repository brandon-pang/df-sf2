/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMaskPerFrame;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ManHuntWeaponInfo extends Panel
{
	public var weaponInfoCont:MovieClip;
	
	private var coolDownMask:CoolDownMaskPerFrame;
	
    public function ManHuntWeaponInfo()
    {         
        super();
		
		weaponInfoCont.coolTxt.verticalAlign = "center";
		weaponInfoCont.coolTxt.textAutoSize = "shrink";
		weaponInfoCont.coolTxt.noTranslate = true;
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setClass(value:String):Void
	{
		weaponInfoCont.coolTxt.text = "";
		coolDownMask.reset();
		weaponInfoCont.mainWeapon.gotoAndStop(value);
		weaponInfoCont.subWeapon.subWeaponMC.gotoAndStop(value); 
	}
	
	public function setBuffItem(itemName:String):Void
	{	
		if (itemName != null && itemName != "")
		{
			weaponInfoCont.buffItem._visible = true;
			var mcLoader:MovieClipLoader = new MovieClipLoader();
			mcLoader.loadClip("img://Imgset_CashItem."+itemName, weaponInfoCont.buffItem.imgIcon);
		}
		else
		{
			weaponInfoCont.buffItem._visible = false;
		}
	}
	
	public function coolDown(deltaTime:Number, coolTime:Number):Void
	{
		coolDownMask.start(deltaTime, coolTime);
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
		
		coolDownMask = new CoolDownMaskPerFrame(weaponInfoCont.coolDown, 41, 42, false);
		coolDownMask.setMaskColor(0x98000040, 0x98000040, 0);
		coolDownMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");
		
		weaponInfoCont.buffItem._visible = false;
	}
	
	private function onCloseEnd():Void
	{
		weaponInfoCont.mainWeapon.gotoAndStop(1);
		weaponInfoCont.subWeapon.subWeaponMC.gotoAndStop(1);
		weaponInfoCont.coolTxt.text = "";
		weaponInfoCont.buffItem._visible = false;
		weaponInfoCont.buffItem._alpha = 100;
		coolDownMask.reset();
	}
	
	private function onCoolDownEnd():Void
	{
		weaponInfoCont.coolTxt.text = "";
		weaponInfoCont.subWeapon.gotoAndPlay("show");
	}
	
	private function onCoolDownProgress(e:Object):Void
	{
		var time:Number = Math.round(e.remainTime/1000);
		weaponInfoCont.coolTxt.text = time.toString();
	}
}