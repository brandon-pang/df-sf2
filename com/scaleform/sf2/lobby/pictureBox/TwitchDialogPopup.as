/**
 * ...
 * @author 
 */
import com.scaleform.sf2.lobby.pictureBox.TwitchDialogPopupWnd
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.controls.Button;

class com.scaleform.sf2.lobby.pictureBox.TwitchDialogPopup extends UIComponent
{
	public var msg:TwitchDialogPopupWnd;
	
	public function TwitchDialogPopup()
	{
		super();
	}

	public function setPopupOpen($str:String):Void
	{
		this.gotoAndPlay("open");
		msg.setPopupOpen($str)		
	}

	public function setPopupClose()
	{
		this.gotoAndPlay("close");		
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
}