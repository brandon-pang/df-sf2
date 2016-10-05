/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.WriteNewsDialogContents;
import gfx.controls.TileList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.WriteNewsDialogWnd extends UIComponent
{
	public var cont:WriteNewsDialogContents;
	
	public function WriteNewsDialogWnd()
	{         
		super();  
	}
    
    public function setContents(imgset:String, type:Number, comment:String, explain:String):Void
    {
    	cont.setContents(imgset, type, comment, explain);
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
	}
	
	
}