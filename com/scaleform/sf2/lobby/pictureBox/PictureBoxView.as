/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.sf2.lobby.pictureBox.PictureBoxContainer;
import com.scaleform.udk.views.View;

class com.scaleform.sf2.lobby.pictureBox.PictureBoxView extends View
{
	public static var viewName:String = "PictureBoxView";
    
    public var container:PictureBoxContainer;

    
    public function PictureBoxView() {
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
    
    public function screenShot_SetSelectedIndex(index:Number):Void
    {
    	container.screenShot_SetSelectedIndex(index);
    }
    
    public function screenShot_SetZoomOut():Void
    {
    	container.screenShot_SetZoomOut();
    }
    
    public function screenShot_SetRemoveSuccess(index:Number):Void
    {
    	container.screenShot_SetRemoveSuccess(index);
    }
    
    public function screenShot_SetName(fileName:String):Void
    {
    	container.screenShot_SetName(fileName);
    }
    
    public function screenShot_SetNameEditCancel():Void
    {
    	container.screenShot_SetNameEditCancel();
    }
    
    public function screenShot_SetNameEditEnter():Void
    {
		container.screenShot_SetNameEditEnter();
    }
    
    public function screenShot_SetFolderPath(folderPath:String):Void
    {
    	container.screenShot_SetFolderPath(folderPath);
    }
    //=====================
    //슬라이더값 수정
    //=====================
    public function setMicVolGauge($btnStat:Boolean,$sliderStat:Number):Void
    {
        container.setMicVolGauge($btnStat,$sliderStat);
    }
   
    public function setLoginStat($boo:Boolean):Void
    {
        container.setLoginStat($boo)
    }

    public function setLogOutTxt(str:String):Void
    {
        container.setLogOutTxt(str);
    }
    public function Twitch_SetContent(str:String):Void
    {
        container.Twitch_SetContent(str)
    }
    public function Twitch_SetAttend(str:String):Void
    {
        container.Twitch_SetAttend(str);
    }
	public function Twitch_SetBroadCastBlind($boo:Boolean):Void {
		container.Twitch_SetBroadCastBlind($boo)
	}
    //=======
    //
    //=======
    public function SetMainTab($data:Array):Void
    {
        container.SetMainTab($data)
    }

    public function setTapData($no:Number):Void
    {
        container.setTapData($no);
    }
    //


    private function configUI():Void {
    	super.configUI();    	
        this._visible = false;    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
        SetMainTab([
                {
                    Label:"_PictureBox_screenShot",
                    Code:0
                }]);

        //screenShot_SetFolderPath("C:/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/");
         if(_global.gfxPlayer){
             SetMainTab([
                    {
                        Label:"_PictureBox_screenShot",
                        Code:0
                    },
                    {
                        Label:"_twitchTV_screenShot",
                        Code:1
                    }
                    ]);
           
        }
        
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_picture_box");
		
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.tileList_picture, "picture_box");
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.item1, "picture_box");
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.item2, "picture_box");
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.item3, "picture_box");
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.item4, "picture_box");
		ScrollWheelManager.registerList(container.PictureBox.TapContainerScreenShot.item5, "picture_box");

        if(_global.gfxPlayer){            
            setMicVolGauge(true,70);
            //setIngameVolGauge(false,30); 
            //setBitrateGauge(80);                                  
            setLogOutTxt("str:String")
        }
	}
	
	private function onCloseEndContainer():Void
	{
		container.boxWndInit();
		this._visible = false;
		_global.getCloseMotionEnd("gfx_picture_box");
		ScrollWheelManager.unregisterNameTag("picture_box");
	}
}