/**
 * ...
 * @author 
 */

import com.scaleform.TeamMemberItem;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.CreepInfoBoard extends Panel
{
	public var item:TeamMemberItem;
	
    public function CreepInfoBoard()
    {         
        super();  
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setItemData(data:Object):Void
	{
		item.setData(data);
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
		item.initItem();
	}
}