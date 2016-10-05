/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.JoinGameView extends View
{
    public static var viewName:String = "JoinRoom";
        
    public function JoinGameView() {
        super();
    }     
    
	/*
    // Custom handleInput for the view to setup the focus path.
    function handleInput(details:InputDetails, pathToFocus:Array):Boolean {          
        var nextItem:MovieClip = MovieClip(pathToFocus.shift());
        var handled:Boolean = nextItem.handleInput(details, pathToFocus);
        if (handled) { return true; }	               
        
        return false; // or true if handled
    } 
	*/
}