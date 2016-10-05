/**
 * ...
 * @author 
 */
 
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;

class com.scaleform.udk.controls.VoteOutListItem extends ListItemRenderer {
	
	private var textField:TextField;	
	
	public function VoteOutListItem() {
		super();
	}	
	// A public version of parent method updateAfterStateChange() (Button.as).
	public function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized) {
			return;
		}
		validateNow();// Ensure that the width/height is up to date.
		
		//textField.htmlText=data.Id	
		//arrow._z = -450;
		//arrow._y = -50;
        //trace (_label)
		
		if (textField != null && _label != null) {
			textField.text = data.Id	
		}
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
		if (textField != null && _label != null) {
			textField.text = data.Id	
		}
	}
}