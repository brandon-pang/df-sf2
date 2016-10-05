/**
 * ...
 * @author 
 */

import com.scaleform.sf2.lobby.pictureBox.PictureBoxWnd;
import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.pictureBox.PictureBoxContainer extends UIComponent
{
    public var PictureBox:PictureBoxWnd;
    
    public function PictureBoxContainer() {         
        super();  
    }  
    
	public function boxWndInit():Void
    {
		PictureBox.boxWndInit();
    }
    
    public function screenShot_SetSelectedIndex(index:Number):Void
    {
    	PictureBox.screenShot_SetSelectedIndex(index);
    }
    
    public function screenShot_SetZoomOut():Void
    {
    	PictureBox.screenShot_SetZoomOut();
    }
    
    public function screenShot_SetRemoveSuccess(index:Number):Void
    {
    	PictureBox.screenShot_SetRemoveSuccess(index);
    }
    
    public function screenShot_SetName(fileName:String):Void
    {
    	PictureBox.screenShot_SetName(fileName);
    }
    
    public function screenShot_SetNameEditCancel():Void
    {
    	PictureBox.screenShot_SetNameEditCancel();
    }
    
    public function screenShot_SetNameEditEnter():Void
    {
		PictureBox.screenShot_SetNameEditEnter();
    }
    
    public function screenShot_SetFolderPath(folderPath:String):Void
    {
    	PictureBox.screenShot_SetFolderPath(folderPath);
    }
    //
   
    public function setMicVolGauge($btnStat:Boolean,$sliderStat:Number):Void
    {
        PictureBox.setMicVolGauge($btnStat,$sliderStat);
    }

    public function setLoginStat($boo:Boolean):Void
    {
        PictureBox.setLoginStat($boo)
    }

    public function setLogOutTxt(str:String):Void
    {
        PictureBox.setLogOutTxt(str);
    }
    public function Twitch_SetContent(str:String):Void
    {
        PictureBox.Twitch_SetContent(str)
    }
    public function Twitch_SetAttend(str:String):Void
    {
        PictureBox.Twitch_SetAttend(str);
    }
    //
    public function SetMainTab($data:Array):Void
    {
        PictureBox.SetMainTab($data)
    }    
    public function setTapData($no:Number):Void
    {
        PictureBox.setTapData($no);
    }
	public function Twitch_SetBroadCastBlind($boo:Boolean):Void {
		PictureBox.Twitch_SetBroadCastBlind($boo)
	}
	

    private function configUI():Void {
    	super.configUI();
    }
}