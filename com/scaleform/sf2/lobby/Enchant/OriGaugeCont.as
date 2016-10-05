import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.greensock.*; 
import com.greensock.easing.*;
class com.scaleform.sf2.lobby.Enchant.OriGaugeCont extends UIComponent
{
	public var maskMc:MovieClip;
	public var bars:MovieClip;
	
	public function OriGaugeCont() {         
        super(); 		
    } 	
	public function setValue(color:Number,min:Number,max:Number) {
		var c:Number = color;		
		var div:Number;
		if (c == 0) { bars.gotoAndStop(1); }
		else { bars.gotoAndStop(2); }
		div = (min / max) * 272;
		TweenMax.to(maskMc, 1, {_width:div, ease:Cubic.easeInOut});
	}	
    private function configUI():Void
    {
    	super.configUI();
		maskMc._width = 1;
    }
}