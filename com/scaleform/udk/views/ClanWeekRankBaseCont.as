/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import com.scaleform.udk.views.ClanWeekRankBaseWnd;
 
class com.scaleform.udk.views.ClanWeekRankBaseCont extends UIComponent
{
    public var clanWeekRankBase:ClanWeekRankBaseWnd;
    
    public function ClanWeekRankBaseCont() {         
        super();  
    } 

    //base tap
    public function SetMainTab($data:Array):Void
    {       
        clanWeekRankBase.SetMainTab($data);
    }

    public function setTapData($no:Number){
        clanWeekRankBase.setTapData($no)
    }

    //top
    public function SetTapWeekTopTitle($str:String){
        clanWeekRankBase.SetTapWeekTopTitle($str)
    }  

    //left
    public function SetClanRankMaxValue($value:Number)
    {
        clanWeekRankBase.SetClanRankMaxValue($value)
    }
    public function SetClanRankPos()
    {
        clanWeekRankBase.SetClanRankPos()
    }

    private function configUI():Void {
    	super.configUI();
    }
}