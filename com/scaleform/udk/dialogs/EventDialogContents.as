/**
 * ...
 * @author 
 */

import com.scaleform.ObjectScrollingList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogContents extends UIComponent
{
	public var eventDialogList:ObjectScrollingList;
	public var detailContents:ObjectScrollingList;
	public var titleTxt:TextField;
	
	private var _index:Number;
	
	public function EventDialogContents()
	{         
		super();
		
		titleTxt.verticalAlign = "center";
		titleTxt.textAutoSize="shrink";
		titleTxt.text = "_dialog_event_list";
	}
    
    public function selectedList(value:Number):Void
    {
    	eventDialogList.contents.selectedList(value);
    }
    
    public function eventDialog_SetList(data:Array):Void
    {
    	eventDialogList.contents.setList(data);
    }
    
    public function eventDialog_SetContents(data:Array):Void
    {
		detailContents.contents.setContents(data);
    }
    
    private function configUI():Void
    {
    	super.configUI();
	}
	
	
	
	
}