/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import gfx.controls.DropdownMenu;
import gfx.controls.TextInput;
import gfx.core.UIComponent;
 
class com.scaleform.sf2.lobby.SearchFilters.ShopSearchFiltersCont extends UIComponent
{
	public static var viewName:String = "ShopSearchFilters";
	public var cb_subtab:DropdownMenu;
	public var tinp_search:TextInput;
	public var btn_search:Button;
	
    public function ShopSearchFiltersCont()
    {         
        super();  
        trace(viewName + " initialized.");
    }
    
	private function configUI():Void
	{
		super.configUI();
		if (_global.gfxPlayer) {
			var arr = [ { Label:"장비", Code:0, ImgSet:"SurvivalGame" },
						{Label:"용병", Code:1, ImgSet:"BeastGame" },
						{ Label:"장비", Code:0, ImgSet:"SurvivalGame" },
						{Label:"용병", Code:1, ImgSet:"BeastGame" },
						{ Label:"장비", Code:0, ImgSet:"SurvivalGame" },
						{Label:"용병", Code:1, ImgSet:"BeastGame" },
						{ Label:"장비", Code:0, ImgSet:"SurvivalGame" },
						{Label:"용병", Code:1, ImgSet:"BeastGame" } ];
			
			cb_subtab.dataProvider = arr;
		}
		cb_subtab.rowCount=10
	}	
}