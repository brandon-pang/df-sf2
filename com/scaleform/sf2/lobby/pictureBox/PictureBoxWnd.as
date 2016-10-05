/**
 * ...
 * @author 
 */
import gfx.managers.InputDelegate;
import gfx.managers.FocusHandler;
import gfx.controls.TextInput;
import gfx.controls.TileList;
import com.scaleform.udk.controls.BlockInteraction;
import gfx.utils.Delegate;
import flash.geom.Rectangle;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.controls.UILoader;
import gfx.controls.Button;
import gfx.controls.ButtonBar;
import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.pictureBox.PictureBoxWnd extends UIComponent
{
    public var bb_pictureBox:ButtonBar;
    private var mcLoader:MovieClipLoader;
    private var TapScreenShotURL:String="gfx_picturebox_screenshot.swf"
    private var TapTwitchURL:String="gfx_picturebox_twitch.swf" 
    public var TapContainerScreenShot:MovieClip;
    public var TapContainerTwitch:MovieClip;
    public var tapContainerTwitch:MovieClip;
	public var filePath:String
	public function PictureBoxWnd()
	{         
		super();
	}
	
    public function boxWndInit():Void
    {		
		TapContainerScreenShot.screenShot.screenShotInit();
    }
    
    public function screenShot_SetSelectedIndex(index:Number):Void
    {
    	TapContainerScreenShot.screenShot.screenShot_SetSelectedIndex(index);
    }
    
    public function screenShot_SetZoomOut():Void
    {
    	TapContainerScreenShot.screenShot.screenShot_SetZoomOut();
    }
    
    public function screenShot_SetRemoveSuccess(index:Number):Void
    {
    	TapContainerScreenShot.screenShot.screenShot_SetRemoveSuccess(index);
    }
    
    public function screenShot_SetName(fileName:String):Void
    {
    	TapContainerScreenShot.screenShot.screenShot_SetName(fileName);
    }
    
    public function screenShot_SetNameEditCancel():Void
    {
    	TapContainerScreenShot.screenShot.screenShot_SetNameEditCancel();
    }
    
    public function screenShot_SetNameEditEnter():Void
    {
		TapContainerScreenShot.screenShot.screenShot_SetNameEditEnter();
    }
    
    public function screenShot_SetFolderPath(folderPath:String):Void
    {
    	trace ("ScreenShot Target Path = " + targetPath(this))
        trace (folderPath);
        filePath=folderPath
    	TapContainerScreenShot.screenShot.screenShot_SetFolderPath(folderPath);
    }  

    public function setMicVolGauge($btnStat:Boolean,$sliderStat:Number):Void
    {
        tapContainerTwitch.twitchCon.broadcastOption.GaugeMicVol.setValue($btnStat,$sliderStat);
    }
 
    public function setLoginStat($boo:Boolean):Void
    {
        tapContainerTwitch.twitchCon.LoginBox.setLoginStat($boo)
    }
    public function setLogOutTxt(str:String):Void
    {
        tapContainerTwitch.twitchCon.LoginBox.setLogOutTxt(str);
    }

    public function Twitch_SetContent(str:String):Void
    {
        tapContainerTwitch.twitchCon.broadcastOption.Twitch_SetContent(str)
    }

    public function Twitch_SetAttend(str:String):Void
    {
        tapContainerTwitch.twitchCon.broadcastOption.Twitch_SetAttend(str);
    }
	
	public function Twitch_SetBroadCastBlind($boo:Boolean):Void {
		tapContainerTwitch.twitchCon.broadcastOption.Twitch_SetBroadCastBlind($boo)
	}

    //================================
    //base tap setting
    //================================
    public function SetMainTab($data:Array):Void
    {
        var _arr=$data
        var _no:Number=Number(_arr[0].Code)

        bb_pictureBox.dataProvider = _arr;     
        bb_pictureBox.labelField   = "Label";      
        bb_pictureBox.displayFocus = true;
        bb_pictureBox.addEventListener("change",this,"onTapClick");    
    }

    public function onTapClick(e:Object)
    {
        var no = e.item.Code;       
        _global.onPictureBoxTabClick (no)       
        setTapData(no)
    }

    public function setTapData($no:Number)
    {
        trace ("xxxxx"+$no)

        var no=$no
        
        TapContainerScreenShot._visible=false;
        TapContainerScreenShot._y = -3000
        TapContainerTwitch._visible=false;
        TapContainerTwitch._y = -3000

        if (no == 0)
        {      
           TapContainerScreenShot._visible=true;
           TapContainerScreenShot._x = -15;
           TapContainerScreenShot._y = 88;
        }
        else if (no == 1)
        {
            TapContainerTwitch._visible=true;
            TapContainerTwitch._x =25;
            TapContainerTwitch._y = 88;
        }
        else if (no == 2)
        {            
            
        }
        else if (no == 3)
        {
            
        }
    }

    //================================
    //content Loader
    //================================
    private function onLoadInit(mc:MovieClip)
    {
        //스크린샷 임시
         setTapData(0);
         if(mc._name=="tapContainerScreenShot"){
             TapContainerScreenShot.screenShot.screenShot_SetFolderPath(filePath);
         }            
    }

    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(path,mc);
    }

    private function configUI():Void
    {
        super.configUI();        
        boxWndInit();     

        TapContainerTwitch = this.createEmptyMovieClip("tapContainerTwitch", 30);
        TapContainerTwitch._x = 30;
        TapContainerTwitch._y = -1000;
        TapContainerTwitch._visible=true;
        lvLoader(TapTwitchURL, TapContainerTwitch);

        TapContainerScreenShot = this.createEmptyMovieClip("tapContainerScreenShot", 20);
        TapContainerScreenShot._x = -15
        TapContainerScreenShot._y = -3000;
        TapContainerScreenShot._visible=false;
        lvLoader(TapScreenShotURL, TapContainerScreenShot);
    }
	
}