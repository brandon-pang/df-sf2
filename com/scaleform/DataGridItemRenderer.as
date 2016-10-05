import gfx.controls.ListItemRenderer;

class com.scaleform.DataGridItemRenderer extends ListItemRenderer
{

	// Constants:
	// Public Properties:
	// Private Properties:
	// UI Elements:
	public var field1:TextField;// Pass
	public var field2:TextField;// diff
	public var field3:TextField;// no
	public var field4:TextField;// stat
	public var field5:TextField;// subject
	public var field6:TextField;// mode
	public var field7:TextField;// map
	public var field8:TextField;// player
	public var field9:TextField;// ping

	// Maybe a button or something?



	// Initialization:
	private function DataGridItemRenderer()
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

        this._visible = true
		
		this.data = data;
		field1.text = data.pass;
		//var date:Date = new Date(data.date);
		//field2.text = ((date.getMonth()+1)+"/"+date.getDate()+"/"+date.getFullYear());
		field2.text = data.diff;
		field3.text = data.no;
		field4.text = data.stat;
		field5.htmlText = data.title;
		field6.text = data.mode;
		field7.text = data.map;
		field8.text = data.player+data.tplayer;
		field9.text = data.ping;
		var boo:Boolean;
		if (data.boo == "0") {
			boo = true
		} else {
			boo = false
		}
		this.disabled = boo;
		//this.validateNow();
	}
	private function updateAfterStateChange():Void
	{
		field1.text = data.pass;
		field2.text = data.diff;
		field3.text = data.no;
		field4.text = data.stat;
		field5.htmlText = data.title;
		field6.text = data.mode;
		field7.text = data.map;
		field8.text = data.player+data.tplayer;
		field9.text = data.ping;
		var boo:Boolean;
		if (data.boo == "0") {
			boo = true
		} else {
			boo = false
		}
		this.disabled = boo;
	}



	// Private Methods:

}