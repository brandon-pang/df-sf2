/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.shop.ShopSearchFilters extends UIComponent
{
	public static var viewName:String = "ShopSearchFilters";
    public function ShopSearchFilters()
    {         
        super();  
        trace(viewName + " initialized.");
    }
    
	private function configUI():Void
	{
		super.configUI();		
	}	
}