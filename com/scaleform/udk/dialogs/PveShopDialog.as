/**
 * ...
 * @author 
 */

import flash.geom.Rectangle;
import flash.external.ExternalInterface;
import gfx.utils.Delegate;
import com.scaleform.udk.dialogs.PveShopDialogCont;
import com.scaleform.udk.views.View;

class com.scaleform.udk.dialogs.PveShopDialog extends View
{
	public static var viewName:String = "PveShopDialog";
    public var container:PveShopDialogCont;
    
    private var mouseListener:Object;
    
    public function PveShopDialog() {
        super(); 
        trace(viewName + " initialized.");
    }
    
    public function pveShop_SetItemList(arr:Array):Void
    {
    	container.setItemList(arr);
    	mouseListener = new Object();
		mouseListener.onMouseDown = Delegate.create(this, handleStageClick);
		Mouse.addListener(mouseListener);
    }
    
    public function pveShop_SetSelectedIndex(index:Number):Void
    {
    	container.setItemListIndex(index);
    }
    
    public function pveShop_SetResolution(w:Number, h:Number):Void
    {
    	container.pveShop_SetResolution(w, h);
    	
    	/*var point:Object = {x:0, y:0};
		container.dialog.localToGlobal(point);
		
		var visibleRect:Rectangle = Stage.visibleRect;
		var originalRect:Rectangle = Stage.originalRect;
		
		var offsetX:Number = (visibleRect.width - originalRect.width>>1);
		var offsetY:Number = (visibleRect.height - originalRect.height>>1) * h / visibleRect.height;
		
		var targetX:Number = (point.x+offsetX)  * w / visibleRect.width;
    	var targetY:Number = (point.y+offsetY)  * h / visibleRect.height;
    	
    	ExternalInterface.call("pveShopDialog_OnPosition", targetX, targetY);*/
    }
    
    private function handleStageClick():Void 
	{
		if (hitTest(_root._xmouse, _root._ymouse, true)) { return; }
		handleClose();	
	}
    
    private function handleClose():Void 
	{
		delete mouseListener.onMouseDown;
		Mouse.removeListener(mouseListener);
		mouseListener.mouseListener = null;
		
		ExternalInterface.call("pveShopDialog_OnCancelBgClick");
	}
    
    private function configUI():Void {
    	super.configUI();
    	
    	container.addEventListener("openStart", this, "onOpenStartContainer");
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenStartContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_pve_shop");
		if (_root.designMode)
		{
			var Arr:Array = new Array();
			Arr.push({ImgSet:"AK103", ImgName:"AK 103", ImgPrice:"10,000", ImgShortCut:"1", ItemEnabled:true, ItemHave:true});
			//Arr.push({ImgSet:"m4a1_eotech", ImgName:"M4A1", ImgPrice:"8,000", ImgShortCut:"2", ItemEnabled:true});
			Arr.push({ImgShortCut:"2", ItemEnabled:false});
			Arr.push({ImgSet:"cheytac", ImgName:"cheytac", ImgPrice:"20,000", ImgShortCut:"3", ItemEnabled:true});
			Arr.push({ImgSet:"AWP", ImgName:"AWP", ImgPrice:"18,000", ImgShortCut:"4", ItemEnabled:false});
			Arr.push({ImgSet:"P90", ImgName:"P90", ImgPrice:"3,000", ImgShortCut:"5", ItemEnabled:true});
			Arr.push({ImgSet:"KrissV", ImgName:"KrissV", ImgPrice:"4,000", ImgShortCut:"6", ItemEnabled:true});
			Arr.push({ImgSet:"M249_SPW", ImgName:"M249", ImgPrice:"33,000", ImgShortCut:"7", ItemEnabled:false});
			
			pveShop_SetItemList(Arr);
			pveShop_SetResolution(1024, 768);
		}
	}
	
	private function onOpenEndContainer():Void
	{
		
	}
	
	private function onCloseEndContainer():Void
	{
		delete mouseListener.onMouseDown;
		Mouse.removeListener(mouseListener);
		mouseListener.mouseListener = null;
		_global.getCloseMotionEnd("gfx_dialog_pve_shop");
	}
}