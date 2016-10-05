/**
 * ...
 * @author 
 */
import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.pictureBox.TwitchDialogCont;

class com.scaleform.sf2.lobby.pictureBox.TwitchDialogView extends View
{
	public static var viewName:String = "TwitchView";

	public var container:TwitchDialogCont;

	public function TwitchDialogView()
	{
		super();
		trace(viewName + " initialized.");
	}

	public function openInit():Void
	{
		this._visible = true;
		container.gotoAndPlay("open");
	}

	public function closeInit():Void
	{
		container.gotoAndPlay("close");
	}

	//=====================
	//슬라이더값 수정
	//=====================
	public function setMicVolGauge($btnStat:Boolean, $sliderStat:Number):Void
	{
		container.twitch_container.broadcastOption.GaugeMicVol.setValue($btnStat,$sliderStat);
	}
	public function Twitch_SetContent(str:String):Void
	{
		container.twitch_container.broadcastOption.Twitch_SetContent(str);
	}

	public function Twitch_SetAttend(str:String):Void
	{
		container.twitch_container.broadcastOption.Twitch_SetAttend(str);
	}
	public function Twitch_SetBroadCastBlind($boo:Boolean):Void
	{
		container.twitch_container.broadcastOption.Twitch_SetBroadCastBlind($boo);
	}

	public function setLoginStat($boo:Boolean):Void
	{
		container.twitch_container.LoginBox.setLoginStat($boo);
	}

	public function setLogOutTxt(str:String):Void
	{
		container.twitch_container.LoginBox.setLogOutTxt(str);
	}

	public function setPopupOpen($str:String):Void
	{
		container.twitch_container.msgCon.setPopupOpen($str);
	}

	public function setPopupClose():Void
	{
		container.twitch_container.msgCon.setPopupClose();
	}

	private function configUI():Void
	{
		super.configUI();
		//this._visible = false;
		container.addEventListener("openEnd",this,"onOpenEndContainer");
		container.addEventListener("closeEnd",this,"onCloseEndContainer");

		if (_global.gfxPlayer)
		{
			setMicVolGauge(true,70);
			setLoginStat(true);
			setPopupOpen("sadfsdfasdfasdf");
			setPopupClose();
		}
	}

	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_twitch");
	}

	private function onCloseEndContainer():Void
	{
		this._visible = false;
		_global.getCloseMotionEnd("gfx_dialog_twitch");
	}
}