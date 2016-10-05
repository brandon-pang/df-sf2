/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.SpecialCharListItem extends ListItemRenderer
{
	
	public function SpecialCharListItem()
	{
		super();
		
	}

	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			visible = false;
		}
		else
		{
			this.data = data;
			visible = true;
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
}