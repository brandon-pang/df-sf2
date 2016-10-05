/**
 * ...
 * @author 
 */


import flash.external.ExternalInterface;
import com.scaleform.udk.controls.BlockInteraction;
import gfx.controls.DropdownMenu;
import gfx.controls.TextInput;
import gfx.controls.Slider;
import gfx.controls.CheckBox;
import gfx.core.UIComponent;
import gfx.controls.Label;
import gfx.controls.Button;

class com.scaleform.sf2.lobby.pictureBox.TwitchBroadcastOptionWnd extends UIComponent
{
	public var txt_label0:TextField;
	public var inputText_broadcastTitle:TextInput;
	public var GaugeMicVol:MovieClip;
	public var txtField_frame:Label;
	public var txtField_server:Label;
	public var txt_content:TextField;
	public var txt_attend:TextField;
	public var btnTwitchStart:Button;
	public var dropdown_resolution:DropdownMenu;

	private var tagTxtArray=["_twitch_BroadcastTitle","_twitch_resolution","_twitch_vol",
							"_twitch_frame_rate","_twitch_server"]; 

	public function TwitchBroadcastOptionWnd()
	{
		super();
	}	

	public function Twitch_SetContent(str:String){
		txt_content.htmlText=str;
	}

	public function Twitch_SetAttend(str:String){
		txt_attend.htmlText=str;
	}
	
	public function Twitch_SetBroadCastBlind($boo:Boolean) {
		if ($boo) {
			_parent.blindMc._y=152;
			_parent.blindMc._height=236;
			_parent.blindMc._visible = true;
			btnTwitchStart.label = "_twitch_end";
			btnTwitchStart.selected=true
			txt_attend._visible=true;	
		}else {
			_parent.blindMc._y=-1000;
			_parent.blindMc._height=301;
			_parent.blindMc._visible = false;
			btnTwitchStart.selected = false;
			btnTwitchStart.label="_twitch_start";
			txt_attend._visible=false;
		}
	}
	private function onClickHandler(e:Object){
		//trace (e.target.selected);
		var targetValue = e.target.selected;
		if (_global.gfxPlayer) Twitch_SetBroadCastBlind(targetValue);
		ExternalInterface.call("TwitchBroadCastBtnEnable",targetValue);
	}
	
	
	private function configUI():Void
	{
		super.configUI();

		for(var i:Number=0;i<tagTxtArray.length;i++){
			this["txt_label"+i].text=tagTxtArray[i]
			this["txt_label"+i].textAutoSize="shrink"
			this["txt_label"+i].verticalAlign="center"
		}
		txt_content.verticalAlign="center";
		txt_attend.verticalAlign="center";
		txt_attend._visible=false;
		btnTwitchStart.addEventListener("click", this, "onClickHandler");
		
		if (_global.gfxPlayer) {
			dropdown_resolution.dataProvider=["11111","11112333123"]
		}
	}
}