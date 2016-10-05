/**
 * ...
 * @author 
 */

import com.scaleform.ManHuntBeastChgCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ManHuntBeastChg extends Panel
{
	public var beastChgCont:ManHuntBeastChgCont;
	
	private var shortCut:Array = ["F1", "F2", "F3"];
	
    public function ManHuntBeastChg()
    {         
        super();
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setItem(slot:Number, beastType:String, beastName:String, weaponType:String, mainWeapon:String, subWeapon:String):Void
	{
		beastChgCont.setItem(slot, beastType, beastName, weaponType, mainWeapon, subWeapon, shortCut[slot]);
	}
	
	public function setSelectIndex(slot:Number):Void
	{
		beastChgCont.setSelectIndex(slot);
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
		//beastChgCont.initCont();
	}
}