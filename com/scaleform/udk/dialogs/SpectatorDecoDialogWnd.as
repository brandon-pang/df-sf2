/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.SpectatorDecoDialogContents;
import gfx.controls.TileList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.SpectatorDecoDialogWnd extends UIComponent
{
	public var cont:SpectatorDecoDialogContents;
	
	public function SpectatorDecoDialogWnd()
	{         
		super();  
	}
    
    public function setContents(imgset:String, itemName:String, explain:String, comment:String,
    								styleNum:Number, colorNum:Number, fontColor:Array, flicker:Boolean, preview:Boolean):Void
    {
    	cont.setContents(imgset, itemName, explain, comment, styleNum, colorNum, fontColor, flicker, preview);
    }
    
    public function commentCheck(type:Number, typeWord:String):Void
    {
    	cont.commentCheck(type, typeWord);
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
	}
	
	
}