import com.scaleform.udk.views.View;
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.udk.views.ShopTabBuysHotNNew

class scaleform.sf2.lobby.shop.ShopTabBuysViews extends View
{
    public static var viewName:String = "ShopTabBuysViews";
    public var hotNewClickBox:ShopTabBuysHotNNew;
    //public var container:ShopBaseCont;
    private var weaponItemDp:Array=new Array();
    private var chrItemData:Array=new Array();
    private var cashitemData:Array=new Array();


    public function ShopTabBuysViews()
    {
        super(); 
        trace(viewName + " initialized.");
    }

     private function configUI():Void {
        super.configUI();       
    }
    
}