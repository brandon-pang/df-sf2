/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import com.scaleform.udk.views.ClanWeekRankDialogWnd
 
class com.scaleform.udk.views.ClanWeekRankDialogCont extends UIComponent
{
    public var clanWeekRankWnd:ClanWeekRankDialogWnd
    
    public function ClanWeekRankDialogCont() {         
        super();  
    }   

    public function SetTitle($Value:String){  
        trace ("ClanWeek Set Txt Attend = "+$Value)     
        clanWeekRankWnd.SetTitle($Value);
    }

    public function SetTxtAttend($Value:String){
        trace ("ClanWeek Set Txt Attend = "+$Value)
        clanWeekRankWnd.SetTxtAttend($Value);
    }

    private function configUI():Void {
    	super.configUI();
    }
}