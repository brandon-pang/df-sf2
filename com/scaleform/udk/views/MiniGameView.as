/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import gfx.core.UIComponent;

class com.scaleform.udk.views.MiniGameView extends View
{
	public static var viewName:String = "MiniGameView";
   // public var firstSelection:MovieClip;
    //public var backBtn:MovieClip;
    
    public function MiniGameView() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    /*public function setBackBtn(inBackBtn:MovieClip):Void {
        backBtn = inBackBtn
        //firstSelection = backBtn;
        //SetFocus();
    }        */
}