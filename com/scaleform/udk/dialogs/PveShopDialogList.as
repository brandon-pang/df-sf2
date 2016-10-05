/**
 * ...
 * @author 
 */

import flash.geom.Rectangle;
import flash.external.ExternalInterface;
import com.scaleform.udk.dialogs.PveShopDialogListItem;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.dialogs.PveShopDialogList extends UIComponent
{
	public var item0:PveShopDialogListItem;
	public var item1:PveShopDialogListItem;
	public var item2:PveShopDialogListItem;
	public var item3:PveShopDialogListItem;
	public var item4:PveShopDialogListItem;
	public var item5:PveShopDialogListItem;
	public var item6:PveShopDialogListItem;
	public var item7:PveShopDialogListItem;
	public var item8:PveShopDialogListItem;
	public var item9:PveShopDialogListItem;
	
	public var shopListBg:MovieClip;
	public var shopListLine:MovieClip;
	public var selectedItem:PveShopDialogListItem;
	
	private var itemArr:Array;
	
	
    public function PveShopDialogList()
    {         
        super();  
    }
	
	public function resetItem():Void
    {
    	for (var i:Number=0; i<itemArr.length; i++)
    	{
    		itemArr[i].initItem();
    		itemArr[i].selected = false;
    		itemArr[i]["selectMC"].gotoAndStop(2);
    		itemArr[i]._alpha = 100;
    	}
    	/*if (selectedItem)
    	{
    		selectedItem.selected = false;
    		selectedItem["selectMC"].gotoAndStop(2);
    	}*/
    	shopListBg._alpha = 100;
		shopListLine._alpha = 100;
    	selectedItem = null;
    }
	
	public function setItem(arr:Array):Void
    {
    	for (var i:Number=0; i<itemArr.length; i++)
    	{
    		itemArr[i].setData(arr[i]);
    	}
    }
	
	public function setItemListIndex(index:Number):Void
    {
    	if (itemArr[index] == selectedItem) { return; }
    	if (selectedItem) { selectedItem.selected = false; }
    	itemArr[index].selected = true;
    	itemArr[index].selectMC.gotoAndPlay("show");
    	selectedItem = itemArr[index];
    	setDisableItem(itemArr[index].index);
    }
	
	public function pveShop_SetResolution(w:Number, h:Number):Void
    {
    	var point:Object = {x:item0["rect"]._width/2, y:item0["rect"]._height/2};
		item0.localToGlobal(point);
		
		var visibleRect:Rectangle = Stage.visibleRect;
		var originalRect:Rectangle = Stage.originalRect;
		
		var offsetX:Number = (visibleRect.width - originalRect.width>>1);
		var offsetY:Number = (visibleRect.height - originalRect.height>>1) * h / visibleRect.height;
		
		var targetX:Number = (point.x+offsetX)  * w / visibleRect.width;
    	var targetY:Number = (point.y+offsetY)  * h / visibleRect.height;
    	
    	ExternalInterface.call("pveShopDialog_OnPosition", targetX, targetY);
    }
	
	private function configUI():Void
	{
		super.configUI();
		
		itemArr = [item0, item1, item2, item3, item4, item5, item6, item7, item8, item9];
		
		for (var i:Number=0; i<itemArr.length; i++)
    	{
    		itemArr[i].index = i;
    		itemArr[i].addEventListener("click", this, "onShopItemClick" );
    	}
	}
	
	private function onShopItemClick(e:Object):Void
	{
		e.target.selected = true;
    	e.target.selectMC.gotoAndPlay("show");
    	selectedItem = e.target;
    	setDisableItem(e.target.index);
		ExternalInterface.call("pveShopDialog_OnListItemClick", e.target.index);
	}
	
	private function setDisableItem(index:Number):Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			if (i != index)
			{
				itemArr[i]._itemEnabled = true;
				itemArr[i].disabled = true;
				itemArr[i]._alpha = 40;
			}
		}
		shopListBg._alpha = 40;
		shopListLine._alpha = 40;
	}
	
}