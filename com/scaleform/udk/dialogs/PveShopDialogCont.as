/**
 * ...
 * @author 
 */

import gfx.layout.StagePanel;
import com.scaleform.udk.dialogs.PveShopDialogWnd;

[InspectableList("scaleMode")]
class com.scaleform.udk.dialogs.PveShopDialogCont extends StagePanel
{
    public var dialog:PveShopDialogWnd;
    
    private var stageWidth:Number;
    private var stageHeight:Number;
    
    public function PveShopDialogCont() {         
        super();  
    }  
    
    public function setItemList(arr:Array):Void
    {
    	dialog.setItemList(arr);
    }
    
    public function setItemListIndex(index:Number):Void
    {
    	dialog.setItemListIndex(index);
    }
    
    public function pveShop_SetResolution(w:Number, h:Number):Void
    {
    	//dialog.pveShop_SetResolution(w, h);
    	stageWidth = w;
    	stageHeight = h;
    }
    
    private function configUI():Void
	{
    	super.configUI();
    	
    	dialog.addEventListener("openStart", this, "onOpenStart");
    	dialog.addEventListener("openEnd", this, "onOpenEnd");
    	dialog.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onOpenStart():Void
	{
		dispatchEvent({type:"openStart"});
	}
	
	private function onOpenEnd():Void
	{
		dispatchEvent({type:"openEnd"});
		dialog.pveShop_SetResolution(stageWidth, stageHeight);
	}
	
	private function onCloseEnd():Void
	{
		dialog.resetItemList();
		dispatchEvent({type:"closeEnd"});
	}
}