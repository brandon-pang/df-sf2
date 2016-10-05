import gfx.controls.ListItemRenderer;

class com.scaleform.TwoColorList extends ListItemRenderer
{
	//private var ins:Number
	// Initialization:
	public var bt:MovieClip;
	private function TwoColorList()
	{
		super();
	}
	public function setListData(index:Number, label:String, selected:Boolean):Void
	{
		this.index = index;
		if (label == null) {
			this.label = "Empty";
		} else {
			this.label = label;
		}
		this.selected = selected;
	}
	// Public Methods:
	public function setData(data:Object):Void
	{
		this.data = data;
		if (this.index%2 == 0) {
			this.bt._alpha = 0;
		}
	}
	/*private function updateAfterStateChange():Void
	{
	if (this.index%2 == 0) {
	this.bt._alpha = 0;
	}
	}
	*/

	// Private Methods:
}