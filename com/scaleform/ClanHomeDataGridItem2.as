import gfx.controls.ListItemRenderer;

class com.scaleform.ClanHomeDataGridItem2 extends ListItemRenderer
{

	public var field1:TextField;	// NAME
	public var field2:TextField;	// REGISTERED DATE
	public var field3:TextField;	// AGE
	public var field4:TextField;	// ID
	// Maybe a button or something?
	
	// Maybe a button or something?
	// Initialization:
	private function ClanHomeDataGridItem2()
	{
		super();
	}
	// Public Methods:
	public function setData(data:Object):Void
	{
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
}