/**
 * ...
 * @author 
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;

class com.scaleform.sf2.lobby.pictureBox.TwitchLoginBoxWnd extends UIComponent
{
	public var login:MovieClip;
	public var logout:MovieClip;

	public function TwitchLoginBoxWnd()
	{
		super();
	}

	public function setLoginStat($boo:Boolean):Void
	{
		if($boo){
			login._visible=false
			logout._visible=true
		}else{
			login._visible=true;
			logout._visible=false;
		}		
		setBroadCastBtnEnable($boo);
		setBlindEnable($boo)
	}

	public function setLogOutTxt(str:String):Void
	{
		logout["txt_welcome"].htmlText=str;
	}

	public function setBlindEnable(boo:Boolean):Void
    {
        if(!boo){
           _parent.blindMc._height=301
           _parent.blindMc._y=152;
           _parent.blindMc._visible=true
        }else{
           _parent.blindMc._y=-1000
           _parent.blindMc._visible=false
        }
    }
    private function setBroadCastBtnEnable(boo){
    	if(boo==false){
    		_parent.broadcastOption.btnTwitchStart.selected=boo	
    	}    	
    }

	private function configUI():Void
	{
		super.configUI();
		login["tag0"].txt.text="_twitch_id";
		login["tag0"].txt.verticalAlign="center";
		login["tag0"].txt.textAutoSize="shrink";

		login["tag1"].txt.text="_twitch_password";
		login["tag1"].txt.verticalAlign="center";
		login["tag1"].txt.textAutoSize="shrink";

		
		logout["txt_welcome"].verticalAlign="center";
		logout["txt_welcome"].textAutoSize="shrink";
	}
}