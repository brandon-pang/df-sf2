/**
 * ...
 * @author 
 */

import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
class com.scaleform.ShopSubTabBtn extends Button
{
	public var imgLoader:MovieClip;
	
    public function ShopSubTabBtn()
    {         
        super();
    }
	
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function setData(data:Object):Void
	{
		if (data.ImgSet != null && imgLoader != null)
		{
			var mcLoader = new MovieClipLoader();
			mcLoader.loadClip("img://Imgset_Mode."+data.ImgSet, imgLoader);
		}
	}
	
}