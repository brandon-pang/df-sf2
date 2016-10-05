/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.Button;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.ShopHotNewListItem extends ListItemRenderer
{
	private var itemImg:MovieClip;
	private var itemName:MovieClip;
	private var itemTitleBar:MovieClip;
	private var itemIcon:MovieClip;
	private var itemBg:MovieClip;
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;
	private var wpIcon:MovieClip;
	
	private var _itemimg:String;
	private var _itemname:String;
	private var _itemstat:String;
	private var _itemid:String;
	private var _limitCase:String
	private var _limitNo:String
	private var _limitMeNo:String

	
	private var hotIconMC:MovieClip;
	private var newIconMC:MovieClip;
	private var bestIconMC:MovieClip;
	private var SaleIconMC:MovieClip;
	
	private var buyLimitIcon:MovieClip;
	
	private var tagIconPos:Array = [138, 111, 84, 54];
	
	public function ShopHotNewListItem()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		
		_itemimg=data.IconImg
		_itemname=data.Title
		_itemstat=data.ItemStat
		_itemid=data.ItemIndex
		_limitCase=data.BuyLimitCase
	    _limitNo=data.BuyLimitNo
	    _limitMeNo=data.BuyLimitMeNo
		
		
		var img=_itemimg
		var name=_itemname
		var stat=_itemstat
		var id=_itemid
		var rnd=random(2)+3
		
		lvLoader(id)				
		
		if (data.Chk == "0") {
			selectMc.gotoAndPlay(1);
		} else {
			selectMc.gotoAndPlay("start");
		}
		
		
		if(stat=="1"){
			//hot
			itemTitleBar.gotoAndStop(2)
			itemBg.gotoAndStop(rnd)
		}else if(stat==="2"){
			//new
			itemTitleBar.gotoAndStop(3)
			itemBg.gotoAndStop(rnd)						
		}else if(stat==="3"){
			//best
			itemTitleBar.gotoAndStop(2)
			itemBg.gotoAndStop(2)			
		}else if(stat==="4"){
			//Sale
			itemTitleBar.gotoAndStop(4)
			itemBg.gotoAndStop(5)					
		}else{
			itemTitleBar.gotoAndStop(1)
			itemBg.gotoAndStop(1)
		}
		
		setTagIcon();		
		itemName.htmlText=name
	}
	
	private function setTagIcon():Void
	{
		var iconArr:Array = [];
		
		if (data.BestIcon != null && data.BestIcon != "0" && data.BestIcon != "")
		{
			iconArr.push(bestIconMC);
			bestIconMC._visible = true;
		}
		else
		{
			bestIconMC._visible = false;
		}
		
		if (data.HotIcon != null && data.HotIcon != "0" && data.HotIcon != "")
		{
			iconArr.push(hotIconMC);
			hotIconMC._visible = true;
		}
		else
		{
			hotIconMC._visible = false;
		}
		
		if (data.NewIcon != null && data.NewIcon != "0" && data.NewIcon != "")
		{
			iconArr.push(newIconMC);
			newIconMC._visible = true;
		}
		else
		{
			newIconMC._visible = false;
		}
		if (data.SaleIcon != null && data.SaleIcon != "0" && data.SaleIcon != "")
		{
			SaleIconMC._visible = true;
			SaleIconMC["txt_no"].text=data.SaleIcon
		}
		else
		{
			SaleIconMC._visible = false;
			SaleIconMC["txt_no"].text=""
		}
		
		if (data.WpIcon != null && data.WpIcon  != "0" && data.WpIcon  != ""){wpIcon.gotoAndStop(2)}
		else{wpIcon.gotoAndStop(1)}
		
		for (var i:Number=0; i<iconArr.length; i++)
		{
			iconArr[i]._x = tagIconPos[i];
		}
		
		//구매제한 관련 세팅
		if (_limitCase==null||_limitCase=="")
		{
			buyLimitIcon._visible = false;
		}else{
			buyLimitIcon._visible = true;
			//로컬
			if(_limitCase=="0"){
				buyLimitIcon["tagIcon"].gotoAndStop(1);
				buyLimitIcon["onlineMeSet"]._visible=false
				buyLimitIcon["txt"].text=_limitNo
				buyLimitIcon["tagBg"]._x=10
				buyLimitIcon["tagBg"]._width=11+buyLimitIcon["txt"].textWidth
			}
			//온라인
			if(_limitCase=="1"){
				buyLimitIcon["tagIcon"].gotoAndStop(2);				
				buyLimitIcon["txt"].text=_limitNo
				buyLimitIcon["tagBg"]._x=10
				buyLimitIcon["tagBg"]._width=11+buyLimitIcon["txt"].textWidth
				buyLimitIcon["onlineMeSet"]._visible=true
				buyLimitIcon["onlineMeSet"]["txt_me"].text=_limitMeNo
				buyLimitIcon["onlineMeSet"]["bg"]._width=buyLimitIcon["onlineMeSet"]["txt_me"].textWidth+10
			}
			
			
		}
	}
	
	private function lvLoader(n:String) {
		var imgPathArmor:String
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit
		var imgName = _itemimg;
		var len = imgName.length;
		var chk = imgName.substr(-4);		
		
		if (_global.gfxPlayer) {
			imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "gfxImgSet/Armor/"+imgName+".png";
			imgPathCashItem = "gfxImgSet/CashItem/"+imgName+".png";
			imgPathWeapon = "gfxImgSet/Weapon/"+imgName+".png";
		} else {
			imgPathUnit = "gfx_imgset_unitbox.swf";			
			imgPathArmor = UDKUtils.ArmorImgPath+imgName;
			if (chk == "_ani") {
				imgPathCashItem = UDKUtils.CashImgAniPath+imgName
				imgPathWeapon = UDKUtils.WeaponImgAniPath+imgName
			} else {
				imgPathCashItem = UDKUtils.CashImgPath+imgName
				imgPathWeapon = UDKUtils.WeaponImgPath+imgName
			}
		}
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,itemImg);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,itemImg);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,itemImg);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,itemImg);
		}		
	}
	private function onLoadComplete(mc:MovieClip)
	{
		//var imgName:String = data.IconImg;		
		//modeIcon.gotoAndStop(imgName);
	}
	private function onLoadInit(mc:MovieClip) {
		var imgName:String = _itemimg;
		//mc._xscale = 80;
		//mc._yscale = 80;
		//장비 무기 부대 캐쉬
		if (_itemid == "0") {
			mc._x = -28;
			mc._y = 35
			mc._xscale=mc._yscale=100
		} else if (_itemid == "1") {
			mc._xscale=mc._yscale=90
			mc._x = -18;
			mc._y = 36			
		} else if (_itemid == "2") {
			itemImg.gotoAndStop(imgName);
			//mc._y = 10;
			//mc._x = 40;
			mc._xscale=mc._yscale=100
		} else if (_itemid == "3") {
			mc._x = 29;
			mc._y = 34
			mc._xscale=mc._yscale=100
		}
	}

	private function updateAfterStateChange():Void
	{
		var img=_itemimg
		var name=_itemname
		var stat=_itemstat
		var id=_itemid
		var rnd=random(3)+3
		
		
		trace ("rntddddd = "+rnd)
		
		lvLoader(id)				
		
		if (data.Chk == "0") {
			selectMc.gotoAndPlay(1);
		} else {
			selectMc.gotoAndPlay("start");
		}
		
		
		if(stat=="1"){
			//hot
			itemTitleBar.gotoAndStop(2)
			itemBg.gotoAndStop(rnd)
		}else if(stat==="2"){
			//new
			itemTitleBar.gotoAndStop(3)
			itemBg.gotoAndStop(rnd)						
		}else if(stat==="3"){
			//best
			itemTitleBar.gotoAndStop(2)
			itemBg.gotoAndStop(2)			
		}else if(stat==="4"){
			//Sale
			itemTitleBar.gotoAndStop(4)
			itemBg.gotoAndStop(5)					
		}else{
			itemTitleBar.gotoAndStop(1)
			itemBg.gotoAndStop(1)
		}		
		
		setTagIcon();
		
		itemName.htmlText=name
		
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
		/*_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/ 		
		checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		//checkBox.addEventListener("click",this,"onChkHandler");
		checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	public function draw()
	{
		super.draw();

	}

	private function onChkHandler(e:Object)
	{
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		
		selectReset(_parent._parent._parent._name.substring(8),this.index);		
		var __chk = data.Chk;
		var selNo:String;		
		if (__chk=="0") {
			//_boo = true;
			selectMc.gotoAndPlay("start");
			selNo = "1";
		} else {
			//_boo = false;
			selectMc.gotoAndPlay(1);
			selNo = "0";
		}	
		data.Chk = selNo;	
		_global.OnHotNewItemChkData(this._parent._parent._parent._id,this.index,"");		
	}
	private function onDblChkHandler(e:Object){
		var selNo:String;		
		
		selectMc.gotoAndPlay("start");
		selNo = "1";
		
		data.Chk = selNo;	
		_global.OnHotNewItemChkDblData(this._parent._parent._parent._id,this.index);
	}
	private function onChkOverHandler(e:Object){	
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		_global.OnHotNewItemOverData(this._parent._parent._parent._id,this.index);
		
		if(_itemid=="0"){
			_level0.setChrItemInfoView(data.Title,data.Price_Type1,data.Price_Type2,data.Price_Type3,
										   data.Price_Value1,data.Price_Value1,data.Price_Value1,
										   data.Variations_Defence,data.Variations_Speed,data.Variations_Lucky,
										   data.BonusSP,data.Descrition,data.IconImg,data.OverlapLimit,data.ClanPoint);
		}
	}
	private function onChkOutHandler(e:Object){
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;		
		_global.OnHotNewItemOutData(this._parent._parent._parent._id,this.index);		
		
		if(_itemid=="0"){
			_level0.setChrItemInfoHide();
		}
	}
	private function selectReset(preNo,nowNo) {
		//trace (_parent._name)
		for (var i = 0; i<4; i++) {
			for (var a = 0; a<owner.dataProvider.length; a++) {		
				if (i == preNo && a == nowNo) {

				} else {
					_parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].data.Chk=0;
					_parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].selectMc.gotoAndPlay(1);
				}
			}
		}
	}
}