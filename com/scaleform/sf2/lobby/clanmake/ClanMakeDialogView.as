/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.clanmake.ClanMakeDialogCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.clanmake.ClanMakeDialogView extends View
{
	public static var viewName:String = "ClanMakeDialogView";
	public var container:ClanMakeDialogCont;
	
	public function ClanMakeDialogView()
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
    public function SetTagBox($array:Array){
    	container.clanMakeWnd.SetTagBox($array)
    }
    //===========================
	// Set Top TextField
	//===========================
	public function SetTxtChkContents($value:String){
		container.SetTxtChkContents($value)
	}

	//===========================
	// Set bottom TextField
	//===========================
	public function SetTxtAlertContents($str:String, $cash:String){
		container.SetTxtAlertContents($str, $cash)
	}

    //===========================
	// Set btn mapSelect 
	//===========================
	public function SetMapData($mapName:String,$mapImg:String){
		trace ("ClanMakeDialogView MapData view"+[$mapName,$mapImg])
		container.clanMakeWnd.SetMapData($mapName,$mapImg)
	}
	//end========================

	//===========================
	// Set btn modeSelect
	//===========================
	public function SetModeData($modeName:String,$modeImg:String){
		container.clanMakeWnd.SetModeData($modeName,$modeImg)
	} 
	
    private function configUI():Void {
    	super.configUI();
    	
    	this._visible = false;
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_clanmake_new");
		ScrollWheelManager.registerList(container.clanMakeWnd.SetMapMc.List_mapSet.List_map, "ClanMakeDialog");
        ScrollWheelManager.registerList(container.clanMakeWnd.SetModeMc.List_modeSet.List_mode, "ClanMakeDialog");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_clanmake_new");
		ScrollWheelManager.unregisterNameTag("ClanMakeDialog");
	}
	
}