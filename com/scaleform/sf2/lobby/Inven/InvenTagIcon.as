/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.shop.ShopTagIcon extends UIComponent
{
	public static var viewName:String = "ShopTagIcon";
    public function ShopTagIcon()
    {         
        super();  
        trace(viewName + " initialized.");
    }

	private function configUI():Void
	{
		super.configUI();		
		Mouse.addListener(this);
	}
	
	private function scrollWheel(delta:Number):Void
	{
		dispatchEvent({type:"scrollWheel", delta:delta});
	}	
	
}