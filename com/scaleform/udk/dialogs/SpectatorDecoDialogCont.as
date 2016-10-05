/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.SpectatorDecoDialogWnd;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.SpectatorDecoDialogCont extends UIComponent
{
    public var dialog:SpectatorDecoDialogWnd;
    
    public function SpectatorDecoDialogCont() {         
        super();  
    }  
    
    public function setContents(imgset:String, itemName:String, explain:String, comment:String,
    								styleNum:Number, colorNum:Number, fontColor:Array, flicker:Boolean, preview:Boolean):Void
    {
    	dialog.setContents(imgset, itemName, explain, comment, styleNum, colorNum, fontColor, flicker, preview);
    }
    
    public function commentCheck(type:Number, typeWord:String):Void
    {
    	dialog.commentCheck(type, typeWord);
    }
    
    private function configUI():Void
	{
    	super.configUI();
    	
    	dialog.addEventListener("openEnd", this, "onOpenEnd");
    	dialog.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onOpenEnd():Void
	{
		dispatchEvent({type:"openEnd"});
	}
	
	private function onCloseEnd():Void
	{
		dispatchEvent({type:"closeEnd"});
		dialog.cont.initCont();
	}
}
