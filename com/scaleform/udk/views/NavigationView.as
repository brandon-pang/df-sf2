/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
//import com.scaleform.udk.controls.ImageScroller;
import gfx.controls.Button
import gfx.core.UIComponent;

class com.scaleform.udk.views.NavigationView extends View
{
	public static var viewName:String = "NavigationView";
   // public var firstSelection:MovieClip;
    //public var backBtn:MovieClip;
    
    public function NavigationView() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    /*public function setBackBtn(inBackBtn:MovieClip):Void {
        backBtn = inBackBtn
        //firstSelection = backBtn;
        //SetFocus();
    }        */
}