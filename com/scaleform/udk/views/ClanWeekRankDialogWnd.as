/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.ScrollingList;
import gfx.controls.Label; 
class com.scaleform.udk.views.ClanWeekRankDialogWnd extends UIComponent 
{
	public var txt_bt_attend:TextField;
	public var txt_title:TextField;
	public var btnOk:Button;
	public var List_topRank:ScrollingList;
	public var List_btRank:ScrollingList;
	public var txtPopupTitle:Label;
	public function ClanWeekRankDialogWnd()
	{         
		super();    	
	}	
	
	public function SetTitle($Value:String){
		//trace ("ClanWeek Set Txt Attend = "+$Value)
		var v:String=$Value;
		txt_title.text=v;
	}

	public function SetTxtAttend($Value:String){
		//trace ("ClanWeek Set Txt Attend = "+$Value)
		var v:String=$Value;
		var addIconTxt:String="<img src='clanWeekRankIcon' valign='baseline' vspace='-5'>"+v
		txt_bt_attend.htmlText=addIconTxt;
	}

    private function configUI():Void
    {
    	super.configUI();
    	btnOk.label="_ok"
    	txt_bt_attend.verticalAlign = "center";
    	txt_title.verticalAlign     = "center";
    	txt_title.textAutoSize      = "shrink";
    	txtPopupTitle.text="_clanRank_dialog_title";
    	if (_global.gfxPlayer)
    	{	
    		
    	}	
    }
}