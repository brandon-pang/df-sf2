/**
 * ...
 * @author 
 */

import com.scaleform.Tooltip;
import gfx.controls.Button;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.EventDialogRewardItem extends Button
{
	public var imgIcon:MovieClip;
	public var nameTxt_bank:TextField;
	public var nameTxt_normal:TextField;
	public var dayTxt:TextField;
	public var bg:MovieClip;
	public var charBg:MovieClip;
	public var charTxt:TextField;

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

	public function EventDialogRewardItem()
	{
		super();

		charBg._visible = false;
		charTxt.verticalAlign = "center";
		charTxt.textAutoSize = "shrink";
		charTxt.noTranslate = true;
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
		nameTxt_bank.text = "";
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
		charBg._visible = false;
		charTxt.text = "";
		bg.gotoAndStop(2);
		lvLoader(data.Index);
		if (data.ItemName != null && data.ItemName != "")
		{
			var message:String = data.ItemName;
			if (data.ItemDay != null && data.ItemDay != "")
			{
				message = message + " " + "<font color='#FFE1A1'>(" + data.ItemDay + ")</font>";
			}
			tooltip = message;
		}
		//setTxt(); 
	}

	private function configUI():Void
	{
		super.configUI();
		enableInitCallback = false;
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (data != null)
		{
			setData(data);
		}
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
			mcLoader.loadClip(imgPathPersonal + data.ItemImg,imgIcon);
		}
		else if (index == "5")
		{
			charBg._visible = true;
			charTxt.text = data.ItemName;
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		if (data.Index == "0")
		{
			mc._x = -28;
			mc._y = -3;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "1")
		{
			mc._x = -14;
			mc._y = 3;
			imgIcon._xscale = 40;
			imgIcon._yscale = 40;
		}
		else if (data.Index == "2")
		{
			imgIcon.gotoAndStop(data.ItemImg);
			imgIcon.img.gotoAndStop(2);
			mc._x = 5;
			mc._y = -1;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "3")
		{
			mc._x = 6;
			mc._y = -3;
			imgIcon._xscale = 50;
			imgIcon._yscale = 50;
		}
		else if (data.Index == "4")
		{
			mc._x = 15;
			mc._y = 6;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
	}

	private function setTxt():Void
	{
		if (data.Index == "1" || (data.Index == "3" && (data.ItemDay == null || data.ItemDay == "")))
		{
			nameTxt_normal.text = "";
			nameTxt_bank.text = data.ItemName;
			if (nameTxt_bank.textHeight == 13)
			{
				if (data.ItemDay == "" || data.ItemDay == null)
				{
					nameTxt_bank._y = 70;
					dayTxt.text = "";
				}
				else
				{
					nameTxt_bank._y = 64;
					dayTxt.text = data.ItemDay;
				}
			}
			else
			{
				if (data.ItemDay == "" || data.ItemDay == null)
				{
					nameTxt_bank._y = 69;
					dayTxt.text = "";
				}
				else
				{
					nameTxt_bank._y = 52;
					dayTxt.text = data.ItemDay;
				}
			}
		}
		else
		{
			nameTxt_bank.text = "";
			nameTxt_normal.text = data.ItemName;
			if (nameTxt_normal.textHeight == 13)
			{
				if (data.ItemDay == "" || data.ItemDay == null)
				{
					nameTxt_normal._y = 70;
					dayTxt.text = "";
				}
				else
				{
					nameTxt_normal._y = 64;
					dayTxt.text = data.ItemDay;
				}
			}
			else
			{
				if (data.ItemDay == "" || data.ItemDay == null)
				{
					nameTxt_normal._y = 69;
					dayTxt.text = "";
				}
				else
				{
					nameTxt_normal._y = 52;
					dayTxt.text = data.ItemDay;
				}
			}
		}
	}
}