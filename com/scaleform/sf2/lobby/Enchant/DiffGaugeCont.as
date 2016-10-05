import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
class com.scaleform.sf2.lobby.Enchant.DiffGaugeCont extends UIComponent
{
	public var bar:MovieClip;
	
	public function DiffGaugeCont() {         
        super(); 		
    } 	
	public function setDiffValue(min:Number,max:Number) {				
		var div:Number;		
		div = (min / max) * 272;		
		TweenMax.to(bar, 1, {_width:div, ease:Cubic.easeInOut});
	}	
    private function configUI():Void
    {
		bar._width = 1;
    	super.configUI();
    }
}