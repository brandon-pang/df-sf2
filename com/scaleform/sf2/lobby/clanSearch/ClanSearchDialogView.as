/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogView extends View
{
	public static var viewName:String = "ClanSearchDialogView";
	public var container:ClanSearchDialogCont;
	
	public function ClanSearchDialogView()
	{
		super(); 
        trace(viewName + " initialized.");
	}
	
	public function openInit():Void
    {
    	this._visible = true;
    	container.gotoAndPlay("open");			
    }
    
    public function closeInit():Void
    {
    	container.gotoAndPlay("close");		
    }   
    //===========================
    //
    //===========================
    public function SetTagBox($array:Array){
    	container.clanSearchWnd.SetTagBox($array)
    }
    //===========================
	// Set btn mapSelect 
	//===========================
	public function SetMapData($mapName:String,$mapImg:String){
		trace ("MapData Container"+[$mapName,$mapImg])
		container.clanSearchWnd.SetMapData($mapName,$mapImg)
	}
	//end========================

	//===========================
	// Set btn modeSelect
	//===========================
	public function SetModeData($modeName:String,$modeImg:String){
		container.clanSearchWnd.SetModeData($modeName,$modeImg)
	} 
	
    private function configUI():Void {
    	super.configUI();
    	
    	this._visible = false;
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_clan_search");
		ScrollWheelManager.registerList(container.clanSearchWnd.SetMapMc.List_mapSet.List_map, "ClanSearchDialog");
        ScrollWheelManager.registerList(container.clanSearchWnd.SetModeMc.List_modeSet.List_mode, "ClanSearchDialog");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_clan_search");
		ScrollWheelManager.unregisterNameTag("ClanSearchDialog");
	}
	
}