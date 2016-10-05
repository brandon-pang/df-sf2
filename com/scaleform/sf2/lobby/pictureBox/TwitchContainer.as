/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.pictureBox.TwitchBroadcastOptionWnd;
import com.scaleform.sf2.lobby.pictureBox.TwitchLoginBoxWnd;
import com.scaleform.sf2.lobby.pictureBox.TwitchDialogPopup;
 
class com.scaleform.sf2.lobby.pictureBox.TwitchContainer extends UIComponent
{
    public var broadcastOption:TwitchBroadcastOptionWnd;
    public var LoginBox:TwitchLoginBoxWnd;
	public var msgCon:TwitchDialogPopup;
	
    public function TwitchContainer() {         
        super();  
    }      

    private function configUI():Void
    {
    	super.configUI();
    }
}