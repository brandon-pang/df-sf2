/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import com.scaleform.udk.views.GachaRollWnd
 
class com.scaleform.udk.views.GachaRollContainer extends UIComponent
{
    public var gachaRollWnd:GachaRollWnd;
    
    public function GachaRollContainer() {         
        super();  
    } 
	
	public function setRollTxt(value:String):Void
    {    
    	gachaRollWnd.setRollTxt(value);
    }
	
	public function rollTxtInit():Void
    {    
    	gachaRollWnd.rollTxtInit();
    }
    
    private function configUI():Void {
    	super.configUI();
    }
}