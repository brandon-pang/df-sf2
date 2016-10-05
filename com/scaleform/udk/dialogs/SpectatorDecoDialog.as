/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.SpectatorDecoDialogCont;
import com.scaleform.udk.views.View;

class com.scaleform.udk.dialogs.SpectatorDecoDialog extends View
{
	public static var viewName:String = "SpectatorDecoDialog";
    
    public var container:SpectatorDecoDialogCont;
    
    public function SpectatorDecoDialog() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    public function spectatorDecoDialog_SetContents(imgset:String, itemName:String, explain:String, comment:String,
    												styleNum:Number, colorNum:Number, fontColor:Array, flicker:Boolean, preview:Boolean):Void
    {
    	container.setContents(imgset, itemName, explain, comment, styleNum, colorNum, fontColor, flicker, preview);
    }
    
    public function spectatorDecoDialog_CommentCheck(type:Number, typeWord:String):Void
    {
    	container.commentCheck(type, typeWord);
    }
    
    private function configUI():Void {
    	super.configUI();
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_spectator_deco");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_spectator_deco");
	}
	
}