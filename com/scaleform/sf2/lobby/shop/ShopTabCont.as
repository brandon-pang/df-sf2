/**
 * ...
 * @author 
 */
import com.scaleform.udk.utils.UDKUtils;
import gfx.core.UIComponent;
import gfx.controls.Button;

class com.scaleform.sf2.lobby.shop.ShopTabCont extends UIComponent
{		
	public var IconImg:String;
	public var ItemIndex:String;
	public var imgClanLimitPath = "img://Imgset_Clanmark.64.";
	public var tagIconPos:Array = [355, 327, 299];
	private var mcLoader:MovieClipLoader;
	public var title:TextField;
	public var img:MovieClip;
	public var RankTg:MovieClip;
	public var clanTg:MovieClip;
	public var saleMC:MovieClip;
	public var wToolTips:MovieClip;
	public var pcroomIconMC:MovieClip;
	public var eventIcon:MovieClip;
	public var vipIconMC:MovieClip;	
	public var bestIconMC:MovieClip;	
	public var hotIconMC:MovieClip;	
	public var newIconMC:MovieClip;	
	public var txtSp:MovieClip;	
	public var wpIcon:MovieClip;	
	public var vipTpMC:MovieClip;	
	public var markMC:MovieClip;
	
	public var btnBuy:Button;
	public var btnGift:Button;
	public var btn_w_tooltip:Button;
	
	
	
	public function ShopTabCont()
	{
		super();
	}

	//데이타 가져오기
	public function setInit(arr)
	{
		var tArr:Array = arr;
		ItemIndex=tArr.ItemIndex
		IconImg = tArr.IconImg;
		
		var weaponName:String    = tArr.WeaponName;		
		var rank:String          = tArr.Rank;
		var clan:String          = tArr.clanLimit;

		var PCRoomIcon:String    = tArr.PCRoomIcon;
		var VIPICON:String       = tArr.VIPICON;
		var VIPBONUS:String      = tArr.VIPBONUS;

		var SP:String            = tArr.SP;
		var TP:String            = tArr.TP;
		var CASH:String          = tArr.CASH;

		var newIcon:String       = tArr.NewIcon;
		var hotIcon:String       = tArr.HotIcon;
		var bestIcon:String      = tArr.BestIcon;

		var price:String         = tArr.PriceBtn;

		var eventType:String     = tArr.EventType;
		var chkWp:String         = tArr.WpIcon;
		var tocehk:String        = tArr.IsThrowWeapon;
		
		var GIFT:String          = tArr.Gift;
		var SaleIndex:String     = tArr.SaleIndex;
		var SaleSp1:String       = tArr.PCRoomSaleSp1;
		var saleSp2:String       = tArr.PCRoomSaleSp2;
		var DoNotSell:String     = tArr.DoNotSell;
		var DoNotSellInfo:String = tArr.DoNotSellInfo;
		
		var weaponToolTip:String = tArr.ToolTip;

		title.text = weaponName;

		//이미지 세팅하기
		lvLoader(IconImg,img);

		//계급 이미지 세팅하기
		if (rank != "")
		{
			if (clanTg._visible)
			{
				clanTg._visible = false;
			}
			RankTg._visible = true;
			lvLoader(rank,RankTg);
		}
		else
		{
			RankTg._visible = false;
		}

		//Set locating New HOT Best Icons
		SetIconPos(bestIcon,hotIcon,newIcon);
		//--------------- 피시방 세일 정보 노출 
		SetPcroomInfo(SaleIndex,SaleSp1,SaleSp2);
		//Set TextField locate into cash icons
		SetCashIcons(SP,CASH,TP);

		//Set Vip's Group Contents
		SetVipIcon(VIPICON,VIPBONUS);

		//Enable Set Gift Button up 
		SetGiftBtnEnable(GIFT);

		//Chk Weapon Progress (USA)
		SetWeaponProgressIcon(chkWp);

		SetEventIcon(eventType, DoNotSell, DoNotSellInfo, price);

		SetPcroomIcon(PCRoomIcon,price);

		if (weaponToolTip == "" && weaponToolTip == undefined)
		{
			wToolTips._visible = false;
		}
		else
		{
			wToolTips._visible = true;
		}

		wToolTips.ani.txt.htmlText = weaponToolTip;
		var tWid = wToolTips.ani.txt.textWidth;
		var tHei = wToolTips.ani.txt.textHeight;
		weaponTap_SetToolTip(tWid,tHei);
	}

	private function SetPcroomIcon(PCRoomIcon:String,price:String){
		if (PCRoomIcon == "" || PCRoomIcon == undefined)
		{
			pcroomIconMC._visible = false;
		}
		else
		{
			pcroomIconMC._visible = true;
			//-------------------------------------------한국용PC방표시
			pcroomIconMC.gotoAndStop(PCRoomIcon);
			eventIcon._visible = false;
			txtSp._visible = false;
			btnBuy.label = price;
		}
	}
	private function SetEventIcon(eventType:String, DoNotSell:String, 
								  DoNotSellInfo:String, price:String){
		//Enable Set Gift Button up 
		if (eventType == "EVENT")
		{
			eventIcon._visible = true;
			btnBuy.label = price;
			txtSp._visible = false;
			pcroomIconMC._visible = false;
		}
		else
		{
			eventIcon._visible = false;
			btnBuy.label = price;
		}

		//------------ 구입관련 정보 제거하기
		if (DoNotSell != "0")
		{
			spIcon._visible = false;
			btnBuy.disabled = true;
			info.text = DoNotSellInfo;
		}
		else
		{
			if (eventType != "EVENT")
			{
				spIcon._visible = true;
			}
			btnBuy.disabled = false;
			info.text = "";
		}
	}

	private function SetWeaponProgressIcon(chkWp:String)
	{
		if (chkWp != null && chkWp != "0" && chkWp != "")
		{
			btnBuy.label = price;
			btnBuy.width = 130;
			btnGift.visible = false;
			wpIcon.gotoAndStop(2);
		}
		else
		{
			if (_root.LanguageIndex == "TWN")
			{
				btnBuy.width = 130;
				btnGift._y = -1000;
				btnGift.visible = false;
			}
			else
			{
				btnBuy.width = 68;
				btnGift._y = 73;
				btnGift.visible = true;
				wpIcon.gotoAndStop(1);
			}
		}
	}

	private function SetPcroomInfo(SaleIndex:String, SaleSp1:String, SaleSp2:String)
	{
		if (SaleIndex == "1")
		{
			saleMC._visible = true;
			saleMC.pcroom._visible = true;
			saleMC.SaleIconMC._visible = false;
			saleMC.txtSp.text = SaleSp1;
			saleMC.pcroom.txtPar.text = SaleSp2;
			saleMC.pc_room_mc.gotoAndPlay(1);
			saleMC.lineMc.gotoAndStop(1);
		}
		else if (SaleIndex == "2")
		{
			saleMC._visible = true;
			saleMC.pcroom._visible = false;
			saleMC.SaleIconMC._visible = true;
			saleMC.txtSp.text = SaleSp1;
			saleMC.SaleIconMC["txt_no"].text = SaleSp2;
			saleMC.pc_room_mc.gotoAndStop(1);
			saleMC.lineMc.gotoAndStop(2);
		}
		else
		{
			saleMC._visible = false;
			SaleIconMC["txt_no"].text = "";
		}
	}

	private function SetGiftBtnEnable(GIFT:String)
	{
		if (GIFT == "0")
		{
			btnGift.disabled = true;
		}
		else
		{
			btnGift.disabled = false;
		}
	}

	private function SetVipIcon(VIPICON:String, VIPBONUS:String)
	{
		//VIP 관련
		if (VIPICON != "" && VIPICON != "0" && VIPICON != undefined)
		{
			vipIconMC._visible = true;
			vipIconMC.txt.htmlText = "<img src'" + VIPICON + "'vspace='-10'>" + _parent.vipLocTxt.text;
		}
		else
		{
			vipIconMC._visible = false;
		}

		//------------------------------------------------------------------- 보너스 sp
		if (VIPBONUS != "0" && VIPBONUS != null && VIPBONUS != undefined)
		{
			vipTpMC._visible = true;
			vipTpMC._y = 94;
			vipTpMC.textField.text = VIPBONUS;
		}
		else
		{
			vipTpMC._visible = false;
		}
	}

	private function SetCashIcons(SP:String, CASH:String, TP:String)
	{
		var iconTxt:String;
		var _localVar:String;
		var _channel:String;
		if (SP != "0" && SP != undefined && SP != "")
		{
			txtSp._visible = true;
			if (_localVar == "JPN")
			{
				iconTxt = "<img src='SHOP_SP_JPN'";
			}
			else
			{
				iconTxt = "<img src='SHOP_SP'";
			}
			txtSp.htmlText = iconTxt + " vspace='-6'>" + SP;
		}
		else if (CASH != "0" && CASH != undefined && CASH != "")
		{
			txtSp._visible = true;
			if (TP != "0" && TP != undefined)
			{
				iconTxt = "<img src='SHOP_TP' vspace='-6'><img src='SHOP_CASH'";
				txtSp.htmlText = iconTxt + " vspace='-9'>" + tArr.TP;
			}
			else
			{
				if (_localVar == "JPN")
				{
					iconTxt = "<img src='SHOP_CASH_JPN' vspace='-9'>";
				}
				else if (_localVar == "USA")
				{
					iconTxt = "<img src='SHOP_CASH_USA' vspace='-6'>";
				}
				else
				{
					if (_channel == "NAVER")
					{
						iconTxt = "<img src='SHOP_CASH_NAVER' vspace='-6'>";
					}
					else if (_channel == "HANGAME")
					{
						iconTxt = "<img src='SHOP_CASH_HANGAME' vspace='-6'>";
					}
					else
					{
						iconTxt = "<img src='SHOP_CASH' vspace='-6'>";
					}
				}
				txtSp.htmlText = iconTxt + CASH;
			}
		}
		else if (TP != "0" && TP != undefined && TP != "")
		{
			txtSp._visible = true;
			iconTxt = "<img src='SHOP_TP'";
			txtSp.htmlText = iconTxt + " vspace='-9'>" + TP;
		}
	}


	private function SetIconPos(bestIcon:String, hotIcon:String, newIcon:String):Void
	{
		var iconArr:Array = [];
		if (bestIcon != null && bestIcon != "0" && bestIcon != "")
		{
			iconArr.push(bestIconMC);
			bestIconMC._visible = true;
		}
		else
		{
			bestIconMC._visible = false;
		}

		if (hotIcon != null && hotIcon != "0" && hotIcon != "")
		{
			iconArr.push(hotIconMC);
			hotIconMC._visible = true;
		}
		else
		{
			hotIconMC._visible = false;
		}

		if (newIcon != null && newIcon != "0" && newIcon != "")
		{
			iconArr.push(newIconMC);
			newIconMC._visible = true;
		}
		else
		{
			newIconMC._visible = false;
		}

		for (var i:Number = 0; i < iconArr.length; i++)
		{
			iconArr[i]._x = tagIconPos[i];
		}
	}

	public function weaponTap_SetToolTip(w, h)
	{
		var mc = wToolTips.ani;
		bWid = mc.body._width = w + 18;
		bHei = mc.body._height = h + 20;
		centerPos = mc.arr._y = (bHei / 2) - 2;
		wToolTips._y = (27) - centerPos;
		btn_w_tooltip.addEventListener("rollOver",this,"wTooltipRollOver");
		btn_w_tooltip.addEventListener("rollOut",this,"wToolTipRollOut");
		btn_w_tooltip.addEventListener("releaseOutside",this,"wToolTipReleaseOutside");
	}

	public function wTooltipRollOver(e:Object)
	{
		var mc = wToolTips;
		mc.gotoAndPlay("open");
	}

	public function wToolTipRollOut(e:Object)
	{
		var mc = wToolTips;
		mc.gotoAndPlay("close");
	}

	public function wToolTipReleaseOutside(e:Object)
	{
		var mc = wToolTips;
		mc.gotoAndPlay("close");
	}

	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "RankTg")
		{
			var lvNo;
			lvNo = _classImg;
			if (lvNo == "3000" || lvNo == "4000" || lvNo == "1000")
			{

			}
			else
			{
				mc.set_level(lvNo);
			}
		}
		else
		{
			//
		}
	}

	private function lvLoader(_imgName, mc)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (mc._name == "img")
		{
			var imgPathArmor:String;
			var imgPathWeapon:String;
			var imgPathCashItem:String;
			var imgPathUnit;
			var imgName = IconImg;
			var len = imgName.length;
			var chk = imgName.substr(-4);
			var mark:String = imgName.slice(-4, -1);
			var markNum:Number = Number(imgName.slice(-1));

			if (_global.gfxPlayer)
			{
				imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
				imgPathArmor = "gfxImgSet/Armor/" + imgName + ".png";
				imgPathCashItem = "gfxImgSet/CashItem/" + imgName + ".png";
				imgPathWeapon = "gfxImgSet/Weapon/" + imgName + ".png";
			}
			else
			{
				imgPathUnit = "gfx_imgset_unitbox.swf";
				imgPathArmor = UDKUtils.ArmorImgPath + imgName;

				if (chk == "_ani")
				{
					imgPathCashItem = UDKUtils.CashImgAniPath + imgName;
					imgPathWeapon = UDKUtils.WeaponImgAniPath + imgName;
				}
				else
				{
					imgPathCashItem = UDKUtils.CashImgPath + imgName;
					imgPathWeapon = UDKUtils.WeaponImgPath + imgName;
				}
			}


			if (mark == "_mk" && !isNaN(markNum))
			{
				imgName = imgName.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}

			if (ItemIndex == "0")
			{
				mcLoader.loadClip(imgPathArmor,mc);
			}
			else if (ItemIndex == "1")
			{
				mcLoader.loadClip(imgPathWeapon,mc);
			}
			else if (ItemIndex == "2")
			{
				mcLoader.loadClip(imgPathUnit,mc);
			}
			else if (ItemIndex == "3")
			{
				mcLoader.loadClip(imgPathCashItem,mc);
			}
		}

		if (mc._name == "RankTg")
		{
			if (_classImg == "3000" || _classImg == "4000" || _classImg == "1000")
			{
				mcLoader.loadClip(imgClanLimitPath + _classImg,mc);
			}
			else
			{
				mcLoader.loadClip(imgPathClass,mc);
			}

		}
	}

	public function onItemBuy(e)
	{
		_global.btnWeaponBuyClicked();
	}

	public function onItemGift(e)
	{
		_global.btnItemGiftClicked();
	}

	public function onItemClose(e)
	{
		_parent.setCloseItemClick();
		_global.getItemInfoViewClose("true");
	}

	private function configUI():Void
	{
		super.configUI();
		btnBuy.addEventListener("click",this,"onItemBuy");
		btnGift.addEventListener("click",this,"onItemGift");
		btnGift.label = "_shop_btn_gift";

		var dataArr:Array=[{ItemIndex:"1",WeponName:"가나다라",IconImg:"3",SP:"1",CASH:"1",NewIcon:"1"}];
		
		setInit(dataArr)
		/*
		var weaponName:String    = tArr.WeaponName;
		var IconImg:String       = tArr.IconImg;
		var rank:String          = tArr.Rank;
		var clan:String          = tArr.clanLimit;

		var PCRoomIcon:String    = tArr.PCRoomIcon;
		var VIPICON:String       = tArr.VIPICON;
		var VIPBONUS:String      = tArr.VIPBONUS;

		var SP:String            = tArr.SP;
		var TP:String            = tArr.TP;
		var CASH:String          = tArr.CASH;

		var newIcon:String       = tArr.NewIcon;
		var hotIcon:String       = tArr.HotIcon;
		var bestIcon:String      = tArr.BestIcon;
		*/
	}

}