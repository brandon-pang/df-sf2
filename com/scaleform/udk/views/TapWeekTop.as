/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import gfx.controls.Button;
import flash.external.ExternalInterface;

class com.scaleform.udk.views.TapWeekTop extends UIComponent
{
    public var btn_lastWeek:Button;
    public var txt_title:TextField;

    public function TapWeekTop() {         
        super();         
    } 

    public function SetTapWeekTopTitle($str:String){
        var s:String=$str
        txt_title.htmlText=s
    }

    private function onLastWeekClickHandler(e:Object):Void{
        ExternalInterface.call("tapWeekRank_lastWeek_Clicked");        
    }
    
    private function configUI():Void {
    	super.configUI();
        txt_title.verticalAlign="center";
        txt_title.textAutoSize="shrink";
        btn_lastWeek.addEventListener("click",this,"onLastWeekClickHandler");
        //txt_title.text="_tapWeekRank_topTitle" 
    }

}