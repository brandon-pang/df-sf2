import gfx.utils.Delegate;
import gfx.controls.ScrollingList;
import gfx.controls.ListItemRenderer;
import gfx.controls.CoreList;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.sf2.lobby.SearchFilters.DropdownListItem extends ListItemRenderer
{	
	private var textField:TextField;
	
	public function DropdownListItem()
	{
		super();		
	}	

	public function DropDownItemRenderer()
	{
		super();
	}

	public function setListData(index:Number, label, selected:Boolean):Void
	{
		super.setListData(index,label,selected);
	}

	// A public version of parent method updateAfterStateChange() (Button.as).
	public function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized) {
			return;
		}
		validateNow();// Ensure that the width/height is up to date.
		
		textField.text = data.Label;
		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	public function setData(data:Object):Void
	{
		// If we received null data, hide this renderer.

		if (data == undefined) {
			this._visible = false;
			return;
		}
		
		
		this.data = data;
		invalidate();
		this._visible = true;
		trace (data.Label)
		textField.text = data.Label;
		
	}
}