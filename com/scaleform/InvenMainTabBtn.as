/**
 * ...
 * @author 
 */

import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
class com.scaleform.InvenMainTabBtn extends Button
{
	public var imgIcon:MovieClip;
	
    public function InvenMainTabBtn()
    {         
        super();
    }
	
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function setData(data:Object):Void
	{
		switch(data.ImgSet){
			case "Mode":
			imgIcon.gotoAndStop("Mode");
			break;
			case "Gift":
			imgIcon.gotoAndStop("Gift");
			break;
			case "":
			imgIcon.gotoAndStop(1);
			break;
			case undefined:
			imgIcon.gotoAndStop(1);
			break;
		}
		
	}
	
}