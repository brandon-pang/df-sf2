/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import com.scaleform.udk.utils.UDKUtils 

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
 class com.scaleform.udk.dialogs.PveShopDialogListItem extends Button
{
	public var index:Number;

	public var shortcutTxt:TextField;
	public var nameTxt:TextField;
	public var haveMC:MovieClip;
	public var price:MovieClip;
	public var imgIcon:MovieClip;
	public var markMC:MovieClip;
	public var bg:MovieClip;
	public var _itemEnabled:Boolean;


	private var mcLoader:MovieClipLoader;

	private var imgPathArmor:String = UDKUtils.ArmorImgPath;
	private var imgPathWeapon:String = UDKUtils.WeaponImgPath;
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	private var imgPathCashItem:String = UDKUtils.CashImgPath;
	private var imgPathPersonal:String = "img://Imgset_Personal_Small.";
	private var imgPathItemGroup:String = "img://Imgset_ItemGroup_Icon.";

	public function PveShopDialogListItem()
	{
		super();

		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		shortcutTxt.noTranslate = true;
		nameTxt.textAutoSize = "shrink";
		//번역이 되어야함 (13-5-7 수정)
		//nameTxt.noTranslate = true;
		haveMC.haveTxt.autoSize = true;
		haveMC.haveTxt.text = "_shop_have_item";
		price.priceTxt.noTranslate = true;
		price.priceTxt.verticalAlign = "center";
		price.priceTxt.textAutoSize = "shrink";
		
	}

	public function initItem():Void
	{
		shortcutTxt.text = "";
		_itemEnabled = true;
		nameTxt.text = "";
		haveMC._visible = false;
		price.priceTxt.text = "";
		price._visible = false;
		mcLoader.unloadClip(imgIcon);

		this.disabled = true;
	}

	public function setData(data:Object):Void
	{
		initItem();
		if (data != null)
		{
			this.disabled = false;
			this.data = data;
			_itemEnabled = !data.ItemEnabled;
			lvLoader(data.ImgSetIndex);

			itemData();
		}
	}

	private function configUI():Void
	{
		super.configUI();

		haveMC.bg._width = haveMC.haveTxt._x + haveMC.haveTxt._width + 3;
		haveMC._x = this._width - haveMC._width >> 1;

		initItem();
	}

	private function lvLoader(ImgSetIndex:String):Void
	{
		if (ImgSetIndex == "0")
		{
			mcLoader.loadClip(imgPathArmor + data.ImgSet,imgIcon);
		}
		else if (ImgSetIndex == "1")
		{
			var mark:String = data.ImgSet.slice(-4, -1);
			var markNum:Number = Number(data.ImgSet.slice(-1));
			if (mark == "_mk" && !isNaN(markNum))
			{
				data.ImgSet = data.ImgSet.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}

			var chk:String = data.ImgSet.substr(-4);
			if (chk == "_ani")
			{
				mcLoader.loadClip(UDKUtils.WeaponImgAniPath + data.ImgSet,imgIcon);
			}
			else
			{
				mcLoader.loadClip(UDKUtils.WeaponImgPath + data.ImgSet,imgIcon);
			}
		}
		else if (ImgSetIndex == "2")
		{
			mcLoader.loadClip(imgPathUnit,imgIcon);
		}
		else if (ImgSetIndex == "3")
		{
			var chk:String = data.ImgSet.substr(-4);
			if (chk == "_ani")
			{
				mcLoader.loadClip(UDKUtils.CashImgAniPath + data.ImgSet,imgIcon);
			}
			else
			{
				mcLoader.loadClip(UDKUtils.CashImgPath+ data.ImgSet,imgIcon);
			}
		}
		else if (ImgSetIndex == "6")
		{
			mcLoader.loadClip(imgPathItemGroup + data.ImgSet,imgIcon);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		if (data.ImgSetIndex == "0")
		{
			mc._x = -15;
			mc._y = 10;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
		else if (data.ImgSetIndex == "1")
		{
			mc._x = -15;
			mc._y = 10;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
		else if (data.ImgSetIndex == "2")
		{
			imgIcon.gotoAndStop(data.ImgSet);
			imgIcon.img.gotoAndStop(2);
			mc._x = 20;
			mc._y = 12;
			imgIcon._xscale = 80;
			imgIcon._yscale = 80;
		}
		else if (data.ImgSetIndex == "3" || data.ImgSetIndex == "6")
		{
			mc._x = 27;
			mc._y = 11;
			imgIcon._xscale = 70;
			imgIcon._yscale = 70;
		}
	}

	private function itemData():Void
	{
		if (data.ImgShortCut != null)
		{
			shortcutTxt.text = data.ImgShortCut;
		}
		this.disabled = _itemEnabled;
		if (data.ImgName != null)
		{
			nameTxt.text = data.ImgName;
		}

		if (_itemEnabled)
		{
			imgIcon._alpha = 50;
			shortcutTxt.textColor = 0x262626;
			nameTxt.textColor = 0x4D4D4D;
			price.priceUnit.textColor = 0x494949;
			price.priceTxt.textColor = 0x494949;
		}
		else
		{
			imgIcon._alpha = 100;
			shortcutTxt.textColor = 0x55370C;
			nameTxt.textColor = 0x888888;
			price.priceUnit.textColor = 0xffffff;
			price.priceTxt.textColor = 0xffffff;
		}
		if (data.ImgPrice != null)
		{
			price.priceTxt.text = data.ImgPrice;
			if (data.ImgSetIndex != 6)
			{
				price._visible = true;
			}
			else
			{
				price._visible = false;
			}
		}

		onLoadInit(imgIcon);

		if (data.ItemType != null)
		{
			if (data.ItemType == 0)
			{
				bg.gotoAndStop(1);
			}
			else if (data.ItemType == 1)
			{
				bg.gotoAndStop(2);
			}
			else if (data.ItemType == 2)
			{
				bg.gotoAndStop(3);
			}
			else if (data.ItemType == 3)
			{
				bg.gotoAndStop(4);
			}
		}
		else
		{
			bg.gotoAndStop(1);
		}

		if (data.ItemHave != null)
		{
			haveMC._visible = data.ItemHave;
		}
		else
		{
			haveMC._visible = false;
		}
	}

	private function updateAfterStateChange():Void
	{
		itemData();
		super.updateAfterStateChange();
	}


}