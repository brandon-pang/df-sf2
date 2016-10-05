/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import gfx.controls.DropdownMenu;
import gfx.controls.TextInput;
import gfx.core.UIComponent;

class com.scaleform.sf2.lobby.RecomItem.RecomItemPopCont extends UIComponent
{
	public static var viewName:String = "RecomItemPopCont";
	public var txtBox:MovieClip;
	
    public function ShopSearchFiltersCont()
    {         
        super();  
        trace(viewName + " initialized.");
    }
    
	public function RecomPopUp_Open() {
		this.gotoAndPlay("open");
	}
	public function RecomPopUp_Close() {
		this.gotoAndPlay("Close");
	}
	public function RecomPopUp_SetCase(caseby:String, context:String) {
		var frame:Number = Number(caseby) + 1
		var str = context;
		txtBox.gotoAndStop(frame);
		txtBox["txt0"].text=str
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		
	}	
}