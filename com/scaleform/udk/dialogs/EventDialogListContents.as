/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import com.scaleform.udk.controls.EventDialogListItem;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogListContents extends UIComponent
{
	public var targetHeight:Number;
	
	private var listArr:Array = [];
	private var selectedBtn:EventDialogListItem;
	
	public function EventDialogListContents()
	{         
		super();
		
		listArr = [];
	}
    
    public function initContents():Void
    {
    	removeAllList();
    }
    
    public function selectedList(value:Number):Void
    {
    	if (value == null || value >= listArr.length) { return; }
    	listArr[value].subOpen();
    	setSelectedList(value);
    	if (selectedBtn != null) { selectedBtn.selected = false; }
		selectedBtn = listArr[value];
    	listArr[value].selected = true;
    }
    
    public function setList(data:Array):Void
    {
    	removeAllList();
		
    	for (var i:Number=0; i<data.length; i++)
    	{
    		var item:MovieClip = this.attachMovie("eventDialogListItem", "listItem"+i, getNextHighestDepth());
    		item.index = i;
    		item.setData(data[i]);
    		item._y = (i==0)?0:listArr[i-1]._y+listArr[i-1]._height;
    		item.addEventListener("itemClick", this, "onListItemClick");
    		item.addEventListener("changeHeight", this, "onListItemChangeHeight");
    		item.addEventListener("resizeItem", this, "onListItemResizeItem");
    		listArr.push(item);
		}
		targetHeight = this._height;
		dispatchEvent({type:"resizeContents"});
    }
    
    private function configUI():Void
    {
    	super.configUI();
	}
	
	private function setSelectedList(value:Number):Void
    {
    	var targetH:Number = listArr[value]._y + listArr[value].targetHeight - _parent._scrollPosition;
		if (targetH > _parent.mask._height)
		{
			dispatchEvent({type:"posChangeContents", yDist:-(targetH-_parent.mask._height)});
		}
		else if (listArr[value]._y - _parent._scrollPosition < 0)
		{
			dispatchEvent({type:"posChangeContents", yDist:_parent._scrollPosition - listArr[value]._y});
		}
    }
	
	private function onListItemClick(e:Object):Void
	{
		setSelectedList(e.target.index);
		if (e.isMine)
		{
			if (e.isMain)
			{
				ExternalInterface.call("eventDialog_OnListMainBtnClick", selectedBtn.index);
			}
			else
			{
				ExternalInterface.call("eventDialog_OnListSubBtnClick", selectedBtn.index, e.subIndex);
			}
		}
		if (selectedBtn == e.target) { return; }
		//if (selectedBtn.opened) { selectedBtn.subOpen(); }
		if (selectedBtn != null) { selectedBtn.selected = false; }
		selectedBtn = e.target;
		if (e.isMain)
		{
			ExternalInterface.call("eventDialog_OnListMainBtnClick", selectedBtn.index);
		}
		else
		{
			ExternalInterface.call("eventDialog_OnListSubBtnClick", selectedBtn.index, e.subIndex);
		}
	}
	
	private function onListItemChangeHeight(e:Object):Void
	{
		targetHeight = targetHeight + e.gap;
	}
	
	private function onListItemResizeItem(e:Object):Void
	{
		for (var i:Number=e.index; i<listArr.length; i++)
		{
			listArr[i]._y = listArr[i-1]._y + listArr[i-1]._height;
		}
		dispatchEvent({type:"resizeContents"});
	}
	
	private function onListClickUpdate(index:Number):Void
	{
		for (var i:Number=index; i<listArr.length; i++)
		{
			listArr[i]._y = listArr[i-1]._y + listArr[i-1]._height;
		}
		dispatchEvent({type:"resizeContents"});
	}
	
	private function removeAllList():Void
	{
		for (var i:Number=0; i<listArr.length; i++)
    	{
    		listArr[i].removeList();
    		listArr[i].removeEventListener("itemClick", this, "onListItemClick");
    		listArr[i].removeEventListener("changeHeight", this, "onListItemChangeHeight");
    		listArr[i].removeEventListener("resizeItem", this, "onListItemResizeItem");
    		listArr[i].removeMovieClip();
    	}
    	listArr = [];
    	selectedBtn = null;
    	targetHeight = 0;
    	this._y = 0;
    	dispatchEvent({type:"resizeContents"});
	}
}