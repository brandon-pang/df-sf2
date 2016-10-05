/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
 
class com.scaleform.udk.controls.ShopUnitExplainScroll extends UIComponent
{
	
    public function ShopUnitExplainScroll()
    {         
        super();  
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