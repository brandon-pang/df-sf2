/**
 * ...
 * @author 
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.controls.Button;

class com.scaleform.sf2.lobby.pictureBox.TwitchDialogPopupWnd extends UIComponent
{
	public var txt_alret:TextField;
	public var btnPopupOk:Button;
	
	public function TwitchDialogPopupWnd()
	{
		super();
	}

	public function setPopupOpen($str:String):Void
	{		
		txt_alret.text = $str;
	}

	private function onClickHandler(e:Object):Void
	{
		ExternalInterface.call("TwitchDialogBtnPopupOkClick","");
	}

	private function configUI():Void
	{
		super.configUI();
		trace (this._name);
		btnPopupOk.addEventListener("click", this, "onClickHandler");
		btnPopupOk.label = "_ok";
	}
}