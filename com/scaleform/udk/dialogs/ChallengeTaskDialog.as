/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.ChallengeTaskDialogCont;
import com.scaleform.udk.views.View;

class com.scaleform.udk.dialogs.ChallengeTaskDialog extends View
{
	public static var viewName:String = "ChallengeTaskDialog";
    
    public var container:ChallengeTaskDialogCont;
    
    public function ChallengeTaskDialog() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    public function challenge_SetEmblem(data:Object):Void
    {
    	container.setEmblem(data);
    }
    
    public function challenge_SetReward(datas:Array):Void
    {
    	container.setReward(datas);
    }
    
    public function challenge_SetComment(cmt:String):Void
    {
    	container.setComment(cmt);
    }
    
    private function configUI():Void {
    	super.configUI();
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_challenge_notice");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_challenge_notice");
	}
}