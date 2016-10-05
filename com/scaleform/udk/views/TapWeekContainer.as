/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import com.scaleform.udk.views.TapWeekTop;
import com.scaleform.udk.views.TapWeekLeft;
import com.scaleform.udk.views.TapWeekRight;
 
class com.scaleform.udk.views.TapWeekContainer extends UIComponent
{    
    public var weekRankTop:TapWeekTop;
    public var weekRankLeft:TapWeekLeft;
    public var weekRankRight:TapWeekRight;
    
    public function TapWeekContainer() {         
        super();  
    }    
    //top
    public function SetTapWeekTopTitle($str:String){
        weekRankTop.SetTapWeekTopTitle($str)
    }   

    //left
    public function SetClanRankMaxValue($value:Number)
    {
        weekRankLeft.SetClanRankMaxValue($value)
    }
    public function SetClanRankPos()
    {
        weekRankLeft.SetClanRankPos()
    }
    public function SetClanNameBoxPos($nowRankValue:Number,
                                      $ClanImg:String,
                                      $ClanPointStr:String,
                                      $isClan:Boolean,
                                      $RankValueTxt:String)
    {
        weekRankLeft.SetClanNameBoxPos($nowRankValue,
                                       $ClanImg,
                                       $ClanPointStr,
                                       $isClan,
                                       $RankValueTxt)
    }           
    //Right
    public function SetTxtRankResultTime($str:String)
    {
        weekRankRight.SetTxtRankResultTime($str)
    }

    

    private function configUI():Void {
    	super.configUI();

       
    }
}