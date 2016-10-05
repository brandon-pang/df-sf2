/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.ChallengeTaskDialogWnd;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.ChallengeTaskDialogCont extends UIComponent
{
    public var dialog:ChallengeTaskDialogWnd;
    
    public function ChallengeTaskDialogCont() {         
        super();  
    }  
    
    public function setEmblem(data:Object):Void
    {
    	dialog.setEmblem(data);
    }
    
    public function setReward(datas:Array):Void
    {
    	dialog.setReward(datas);
    }
    
    public function setComment(cmt:String):Void
    {
    	dialog.setComment(cmt);
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
	}
}