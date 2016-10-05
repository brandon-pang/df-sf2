/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.EventDialogContents;
import gfx.controls.TileList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogWnd extends UIComponent
{
	public var cont:EventDialogContents;
	
	public function EventDialogWnd()
	{         
		super();  
	}
    
    public function selectedList(value:Number):Void
    {
    	cont.selectedList(value);
    }
    
    public function eventDialog_SetList(data:Array):Void
    {
    	cont.eventDialog_SetList(data);
    }
    
    public function eventDialog_SetContents(data:Array):Void
    {
    	cont.eventDialog_SetContents(data);
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
	}
	
	
}