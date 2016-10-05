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
import gfx.controls.TextInput

class com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogWnd extends UIComponent
{
	public var btnOk:Button;
	public var btnCancel:Button;
	public var btnReset:Button;
	public var btnClanNameInput:Button;
	public var dropDownMenu_search0:DropdownMenu
	public var List_modeSet:MovieClip;
	public var SetModeMc:MovieClip;
	public var List_mode:TileList;
	public var List_MapSet:MovieClip;

	public var SetMapMc:MovieClip;
	public var List_Map:TileList;

	public var txtPopupTitle:Label;
	public var textInput_clanname:TextInput;

	public function ClanSearchDialogWnd()
	{         
		super();				
	}

	//===========================
	// Set btn mapSelect 
	//===========================
	public function SetMapData($mapName:String,$mapImg:String){
		trace ("MapData wnd"+[$mapName,$mapImg])
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
	
	public function SetTagBox($array:Array){
		var txtArr:Array=$array;
		/*["_clanSearch_clanName","_clanSearch_modeNmap",
						  "_clanSearch_active","_clanSearch_connectTime",
						  "_clanSearch_age","_clanSearch_sex",
						  "_clanSearch_achive","_clanSearch_playStyle",
						  "_clanSearch_radio","_clanSearch_codeName"];*/

		/*var txtArr:Array=["클랜명검색","주모드/맵",
						  "활동지역","접속시간대",
						  "나이","성별",
						  "클랜성향","플레이유형",
						  "보스톡","코드네임변경"]*/

		for(var i:Number=0;i<txtArr.length;i++){
			this["tagBox"+i].txt_tagname.text=txtArr[i]
		};
	}

	private function SetDropNormalSetting(){
		for(var i:Number=0;i<9;i++){
			this["dropDownMenu_search"+i].dropdown="ScrollingList_clanSearch"
			this["dropDownMenu_search"+i].itemRenderer="ListItem_clanSearch"
			this["dropDownMenu_search"+i].scrollBar="miniScrollbar";
			this["dropDownMenu_search"+i].offsetY=4;	
			if(_global.gfxPlayer)
			{	
				this["dropDownMenu_search"+i].dataProvider= ["row1", "row2", "row3", "row4", "row5", "row6", "row7", "row8"];
			}
			this["dropDownMenu_search"+i].addEventListener("select",this,"onDropDownHandler")
			
		}
	}
	private function onDropDownHandler(e:Object){		
		var n=e.target._name.substr(-1);
		var selNo=e.target.selectedIndex;
		ExternalInterface.call("clansearch_dropdown_values",n,selNo)
	}
	private function onTextInputFocusInHandler(e:Object){
		var n=e.target._name
		ExternalInterface.call("clansearch_textinput_focusin",n)
	}
	private function onTextInputFocusOutHandler(e:Object){
		var n=e.target._name
		ExternalInterface.call("clansearch_textinput_focusout",n)
	}
	private function onTextInputChgHandler(e:Object){
		var n=e.target._name
		var txt=e.target.text
		ExternalInterface.call("clansearch_textinput_chg",n,txt)
	}
	
    private function configUI():Void
    {
    	super.configUI();

		btnOk.label="_ok"
		btnCancel.label="_cancel";
		btnReset.label="_clan_search_reset";
		btnClanNameInput.label="_clan_search_clanNameInput"
		txtPopupTitle.text="_clanSearch_dialog_detail"
		//SetTagBox()
		SetDropNormalSetting()
		//
		textInput_clanname.addEventListener("focusIn",this,"onTextInputFocusInHandler")
		textInput_clanname.addEventListener("focusOut",this,"onTextInputFocusOutHandler")
		textInput_clanname.addEventListener("textChange",this,"onTextInputChgHandler")
		if(_global.gfxPlayer)
		{		
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