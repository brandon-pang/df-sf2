/**
 * ...
 * @author 
 */

import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
 class com.scaleform.ShopMainTabBtn extends Button
{
	public var imgIcon:MovieClip;
	public var textField:TextField;
	public function ShopMainTabBtn()
	{
		super();
	}


	private function configUI():Void
	{
		super.configUI();
	}

	private function setData(data:Object):Void
	{		
		switch (data.ImgSet)
		{
			case "Mode" :
				imgIcon.gotoAndStop("modeOnly");
				break;
			case "HotNew" :
				imgIcon.gotoAndStop("hotNew");
				break;
			case "VIP" :
				imgIcon.gotoAndStop("vip");
				break;
			case "" :
				imgIcon.gotoAndStop(1);
				break;
			case undefined :
				imgIcon.gotoAndStop(1);
				break;
		}
	}

}