/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.clanmake.ClanMakeDialogWnd
 
class com.scaleform.sf2.lobby.clanmake.ClanMakeDialogCont extends UIComponent
{
    public var clanMakeWnd:ClanMakeDialogWnd;
    
    public function ClanMakeDialogCont() {         
        super();  
    }

    //===========================
	// Set Top TextField
	//===========================
	public function SetTxtChkContents($value:String){
		clanMakeWnd.SetTxtChkContents($value)
	}

	//===========================
	// Set bottom TextField
	//===========================
	public function SetTxtAlertContents($str:String, $cash:String){
		clanMakeWnd.SetTxtAlertContents($str, $cash)
	}

    //===========================
	// Set btn mapSelect 
	//===========================
	/*public function SetMapData($mapName:String,$mapImg:String){
		clanMakeWnd.SetMapData($mapName,$mapImg)
	}*/
	//end========================

	//===========================
	// Set btn modeSelect
	//===========================
	/*public function SetModeData($modeName:String,$modeImg:String){
		clanMakeWnd.SetModeData($modeName,$modeImg)
	}*/
	 	
    
    private function configUI():Void {
    	super.configUI();
    }
}