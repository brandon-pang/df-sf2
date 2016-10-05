/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.WriteNewsDialogWnd;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.WriteNewsDialogCont extends UIComponent
{
    public var dialog:WriteNewsDialogWnd;
    
    public function WriteNewsDialogCont() {         
        super();  
    }  
    
    public function setContents(imgset:String, type:Number, comment:String, explain:String):Void
    {
    	dialog.setContents(imgset, type, comment, explain);
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
