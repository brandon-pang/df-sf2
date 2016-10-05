/**
 * ...
 * @author 
 */

import com.scaleform.TeamMemberItems;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.TeamMemberBoard extends Panel
{
	public var board:TeamMemberItems;
	
    public function TeamMemberBoard()
    {         
        super();  
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setItemData(index:Number, data:Object):Void
	{
		board.setItemData(index, data);
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
		board.initItems();
	}
}