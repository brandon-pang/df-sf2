/**
 * ...
 * @author 
 */

import com.scaleform.TeamMemberItem;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.TeamMemberItems extends UIComponent
{
	public var item0:TeamMemberItem;
	public var item1:TeamMemberItem;
	public var item2:TeamMemberItem;
	public var item3:TeamMemberItem;
	
	private var itemArr:Array;
	
    public function TeamMemberItems()
    {         
        super();  
    }
	
	public function initItems():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			itemArr[i].initItem();
			itemArr[i].visible = false;
		}
	}
	
	public function setItemData(index:Number, data:Object):Void
	{
		if (data.Name == null || data.Name == "")
		{
			itemArr[index].visible = false;
			itemArr[index].initItem();
			return;
		}
		
		itemArr[index].visible = true;
		itemArr[index].setData(data);
		
		/*for (var i:Number=0; i<itemArr.length; i++)
		{
			if (arr[i] != null)
			{
				itemArr[i].visible = true;
				itemArr[i].setData(arr[i]);
			}
			else
			{
				itemArr[i].visible = false;
			}
		}*/
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		itemArr = [item0, item1, item2, item3];
		
		item0.visible = item1.visible = item2.visible = item3.visible = false;
	}
	
	
}