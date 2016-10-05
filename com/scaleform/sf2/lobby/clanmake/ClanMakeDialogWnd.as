/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.DropdownMenu
import gfx.controls.TileList;
import gfx.controls.Label;
import gfx.controls.TextInput;

class com.scaleform.sf2.lobby.clanmake.ClanMakeDialogWnd extends UIComponent
{
	public var btnOk:Button;
	public var btnCancel:Button;
	public var dropDownMenu_make0:DropdownMenu
	public var List_modeSet:MovieClip;
	public var SetModeMc:MovieClip;

	public var List_mode:TileList;
	public var List_MapSet:MovieClip;

	public var SetMapMc:MovieClip;
	public var List_Map:TileList;

	public var txtChk:TextField;
	public var txtAlert:TextField;	

	public var txtPopupTitle:Label;

	public var TextInput1:TextInput;
	public var TextInput2:TextInput;
	public var TextInput3:TextInput;

	public function ClanMakeDialogWnd()
	{         
		super();				
	}

	//===========================
	// Set Top TextField
	//===========================
	public function SetTxtChkContents($value:String){
		var _s:String = $value
		var icon:String="<img src='popup_check' vspace='-4'>"
		txtChk.htmlText=icon+_s;
	}

	//===========================
	// Set bottom TextField
	//===========================
	public function SetTxtAlertContents($str:String, $cash:String){
		var _s:String = $str
		var txtArr = _s.split("|");
		var txtIcon = iconLoc($cash);
		txtAlert.htmlText = txtArr[0] + txtIcon + txtArr[1];
	}

	private function iconLoc(str):String
	{
		var _cash:String = str;
		var loc = _root.LanguageIndex;
		var channel = _root.ChannelIndex;
		var cashIcon:String;
		//SP CASH TP
		if (loc == "KOR")
		{
			if (_cash == "CASH")
			{
				if (channel == "NAVER")
				{
					cashIcon = "<img src='SHOP_" + _cash + "_" + channel + "' vspace='-4'>";
				}
				else if (channel == "HANGAME")
				{
					cashIcon = "<img src='SHOP_" + _cash + "_" + channel + "' vspace='-4'>";
				}
				else
				{
					cashIcon = "<img src='SHOP_" + _cash + "' vspace='-4'>";
				}
			}
			else
			{
				cashIcon = "<img src='SHOP_" + _cash + "'vspace='-4'>";
			}
		}
		if (loc == "JPN")
		{
			cashIcon = "<img src='SHOP_" + _cash + "_" + loc + "' vspace='-4'>";
		}
		if (loc == "CHN")
		{
			cashIcon = "<img src='SHOP_" + _cash + "' vspace='-4'>";
		}
		if (loc == "USA")
		{
			if (_cash != "SP")
			{
				cashIcon = "<img src='SHOP_" + _cash + "_" + loc + "' vspace='-4'>";
			}
			else
			{
				cashIcon = "<img src='SHOP_" + _cash + "' vspace='-4'>";
			}
		}
		else
		{
			cashIcon = "<img src='SHOP_" + _cash + "' vspace='-4'>";
		}
		return cashIcon;
	}
	// end -------------------------

	//===========================
	// Set btn mapSelect 
	//===========================
	public function SetMapData($mapName:String,$mapImg:String){
		trace ("ClanMakeDialogView MapData wnd"+[$mapName,$mapImg])
		SetMapMc.SetMapData($mapName,$mapImg)
	}
	//end========================

	//===========================
	// Set btn modeSelect
	//===========================
	public function SetModeData($modeName:String,$modeImg:String){
		SetModeMc.SetModeData($modeName,$modeImg)
	}
	//end========================

	//===========================
	// Set TagBox's Name
	//==========================
	public function SetTagBox($array:Array){
		var txtArr:Array=$array;
		/*["_clanSearch_clanName","_clanSearch_clanAddress",
						  "_clanSearch_clanIntro",
						  "_clanSearch_active","_clanSearch_connectTime",
						  "_clanSearch_age","_clanSearch_sex",
						  "_clanSearch_achive","_clanSearch_playStyle",
						  "_clanSearch_radio","_clanSearch_codeName",
						  "_clanSearch_modeNmap"];*/

		/*var txtArr:Array=["클랜명검색","주모드/맵",
						  "활동지역","접속시간대",
						  "나이","성별",
						  "클랜성향","플레이유형",
						  "보스톡","코드네임변경"]*/

		for(var i:Number=0;i<txtArr.length;i++){
			this["tagBox"+i].textField.text=txtArr[i]
		};
	}
	//end =============================

	private function SetDropNormalSetting(){
		for(var i:Number=0;i<9;i++){
			this["dropDownMenu_make"+i].dropdown="ScrollingList_clanSearch"
			this["dropDownMenu_make"+i].itemRenderer="ListItem_clanSearch"
			this["dropDownMenu_make"+i].scrollBar="miniScrollbar";
			this["dropDownMenu_make"+i].offsetY=4;	
			
			if(_global.gfxPlayer)
			{	
				this["dropDownMenu_make"+i].dataProvider= ["row1", "row2", "row3", "row4", "row5", "row6", "row7", "row8"];
			}
			this["dropDownMenu_make"+i].addEventListener("select",this,"onDropDownHandler")
			
		}
	}

	private function onDropDownHandler(e:Object){		
		var n=e.target._name.substr(-1);
		var selNo=e.target.selectedIndex;
		ExternalInterface.call("clanmake_dropdown_values",n,selNo)
	}
	private function onTextInputFocusInHandler(e:Object){
		var n=e.target._name
		ExternalInterface.call("clanmake_textinput_focusin",n)
	}
	private function onTextInputFocusOutHandler(e:Object){
		var n=e.target._name
		ExternalInterface.call("clanmake_textinput_focusout",n)
	}
	private function onTextInputChgHandler(e:Object){
		var n=e.target._name
		var txt=e.target.text
		ExternalInterface.call("clanmake_textinput_chg",n,txt)
	}
	
    private function configUI():Void
    {
    	super.configUI();

		btnOk.label            = "_ok"
		btnCancel.label        = "_cancel";	
		txtChk.verticalAlign   = "center"
		txtAlert.verticalAlign = "center"
		txtPopupTitle.text     = "_clanTxt_constituted"
		//SetTagBox()
		SetDropNormalSetting()
		//
		var tinpArray=["TextInput1","TextInput2","TextInput3"]
		for(var i:Number=0;i<3;i++){
			this[tinpArray[i]].addEventListener("focusIn",this,"onTextInputFocusInHandler")
			this[tinpArray[i]].addEventListener("focusOut",this,"onTextInputFocusOutHandler")
			this[tinpArray[i]].addEventListener("textChange",this,"onTextInputChgHandler")
		}
		
		if(_global.gfxPlayer)
		{		
				SetTxtChkContents("$value:String")

				SetTxtAlertContents("$str:String|가나다라","3000")

				SetModeMc.List_modeSet.List_mode.dataProvider=[{ModeName:"aiMODE",ModeImg:"mode_aitdm"},
										{ModeName:"aiMODE",ModeImg:"mode_aitdm"},
										{ModeName:"aiMODE",ModeImg:"mode_aitdm"},
										{ModeName:"aiMODE",ModeImg:"mode_aitdm"},
										{ModeName:"aiMODE",ModeImg:"mode_aitdm"}];

				SetMapMc.List_mapSet.List_map.dataProvider=[{MapName:"anaconda",MapImg:"clanrecord_map_anaconda"},
															{MapName:"kingstemple",MapImg:"clanrecord_map_kingstemple"},
															{MapName:"peacehawk",MapImg:"clanrecord_map_peacehawk"},
															{MapName:"kingstemple",MapImg:"clanrecord_map_kingstemple"},
															{MapName:"anaconda",MapImg:"clanrecord_map_anaconda"},
															{MapName:"kingstemple",MapImg:"clanrecord_map_kingstemple"},
															{MapName:"peacehawk",MapImg:"clanrecord_map_peacehawk"},
															{MapName:"kingstemple",MapImg:"clanrecord_map_kingstemple"}];

				SetMapData("anaconda","clanrecord_map_anaconda")
				SetModeData("aiMODE","mode_aitdm")
		};		
    }
}