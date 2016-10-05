/**
 * ...
 * @author 
 */
import com.scaleform.udk.views.View;
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.sf2.lobby.SearchFilters.ShopSearchFiltersCont;

class com.scaleform.sf2.lobby.SearchFilters.shopSearchFilterView extends View
{
	public static var viewName:String = "shopSearchFilterView";
	public var container:CashBarCont;
	
	public function shopSearchFilterView()
	{
		super(); 
        trace(viewName + " initialized.");
	}	
	
    private function configUI():Void {
    	super.configUI();    	 
	}	
}