/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.EventDialogWnd;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogCont extends UIComponent
{
    public var dialog:EventDialogWnd;
    
    public function EventDialogCont() {         
        super();  
    }  
    
    public function selectedList(value:Number):Void
    {
    	dialog.selectedList(value);
    }
    
    public function eventDialog_SetList(data:Array):Void
    {
    	dialog.eventDialog_SetList(data);
    }
    
    public function eventDialog_SetContents(data:Array):Void
    {
    	dialog.eventDialog_SetContents(data);
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
		dialog.cont.eventDialogList.contents.initContents();
		dialog.cont.detailContents.contents.initContents();
	}
}
