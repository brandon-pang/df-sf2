
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.TextInput;
import gfx.core.UIComponent;
import gfx.controls.ScrollingList;
import com.scaleform.sf2.lobby.Enchant.TreeViewDataProvider;
import com.scaleform.sf2.lobby.Enchant.TreeViewConstants;

class com.scaleform.sf2.lobby.Enchant.TreeModelCont extends UIComponent
{
	public var txtTitle:TextField;
    public var txtContent:TextField;
    public var txtTips:TextField;
	public var tinpModelSearch:TextInput;
	public var btnModelSearch:Button
	
	public var ListModel:ScrollingList;
	public var dp:TreeViewDataProvider
	
	public function TreeModelCont() 
	{         
        super(); 		
    }
	
	public function SetTxtContext(str:String) {
		txtContent.htmlText = str;
	}
	
	public function SetTxtTip(str:String) {
		txtTips.htmlText = str;
	}
    
    private function configUI():Void
    {
    	super.configUI();
		
		txtTitle.verticalAlign = "center";
		txtTitle.text = "_enchant_model";
		txtContent.verticalAlign = "center";
		txtContent.noTranslate = true;
		txtTips.verticalAlign = "top";
		txtContent.noTranslate = true;	
    }
}