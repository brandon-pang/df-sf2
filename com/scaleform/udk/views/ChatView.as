/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import gfx.core.UIComponent;

class com.scaleform.udk.views.ChatView extends View
{
	public static var viewName:String = "ChatView";
   // public var firstSelection:MovieClip;
    //public var backBtn:MovieClip;
    
    public function ChatView() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    /*public function setBackBtn(inBackBtn:MovieClip):Void {
        backBtn = inBackBtn
        //firstSelection = backBtn;
        //SetFocus();
    }        */
}