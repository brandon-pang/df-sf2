/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import com.scaleform.udk.utils.ScrollWheelManager;
import gfx.controls.ScrollingList;
 
class com.scaleform.udk.views.TapWeekRight extends UIComponent
{
    public var txt_no:TextField;
    public var txt_clanname:TextField;
    public var txt_clanpoint:TextField;
    public var txt_bt_time:TextField;
    public var txt_d0:TextField;
    public var txt_d1:TextField;
    public var txt_d2:TextField;
    public var txt_d3:TextField;
    public var List_TapWeek:ScrollingList;

    public function TapWeekRight() {         
        super();  
    }
   
    public function SetTxtRankResultTime($str:String)
    {
        var d:String = $str;       
        var icon:String ="<img src='sun_time' vspace='-12'>"; 
        txt_bt_time.htmlText=icon+$str
                             /*+"<font color='#6E6E6E'size='12'>"+result+" </font>"
                             +"<font color='#E2AA01'size='18'> "+d+" </font>"
                             +"<font color='#8A8A8A'size='12'>"+tday+" </font>"
                             +"<font color='#E2AA01'size='18'> "+o+" </font>"
                             +"<font color='#8A8A8A'size='12'>"+thour+ "</font>"
                             +"<font color='#E2AA01'size='18'> "+m+" </font>"
                             +"<font color='#8A8A8A'size='12'>"+tmin+" </font>"*/
    }

    private function configUI():Void {
    	super.configUI();

        txt_no.verticalAlign        = "center";
        txt_no.textAutoSize         = "shrink";
        txt_clanname.verticalAlign  = "center";
        txt_clanname.textAutoSize   = "shrink";
        txt_clanpoint.verticalAlign = "center";
        txt_clanpoint.textAutoSize  = "shrink";
        txt_bt_time.verticalAlign   = "center";
        txt_bt_time.textAutoSize    = "shrink";

        txt_no.text        = "_tapWeekRank_no";
        txt_clanname.text  = "_tapWeekRank_clanname";
        txt_clanpoint.text = "_tapWeekRank_clanpoint";

        //txt_d0.text="_tapWeekRank_rankResult"
        //txt_d1.text="_day"
        //txt_d2.text="_hour"
        //txt_d3.text="_min"

        //txt_d0.text="순위결정 까지 남은 시간"
       // txt_d1.text="일"
       // txt_d2.text="시간"
        //txt_d3.text="분"
    }
}