import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;

 class com.scaleform.udk.controls.ShopSingleItem extends ListItemRenderer
{

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var txt_type:TextField;
	private var txt_name:TextField;
	private var txt_weight:TextField;
	private var txt_context:TextField;
	private var txt_option:TextField;
	//private var txt_take:TextField;

	//private var takeBox:MovieClip;
	private var classicon:MovieClip;
	private var eventicon:MovieClip;
	private var itemimg:MovieClip;
	private var rightBtn:Button;
	private var _hit:MovieClip;

	private var _type:String;
	private var _itemname:String;
	private var _weight:String;
	private var _context:String;
	private var _option:String;

	//private var _take:String;
	private var _classicon:String;
	private var _eventicon:String;
	private var _itemimg:String;


	//var owner:ScrollingList;
	//var selectedZ:Number = -300;
	private var selectedZ:Number = -300;
	private var arrow:MovieClip;
	private var normalZ:Number = this._parent._y;

	// Initialization:

	public function ShopSingleItem()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);

		_type = data.Type;
		_itemname = data.ItemName;
		_weight = data.Weight;
		_context = data.Price;
		_option = data.Option;
		//
		//_take = data.Have;
		_classicon = data.ClassIcon;
		_eventicon = data.EventIcon;
		_itemimg = data.ItemImg;

		//_chk = data.Chk;

		UpdateTextFields();
	}
	private function lvLoader(caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if (caseBy == "class") {
			mcLoader.loadClip("imgset_class.swf",classicon);
		} else {
			var cutChr:String = _itemimg.substring(0, 2);
			trace(cutChr);
			var imgPath:String;
			if (cutChr == "KA" || cutChr == "KG") {
				imgPath = "imgset_weapon.swf";
			} else {
				imgPath = "imgset_armor.swf";
			}
			mcLoader.loadClip(imgPath,itemimg);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		trace("xxxx"+mc._name);
		if (mc._name == "classicon") {
			var lvNo:String = _classicon;
			var KD:String = lvNo.charAt(0);
			var LV:String = lvNo.charAt(1);
			var chkCl:String = lvNo.substr(2, 3);
			var CL:String;
			if (chkCl.charAt(0) == "0") {
				CL = chkCl.charAt(1);
			} else {
				CL = chkCl;
			}
			classicon.lv0.gotoAndStop(Number(CL)+1);
			classicon.lv1.gotoAndStop(Number(LV)+1);
			classicon.lv2.gotoAndStop(Number(KD)+1);
		} else {
			var imgName:String = _itemimg;
			itemimg.gotoAndStop(imgName);
		}
	}
	// Private Methods:    
	private function UpdateTextFields()
	{
		txt_type.htmlText = _type;
		txt_name.text = _itemname;
		txt_weight.text = _weight;
		txt_context.htmlText = _context;
		txt_option.htmlText = _option;


		eventicon.gotoAndStop(Number(_eventicon)+1);

		if (_classicon != "") {
			lvLoader("class");
		}
		if (_itemimg != "") {
			lvLoader("img");
		}

		this._parent.gotoAndPlay("open");
	}	
}