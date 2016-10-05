/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.cashbar.CashBarCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.cashbar.CashBarView extends View
{
	public static var viewName:String = "CashBarView";
	public var container:CashBarCont;
	
	public function CashBarView()
	{
		super(); 
        trace(viewName + " initialized.");
	}	
	
	public function setCash(spTxt:String, cashTxt:String, tpTxt:String)
	{
		container.setCash(spTxt, cashTxt, tpTxt)
	}
	
    private function configUI():Void {
    	super.configUI();    	 
	}

	
}