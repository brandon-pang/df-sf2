/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogWnd
 
class com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogCont extends UIComponent
{
    public var clanSearchWnd:ClanSearchDialogWnd;
    
    public function ClanSearchDialogCont() {         
        super();  
    }
   
    //===========================
	// Set btn mapSelect 
	//===========================
	/*public function SetMapData($mapName:String,$mapImg:String){
		clanSearchWnd.SetMapData($mapName,$mapImg)
	}*/
	//end========================

	//===========================
	// Set btn modeSelect
	//===========================
	/*public function SetModeData($modeName:String,$modeImg:String){
		clanSearchWnd.SetModeData($modeName,$modeImg)
	}*/
	 	
    
    private function configUI():Void {
    	super.configUI();
    }
}