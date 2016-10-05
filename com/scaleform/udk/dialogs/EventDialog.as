/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.EventDialogCont;
import com.scaleform.udk.views.View;

class com.scaleform.udk.dialogs.EventDialog extends View
{
	public static var viewName:String = "EventDialog";
    
    public var container:EventDialogCont;
    
    public function EventDialog() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    public function eventDialog_SelectedList(value:Number):Void
    {
    	container.selectedList(value);
    }
    
    public function eventDialog_SetList(data:Array):Void
    {
    	container.eventDialog_SetList(data);
    }
    
    public function eventDialog_SetContents(data:Array):Void
    {
		container.eventDialog_SetContents(data);
    }
    
    private function configUI():Void {
    	super.configUI();
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_event");
		_root.getMotionEnd("gfx_dialog_event");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_event");
		_root.getCloseMotionEnd("gfx_dialog_event");
	}
	
}