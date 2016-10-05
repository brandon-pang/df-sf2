/**
 * ...
 * @author 
 */

import gfx.controls.DropdownMenu;
import gfx.managers.PopUpManager;

[InspectableList("disabled", "visible", "inspectableDropdown", "inspectableItemRenderer", "inspectableScrollBar", "dropdownWidth", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "offsetX", "offsetY", "extent", "direction", "enableInitCallback", "soundMap")]
class com.scaleform.sf2.lobby.SearchFilters.DropdownEx extends DropdownMenu
{
	
    public function DropdownEx()
    {         
        super();
    }
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function populateText(item:Object):Void {
		selectedItem = item.Label
		updateLabel();
		dispatchEvent({type:"change", index:_selectedIndex, data:item});
	}
}