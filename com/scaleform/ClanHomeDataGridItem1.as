import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;


class com.scaleform.ClanHomeDataGridItem1 extends ListItemRenderer
{

	public var field1:TextField;	// NAME
	public var field2:TextField;	// REGISTERED DATE
	public var field3:TextField;	// AGE
	public var field4:TextField;	// ID
	// Maybe a button or something?
	// Initialization:
	private function ClanHomeDataGridItem1()
	{
		super();
	}

	// Public Methods:
	public function setData(data:Object):Void
	{

		//trace(data.subscribe);

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		field1.text = data.checkbox;
		field2.text = data.lv;
		field3.text = data.codeName;
		field4.text = data.subscribe;
        invalidate();
	}
	/*private function updateAfterStateChange():Void
	{
		if (!initialized) {
			return;
		}
		validateNow();

		field1.text = data.checkbox;
		field2.text = data.lv;
		field3.text = data.codeName;
		field4.text = data.subscribe;
		field5.text = data.questions;

		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}*/	    
}