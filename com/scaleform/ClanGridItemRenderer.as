import gfx.controls.ListItemRenderer;

class com.scaleform.ClanGridItemRenderer extends ListItemRenderer
{

	// Constants:
	// Public Properties:
	// Private Properties:
	// UI Elements:
	public var field1:TextField;// ranking
	public var field2:TextField;// clanname
	public var field3:TextField;// level
	public var field4:TextField;// clanMaster
	public var field5:TextField;// member
	public var field6:TextField;// area
	public var field7:TextField;// activity

	// Maybe a button or something?

	// Initialization:
	private function ClanGridItemRenderer()
	{
		super();
	}

	// Public Methods:
	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		field1.text = data.rank;
		field2.text = data.clanName;
		field3.text = data.clanLevel;
		field4.text = data.clanMaster;
		field5.htmlText = data.memberNo;
		field6.text = data.area;
		field7.text = data.activity;
        //this.validateNow();
	}
	private function updateAfterStateChange():Void
	{
		field1.text = data.rank;
		field2.text = data.clanName;
		field3.text = data.clanLevel;
		field4.text = data.clanMaster;
		field5.htmlText = data.memberNo;
		field6.text = data.area;
		field7.text = data.activity;        
	}
	// Private Methods:

}