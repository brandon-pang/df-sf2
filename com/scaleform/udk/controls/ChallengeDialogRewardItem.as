/**
 * ...
 * @author 
 */
 
import gfx.core.UIComponent;

class com.scaleform.udk.controls.ChallengeDialogRewardItem extends UIComponent
{
	public var imgIcon:MovieClip;
	public var markMC:MovieClip;
	public var nameTxt_normal:TextField;
	public var dayTxt:TextField;
	
    private var data:Object;
   
	private var imgPathArmor:String = "img://Imgset_Armor.";
	private var imgPathWeapon:String = "img://Imgset_Weapon.";
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	private var imgPathCashItem:String = "img://Imgset_CashItem.";
	private var imgPathPersonal:String = "img://Imgset_Personal.";
	
	private var mcLoader:MovieClipLoader;
	
	private var txtConCash:MovieClip;
	private var txtConArmo:MovieClip;
	private var txtConWeapon:MovieClip;
	private var txtConSp:MovieClip;

	public function ChallengeDialogRewardItem()
	{
		super();
	}
	
	public function removeData():Void
	{
		if (imgIcon && !imgIcon.imgs)
		{
			imgIcon.gotoAndStop(1);
		}
		else if (imgIcon && imgIcon.imgs)
		{
			imgIcon.imgs.gotoAndStop(1);
		}
		nameTxt_normal.text = "";
		dayTxt.text = "";
		data = null;
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
		
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
	}

	private function lvLoader(index:String):Void
	{
		if (index == "0") {
			mcLoader.loadClip(imgPathArmor+data.ItemImg,imgIcon);			
		}else if (index == "1") {
			var mark:String = data.ItemImg.slice(-4, -1);
			var markNum:Number = Number(data.ItemImg.slice(-1));
			if (mark == "_mk" && !isNaN(markNum))
			{
				data.ItemImg = data.ItemImg.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}
			var chk:String = data.ItemImg.substr(-4);
			if (chk == "_ani") { mcLoader.loadClip("Weapon_Ani/"+data.ItemImg+".swf", imgIcon); }
			else { mcLoader.loadClip(imgPathWeapon+data.ItemImg, imgIcon); }
		}else if (index == "2") {
			mcLoader.loadClip(imgPathUnit,imgIcon);
		}else if (index == "3") {
			mcLoader.loadClip(imgPathCashItem+data.ItemImg,imgIcon);
		}else if (index == "4") {
			mcLoader.loadClip(imgPathPersonal+data.ItemImg,imgIcon);
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (data.Index == "0")
		{
			mc._x = -27;
			mc._y = -4;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
		else if (data.Index == "1")
		{
			mc._x = -21;
			mc._y = -6;
			imgIcon._xscale = 60;
			imgIcon._yscale = 60;
		}
		else if (data.Index == "2")
		{
			imgIcon.gotoAndStop(data.ItemImg);
			imgIcon.img.gotoAndStop(2);
			mc._x = -3;
			mc._y = -13;
			imgIcon._xscale = 90;
			imgIcon._yscale = 90;
		}
		else if (data.Index == "3")
		{
			mc._x = 8;
			mc._y = -6;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
		else if (data.Index == "4")
		{
			mc._x = 23;
			mc._y = 7;
			imgIcon._xscale = 90;
			imgIcon._yscale = 90;
		}
	}
	
	private function setTxt():Void
	{
		nameTxt_normal.text = data.ItemName;
		if (nameTxt_normal.textHeight == 13)
		{
			if (data.ItemDay == "" || data.ItemDay == null) { nameTxt_normal._y = 70; dayTxt.text = "";}
			else { nameTxt_normal._y = 64; dayTxt.text = data.ItemDay;}
		}
		else
		{
			if (data.ItemDay == "" || data.ItemDay == null) { nameTxt_normal._y = 69; dayTxt.text = "";}
			else { nameTxt_normal._y = 52; dayTxt.text = data.ItemDay;}
		}
	}
	
}