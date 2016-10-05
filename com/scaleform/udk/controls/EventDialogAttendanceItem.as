/**
 * ...
 * @author 
 */
 
import com.scaleform.Tooltip;
import gfx.controls.Button;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.EventDialogAttendanceItem extends Button
{
	public var imgIcon:MovieClip;
	public var titleTxt:TextField;
	
	public var bg:MovieClip;
	public var charBg:MovieClip;
	public var charTxt:TextField;
	public var emptyImg:MovieClip;
	public var randomImg:MovieClip;
	public var stamp:MovieClip;
	
    public var data:Object;
   
	private var imgPathArmor:String = UDKUtils.ArmorImgPath;
	private var imgPathWeapon:String = UDKUtils.WeaponImgPath;
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	private var imgPathCashItem:String = UDKUtils.CashImgPath;
	private var imgPathPersonal:String = "img://Imgset_Personal_Small.";
	
	private var mcLoader:MovieClipLoader;
	
	private var txtConCash:MovieClip;
	private var txtConArmo:MovieClip;
	private var txtConWeapon:MovieClip;
	private var txtConSp:MovieClip;

	public function EventDialogAttendanceItem()
	{
		super();
		
		titleTxt.verticalAlign = "center";
		titleTxt.textAutoSize="shrink";
		titleTxt.noTranslate = true;
		
		charBg._visible = false;
		charTxt.verticalAlign = "center";
		charTxt.textAutoSize="shrink";
		charTxt.noTranslate = true;
		
		emptyImg._visible = false;
		randomImg._visible = false;
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
		
		titleTxt.text = data.Title;
		
		lvLoader(data.Index);
		
		if (data.ItemName != null && data.ItemName != "")
		{
			var message:String = data.ItemName;
			if (data.ItemDay != null && data.ItemDay != "") { message = message + " " + "<font color='#FFE1A1'>(" + data.ItemDay + ")</font>"; }
			tooltip = message;
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (data != null) { setData(data); }
	}

	private function lvLoader(index:String):Void
	{
		if (index == "0")
		{
			mcLoader.loadClip(imgPathArmor + data.ItemImg,imgIcon);
		}
		else if (index == "1")
		{
			var chk:String = data.ItemImg.substr(-4);
			if (chk == "_ani")
			{
				mcLoader.loadClip(UDKUtils.WeaponImgAniPath + data.ItemImg,imgIcon);
			}
			else
			{
				mcLoader.loadClip(UDKUtils.WeaponImgPath + data.ItemImg,imgIcon);
			}
		}
		else if (index == "2")
		{
			mcLoader.loadClip(imgPathUnit,imgIcon);
		}
		else if (index == "3")
		{
			var chk:String = data.ItemImg.substr(-4);
			if (chk == "_ani")
			{
				mcLoader.loadClip(UDKUtils.CashImgAniPath  + data.ItemImg,imgIcon);
			}
			else
			{
				mcLoader.loadClip(UDKUtils.CashImgPath + data.ItemImg,imgIcon);
			}
		}
		else if (index == "4")
		{
			mcLoader.loadClip(imgPathPersonal+data.ItemImg,imgIcon);
		}
		else if (index == "5")
		{
			charBg._visible = true;
			charTxt.text = data.ItemName;
		}
		else if (index == "empty")
		{
			//emptyImg._visible = true;
		}
		else if (index == "random")
		{
			randomImg._visible = true;
		}
		
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (data.Index == "0")
		{
			mc._x = -26;
			mc._y = 17;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "1")
		{
			mc._x = -13;
			mc._y = 21;
			imgIcon._xscale = 40;
			imgIcon._yscale = 40;
		}
		else if (data.Index == "2")
		{
			imgIcon.gotoAndStop(data.ItemImg);
			imgIcon.img.gotoAndStop(2);
			mc._x = 6;
			mc._y = 19;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "3")
		{
			mc._x = 7;
			mc._y = 17;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "4")
		{
			mc._x = 16;
			mc._y = 26;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
	}
	
}