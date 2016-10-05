/**
 * ...
 * @author 
 */

import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
class com.scaleform.InvenGiftTabBtn extends Button
{
	public var imgIcon:MovieClip;
	
    public function InvenGiftTabBtn()
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
			case "Send":
			imgIcon.gotoAndStop("Send");
			break;
			case "Recive":
			imgIcon.gotoAndStop("Recive");
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