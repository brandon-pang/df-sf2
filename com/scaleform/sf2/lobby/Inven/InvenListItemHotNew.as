/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.Button;
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.shop.ShopListItemHotNew extends ListItemRenderer
{
	private var _hit:MovieClip;
	private var itemImg:MovieClip;
	private var itemName:MovieClip;
	private var itemTitleBar:MovieClip;
	private var itemIcon:MovieClip;
	private var itemBg:MovieClip;
	private var wpIcon:MovieClip;

	private var _itemimg:String;
	private var _itemname:String;
	private var _itemstat:String;
	private var _itemid:String;
	private var _limitCase:String;
	private var _limitNo:String;
	private var _limitMeNo:String;
    
	private var _wp:String;
	private var _best:String;
	private var _hot :String;
	private var _new:String;
	private var _sale:String;
	private var _classlimit:String;
	private var _vip:String;

	private var _sp:String;
	private var _cash:String;
	private var _tp:String;
	private var _pcroom:String;
	private var _previewBtn:String;
	private var _buyBtn:String;
	private var _giftBtn:String;

	private var hotIconMC:MovieClip;
	private var newIconMC:MovieClip;
	private var bestIconMC:MovieClip;
	private var SaleIconMC:MovieClip;
	private var buyLimitIcon:MovieClip;
	private var vipIconMC:MovieClip;
	private var classIcon:MovieClip;
	private var pcroomIconMC:MovieClip;
	
	private var CashField0:TextField;
	private var CashField1:TextField;
	private var CashField2:TextField;	
	
	private var mcLoader:MovieClipLoader;
	
	private var classImgPath:String = "imgset_mid_class.swf";
	private var _localVar:String;
	private var _channel:String;
	
	private var btnBuy:Button;
	private var btnGift:Button;
	private var idn:Number;
	
	public function ShopListItemHotNew()
	{
		super();
	}

	/*
	data.IconImg
	data.Title
	data.ItemStat
	data.ItemIndex
	data.BestIcon
	data.HotIcon
	data.NewIcon 
	data.SaleIcon
	data.WpIcon
	data.BuyLimitCase
	data.BuyLimitNo
	data.BuyLimitMeNo
	data.Sp
	data.Cash
	data.Tp
	data.PreviewBtn
	data.BuyBtn
	*/

	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		idn=this.index
		this.data = data;
		this._visible = true;

		_itemimg    = data.IconImg;
		_itemname   = data.Title;
		_itemstat   = data.ItemStat;
		_itemid     = data.ItemIndex;
		_limitCase  = data.BuyLimitCase;
		_limitNo    = data.BuyLimitNo;
		_limitMeNo  = data.BuyLimitMeNo;

		_wp         = data.WpIcon;
		_best       = data.BestIcon;
		_hot        = data.HotIcon;
		_new        = data.NewIcon;
		_sale       = data.SaleIcon;
		_classlimit = data.ClassLimit;
		_vip        = data.VipIcon;

		_sp         = data.Sp;
		_cash       = data.Cash;
		_tp         = data.Tp;
		_pcroom     = data.PcRoomStat;
		
		_previewBtn = data.PreviewBtnEnable;
		_buyBtn     = data.BuyBtnEnable;
		_giftBtn    = data.GiftBtnEnable;

		var img = _itemimg;
		var name = _itemname;
		var stat = _itemstat;
		var id = _itemid;
		var rnd = random(2) + 3;
		
		lvLoader(id);
		
		if (stat == "1")
		{
			//hot
			itemTitleBar.gotoAndStop(2);
			itemBg.gotoAndStop(rnd);
		}
		else if (stat === "2")
		{
			//new
			itemTitleBar.gotoAndStop(3);
			itemBg.gotoAndStop(rnd);
		}
		else if (stat === "3")
		{
			//best
			itemTitleBar.gotoAndStop(2);
			itemBg.gotoAndStop(2);
		}
		else if (stat === "4")
		{
			//Sale
			itemTitleBar.gotoAndStop(4);
			itemBg.gotoAndStop(5);
		}
		else
		{
			itemTitleBar.gotoAndStop(1);
			itemBg.gotoAndStop(1);
		}

		setTagIcon();
		setCashIcon();
		setBtnAlign();
		
		itemName.htmlText = name;
	}
	private function setBtnAlign() {
		var iconArr:Array = [];
		var iconWid:Array = [];
		var pos = 85;
		var iconTxt:String;
		
		if (_giftBtn != null && _giftBtn != "0" && _giftBtn != "")
		{
			btnGift._visible = true;
			iconArr.push(btnGift);
			iconWid.push(pos);
			pos = pos - 24;
			
		}else {
			btnGift._visible = false;
		}
		
		if (_buyBtn != null && _buyBtn != "0" && _buyBtn != "")
		{
			btnBuy._visible = true;
			iconArr.push(btnBuy);
			iconWid.push(pos);
			pos = pos - 24;
			
		}else {
			btnBuy._visible = false;
		}
		
		var iconLen:Number=iconArr.length
		for (var i:Number = 0; i < iconLen; i++)
		{
			iconArr[i]._y = iconWid[i];
		}
	}
	private function setCashIcon() {
		
		var iconArr:Array = [];
		var iconWid:Array = [];
		var pos = 85;
		var iconTxt:String;
		
		if (_pcroom != null && _pcroom != "0" && _pcroom != "")
		{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(_pcroom);
			iconArr.push(pcroomIconMC);
			pos = 96
			iconWid.push(pos);
			pos = pos - 32;
			
		}else {
			pcroomIconMC._visible = false;
		}
		
		if (_sp != null && _sp != "0" && _sp != "")
		{
			CashField0._visible = true;
			if(_localVar=="JPN"){
				iconTxt = "<img src='SHOP_SP_JPN'";
			}else{
				iconTxt = "<img src='SHOP_SP'";
			}
			CashField0.htmlText = iconTxt + " vspace='-6'>" + _sp;
			
			iconArr.push(CashField0);
			iconWid.push(pos);
			pos = pos - 16;
			
		}else {
			CashField0._visible = false;
		}

		if (_cash != null && _cash != "0" && _cash != "")
		{	
			CashField1._visible = true;
			if(_localVar=="JPN"){
				iconTxt = "<img src='SHOP_CASH_JPN' vspace='-9'>";			
			}else if(_localVar=="USA"){
				iconTxt = "<img src='SHOP_CASH_USA' vspace='-6'>";
			}else{
				if(_channel=="NAVER"){
					iconTxt = "<img src='SHOP_CASH_NAVER' vspace='-6'>";				
				}else if(_channel=="HANGAME"){
					iconTxt = "<img src='SHOP_CASH_HANGAME' vspace='-6'>";			
				}else{
					iconTxt = "<img src='SHOP_CASH' vspace='-6'>";				
				}				
			}
			CashField1.htmlText =iconTxt+_cash;
			
			iconArr.push(CashField1);
			iconWid.push(pos);
			pos = pos - 16;
		}else {
			CashField1._visible=false
		}

		if (_tp != null && _tp != "0" && _tp != "")
		{
			CashField2._visible=true
			iconTxt = "<img src='SHOP_TP'";
			CashField2.htmlText = iconTxt + " vspace='-5' width='26' height='16'>" + _tp;
			iconArr.push(CashField2);
			iconWid.push(pos);
			pos = pos - 20;
		}else {
			CashField2._visible=false
		}
		
		var iconLen:Number=iconArr.length
		for (var i:Number = 0; i < iconLen; i++)
		{
			iconArr[i]._y = iconWid[i];
		}
		
	}
	private function setTagIcon():Void
	{
		var iconArr:Array = [];
		var iconWid:Array = [];
		var pos = 185;
		var vipName:String;

		if (_classlimit != null && _classlimit != "0" && _classlimit != "")
		{
			mcLoader.loadClip(classImgPath,classIcon);
			classIcon._visible = true
			iconArr.push(classIcon);
			iconWid.push(pos);
			pos = pos - 24;
		}
		else
		{
			classIcon._visible = false
			mcLoader.unloadClip(classIcon);
		}

		if (_vip != null && _vip != "0" && _vip != "")
		{
			vipIconMC._visible = true
			if(_root.LanguageIndex=="EUR"){
				vipName=_vip+"_EUR";
			}else{
				vipName=_vip;
			}
			iconArr.push(vipIconMC);
			iconWid.push(pos);
			vipIconMC.gotoAndStop(vipName);			
			pos = pos - 24;
		}
		else
		{
			vipIconMC._visible = false
		}

		if (_wp != null && _wp != "0" && _wp != "")
		{
			iconArr.push(wpIcon);
			iconWid.push(pos);
			wpIcon.gotoAndStop(2);
			pos = pos - 24;
		}
		else
		{
			wpIcon.gotoAndStop(1);
		}

		if (_hot != null && _hot != "0" && _hot != "")
		{
			iconArr.push(hotIconMC);
			iconWid.push(pos);
			hotIconMC._visible = true;
			pos = pos - 14;
		}
		else
		{
			hotIconMC._visible = false;
		}

		if (_new != null && _new != "0" && _new != "")
		{
			iconArr.push(newIconMC);
			iconWid.push(pos);
			newIconMC._visible = true;
			pos = pos - 16;
		}
		else
		{
			newIconMC._visible = false;
		}

		if (_best != null && _best != "0" && _best != "")
		{
			iconArr.push(bestIconMC);
			iconWid.push(pos);
			bestIconMC._visible = true;

		}
		else
		{
			bestIconMC._visible = false;
		}

		if (_sale != null && _sale != "0" && _sale != "")
		{
			SaleIconMC._visible = true;
			SaleIconMC["txt_no"].text = data.SaleIcon;
		}
		else
		{
			SaleIconMC._visible = false;
			SaleIconMC["txt_no"].text = "";
		}


		//구매제한 관련 세팅
		if (_limitCase == null || _limitCase == "")
		{
			buyLimitIcon._visible = false;
		}
		else
		{
			buyLimitIcon._visible = true;
			//로컬
			if (_limitCase == "0")
			{
				buyLimitIcon["tagIcon"].gotoAndStop(1);
				buyLimitIcon["onlineMeSet"]._visible = false;
				buyLimitIcon["txt"].text = _limitNo;
				buyLimitIcon["tagBg"]._x = 10;
				buyLimitIcon["tagBg"]._width = 11 + buyLimitIcon["txt"].textWidth;
			}
			//온라인 
			if (_limitCase == "1")
			{
				buyLimitIcon["tagIcon"].gotoAndStop(2);
				buyLimitIcon["txt"].text = _limitNo;
				buyLimitIcon["tagBg"]._x = 10;
				buyLimitIcon["tagBg"]._width = 11 + buyLimitIcon["txt"].textWidth;
				buyLimitIcon["onlineMeSet"]._visible = true;
				buyLimitIcon["onlineMeSet"]["txt_me"].text = _limitMeNo;
				buyLimitIcon["onlineMeSet"]["bg"]._width = buyLimitIcon["onlineMeSet"]["txt_me"].textWidth + 10;
			}
		}

		var iconLen:Number=iconArr.length
		for (var i:Number = 0; i < iconLen; i++)
		{
			iconArr[i]._x = iconWid[i];
		}
	}

	private function lvLoader(n:String)
	{
		var imgPathArmor:String;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit:String;
		var imgName = _itemimg;
		var len = imgName.length;
		var chk = imgName.substr(-4);

		if (_global.gfxPlayer)
		{
			imgPathUnit = "d:/UI_DESIGN_SVN/gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "d:/UI_DESIGN_SVN/이미지셋/장비/" + imgName + ".png";
			imgPathCashItem = "d:/UI_DESIGN_SVN/이미지셋/기능성아이템/아이템/" + imgName + ".png";
			imgPathWeapon = "d:/UI_DESIGN_SVN/이미지셋/무기/" + imgName + ".png";
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

		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "0")
		{
			mcLoader.loadClip(imgPathArmor,itemImg);
		}
		else if (n == "1")
		{
			mcLoader.loadClip(imgPathWeapon,itemImg);
		}
		else if (n == "2")
		{
			mcLoader.loadClip(imgPathUnit,itemImg);
		}
		else if (n == "3")
		{
			mcLoader.loadClip(imgPathCashItem,itemImg);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		var mcName:String=mc._name;
		var imgName:String = _itemimg;

		if(mcName=="classIcon"){
			var lvNo:String = _classlimit;			
			classIcon._visible = true;
			classIcon.set_level(lvNo)			
			//classIcon.lv0._alpha = 75;
		}else{
			//장비 무기 부대 캐쉬
			if (_itemid == "0")
			{
				mc._xscale = mc._yscale = 85;
				mc._x = -10;
				mc._y = 5;
			}
			else if (_itemid == "1")
			{
				mc._xscale = mc._yscale = 85;
				mc._x = -16;
				mc._y = 8;
			}
			else if (_itemid == "2")
			{
				itemImg.gotoAndStop(imgName);
				//mc._y = 10;
				//mc._x = 40;
				mc._xscale = mc._yscale = 100;
			}
			else if (_itemid == "3")
			{
				mc._xscale = mc._yscale = 82;
				mc._x = 42;
				mc._y = 12;
			}
		}
	}

	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void
	{
		constraints = new Constraints(this, true);
		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}

		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		
		btnBuy._disableFocus = true;
		btnGift._disableFocus = true;
		
		btnBuy._visible = false;
		btnGift._visible = false;
		
		btnBuy.addEventListener("click", this, "onClickBuy");
		btnGift.addEventListener("click", this, "onClickGift");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		
		_channel  = _root.ChannelIndex;
		_localVar = _root.LanguageIndex;
	}
	private function handleMouseRollOver(controllerIdx:Number):Void {
		if (_disabled) { return; }
		if ((!_focused && !_displayFocus) || focusIndicator != null) { setState("over"); }
		dispatchEventAndSound( { type:"rollOver", controllerIdx:controllerIdx } );
		
		if (_giftBtn != null && _giftBtn != "0" && _giftBtn != "")
		{
			btnGift._visible = true;			
		}else {
			btnGift._visible = false;
		}
		
		if (_buyBtn != null && _buyBtn != "0" && _buyBtn != "")
		{
			btnBuy._visible = true;			
		}else {
			btnBuy._visible = false;
		}
	}
	private function handleMousePress(controllerIdx:Number, keyboardOrMouse:Number, button:Number):Void {
		if (_disabled) { return; }
		if (!_disableFocus) { Selection.setFocus(this, controllerIdx); }
		setState("down"); // Focus changes in the setState will override those in the changeFocus (above)
		dispatchEventAndSound({type:"press", controllerIdx:controllerIdx, button:button});		
		if (autoRepeat) {
			buttonRepeatInterval = setInterval(this, "beginButtonRepeat", buttonRepeatDelay, controllerIdx, button);
		}
	}
	
	private function onClickBuy(e:Object):Void {
		ExternalInterface.call("BtnBuyClick", "");
	}
	private function onClickGift(e:Object):Void {
		ExternalInterface.call("BtnGiftClick", "");
	}
	
	public function draw()
	{
		super.draw();
	}
}