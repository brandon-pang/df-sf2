/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.PveResultItemRewardItem extends UIComponent
{
	public var imgIcon:MovieClip;
	public var nameTxt_bank:TextField;
	public var nameTxt_normal:TextField;
	public var dayTxt:TextField;
	
	private var data:Object;
	
	private var urlPath:String = "gamedir://\\FlashMovie\\image\\imgset\\";
    //private var urlPath:String = "gfxImgSet/";
	private var imgPathArmor:String = urlPath+"gfx_imgset_armor.swf";
	private var imgPathWeapon:String = urlPath+"gfx_imgset_weapon.swf";
	private var imgPathUnit:String = urlPath+"gfx_imgset_unitbox.swf";
	private var imgPathCashItem:String = urlPath+"gfx_imgset_cashItem.swf";
	
    public function PveResultItemRewardItem()
    {         
        super();  
    }
	
	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this._visible = false;
			return;
		}
		
		this.data = data;
		this._visible = true;
		
		lvLoader(data.Index);
		setTxt();
	}
	
	private function configUI():Void
	{
		super.configUI();
		
	}
	
	
	private function lvLoader(index:String):Void
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (index == "0") {
			mcLoader.loadClip(imgPathArmor,imgIcon);			
		}else if (index == "1") {
			mcLoader.loadClip(imgPathWeapon,imgIcon);
		}else if (index == "2") {
			mcLoader.loadClip(imgPathUnit,imgIcon);
		}else if (index == "3") {
			mcLoader.loadClip(imgPathCashItem,imgIcon);
		}
	}
	
	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "imgIcon" && !mc.imgs)
		{
			imgIcon.gotoAndStop(data.ItemImg);
		}
		else if (mc._name == "imgIcon" && mc.imgs)
		{
			imgIcon.imgs.gotoAndStop(data.ItemImg);
		}
		if (data.Index == "0")
		{
			mc._x = 45;
			mc._y = 2;
			imgIcon._xscale = 90;
			imgIcon._yscale = 90;
		}
		else if (data.Index == "1")
		{
			mc._x = 20;
			//mc._y = 4;
			imgIcon._xscale = 100;
			imgIcon._yscale = 100;
		}
		else if (data.Index == "2")
		{
			mc._x = 52;
			mc._y = -4;
			imgIcon._xscale = 100;
			imgIcon._yscale = 100;
		}
		else if (data.Index == "3")
		{
			mc._x = 54;
			//mc._y = -6;
			imgIcon._xscale = 90;
			imgIcon._yscale = 90;
		}
	}
	
	private function setTxt():Void
	{
		if (data.Index == "1" || (data.Index == "3" && (data.ItemDay == null || data.ItemDay == "")))
		{
			nameTxt_normal.text = "";
			nameTxt_bank.text = data.ItemName;
			if (data.ItemDay == "" || data.ItemDay == null) { dayTxt.text = ""; }
			else { dayTxt.text = data.ItemDay; }
		}
		else
		{
			nameTxt_bank.text = "";
			nameTxt_normal.text = data.ItemName;
			if (data.ItemDay == "" || data.ItemDay == null) { dayTxt.text = ""; }
			else { dayTxt.text = data.ItemDay; }
		}
	}
}