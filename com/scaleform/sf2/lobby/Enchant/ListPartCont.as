
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.Enchant.ListPartControl


class com.scaleform.sf2.lobby.Enchant.ListPartCont extends UIComponent
{
	public var txtTitle:TextField;
	public var partMcA:ListPartControl;
	public var partMcB:ListPartControl;
	public var partMcC:ListPartControl;
	public var partMcD:ListPartControl;
    
	public function ListPartCont() {         
        super(); 		
    }    
	
    private function configUI():Void
    {
    	super.configUI();
		txtTitle.verticalAlign = "center";
		txtTitle.text = "_enchant_parts";	
    }
}