/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.shop.ShopTabCont
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.shop.ShopTabView extends View
{
	public static var viewName:String = "ShopTabView";
	public var container:ShopTabCont;
	
	public function ShopTabView()
	{
		super(); 

        trace(viewName + " initialized.");
	}
    
	 private function configUI():Void {
    	super.configUI();    	
	}
	
}