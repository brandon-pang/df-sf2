/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.WriteNewsDialogCont;
import com.scaleform.udk.views.View;

class com.scaleform.udk.dialogs.WriteNewsDialog extends View
{
	public static var viewName:String = "WriteNewsDialog";
    
    public var container:WriteNewsDialogCont;
    
    public function WriteNewsDialog() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    public function writeNewsDialog_SetContents(imgset:String, type:Number, comment:String, explain:String):Void
    {
    	container.setContents(imgset, type, comment, explain);
    }
    
    private function configUI():Void {
    	super.configUI();
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_write_news");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_write_news");
	}
	
}