/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.MyInfo.BlindCont extends UIComponent
{		
	public var txt:TextField;
    
	public function BlindCont() {         
        super(); 		
    }    
	
	public function setBlindTxt(str:String) {
		txt.htmlText=str
	}
	
	public function onBlindEnabled(boo:Boolean) {
		if (boo) {
			this._visible = true
		}else {
			this._visible = false
		}
	}
    private function configUI():Void
    {
    	super.configUI();
		this._visible = false;
		txt.verticalAlign = "center";
		
    }
	
}