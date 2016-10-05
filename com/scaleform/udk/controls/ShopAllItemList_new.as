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
import gfx.controls.CheckBox;
import flash.external.ExternalInterface;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ShopAllItemList_new extends ListItemRenderer {
	 
	private var imgPathImageSet:String = "imgset_class.swf";
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";	
	private var imgPathPersonal:String = "img://Imgset_Personal_Small.";
	private var miconPath:String = "gfx_imgset_money.swf";
	
	private var tgMC:MovieClip;
	private var tgMC2:MovieClip;
	private var RankTg:MovieClip;
	private var _ImageURL:String;
	private var _Rank:String;
	private var markMC:MovieClip;
	private var dropListBtn:MovieClip;
	private var shopcheckBox:CheckBox;
	private var bonusSpMC:MovieClip;
	private var vipTpMC:MovieClip;
	private var blockMC:MovieClip;
	private var bg:MovieClip;
	private var _DataroviderArray:Array=[];
	private var _listClick:Boolean = false;
	private var _scrollToIndex:Number;
	private var _Block:String;
	private var rideoOffMC:MovieClip;
	private var _localVal;
	private var _channelVal;
	private var mcLoader:MovieClipLoader

	public function ShopAllItemList_new() {
		super();
	}

	public function setData(data:Object):Void {

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		
		//인덱스 data.Index
		//이름 data.Label
		//설명 data.ItemInfo
		//럭키포인트 data.Special
		//방어포인트 data.Armor
		//계급 data.Rank
		//아이템실제이름 data.ImageURL		
		//data.IconName "SP","TP","CASH";
		
		_localVal = _parent._parent._parent._parent._parent._parent._parent.localVar;
		_channelVal = _parent._parent._parent._parent._parent._parent._parent.channelingVar;
		
		
		if(data.Block=="1"){
			//비활성
			blockMC._visible = true;
			bg._alpha = 40;
			bonusSpMC._alpha = 40;
			dropListBtn._alpha = 40;
			RankTg._alpha = 40;
			tgMC2._alpha = 40;
			tgMC._alpha = 40;
			shopcheckBox._visible = false;
			dropListBtn.disabled = true;
			//--- 비활성 라디오버튼 노출
			rideoOffMC._visible = true;
			rideoOffMC.itemName.text = data.Label;
		}else{
			bg._alpha = 100;
			bonusSpMC._alpha = 100;
			shopcheckBox._alpha = 100;
			dropListBtn._alpha = 100;
			RankTg._alpha = 100;
			tgMC2._alpha = 100;
			tgMC._alpha = 100;
			blockMC._visible = false;
			shopcheckBox._visible = true;
			rideoOffMC._visible = false;
			dropListBtn.disabled = false;
		}
		_Block = data.Block;		
		//버튼정보 설정
		dropListBtn.txt1.text = data.IsDate;
		if (data.IsDate != null && data.IsDate != "") { dropListBtn.txt2.text = "_shop_buy_period_day"; }
		else { dropListBtn.txt2.text = ""; }	
		dropListBtn.txt3.text = data.IsPrice;			
		//아이템이름
		shopcheckBox.selected = false;
		shopcheckBox.textField.text = data.Label;
		shopcheckBox.selected = data.CheckBoxBoolean;
		//아이템 실제이름
		_ImageURL = data.ImageURL;
		//계급
		_Rank = data.Rank;		
		if (data.Rank != "0000" && data.Rank != "") {
			RankTg._visible = true;
			lvLoader("rank");
		} else if (data.Rank == "0000" ||  data.Rank == "") {
			RankTg._visible = false;
		}
		//드롭다운리스트안에 내용
		_DataroviderArray = data.DataroviderArray;		
		if(data.BonusSP !=""&&data.BonusSP!=undefined){
			bonusSpMC._visible = true;
			bonusSpMC.textField.text = data.BonusSP;
		}else{
			bonusSpMC._visible = false;
		}	
		
		if(data.VipBonus !=""&&data.VipBonus!=undefined){
			vipTpMC._visible = true;
			vipTpMC["textField"].text = data.VipBonus;
			if(bonusSpMC._visible){
				vipTpMC._y=11
			}else{
				vipTpMC._y=34
			}
		}else{
			vipTpMC._visible = false;
		}
		
		//SaleIcon
		if(data.SaleToday=="" ||data.SaleToday==undefined||data.SaleToday=="0"){
			dropListBtn.SaleMC._visible=false
		}else{
			dropListBtn.SaleMC._visible=true
			dropListBtn.SaleMC["txt_no"].text=data.SaleToday
		}
		
		lvLoader(data.Index);		
		IconLoader(miconPath,dropListBtn.iconMC)
	}
	private function IconLoader(path,mc) {		
		mcLoader.loadClip(path,mc);
	}
	
	private function lvLoader(n:String){		
		var imgPathArmor:String;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit:String;
		var itemName:String = _ImageURL;
		var chk:String;
		
		if (_global.gfxPlayer) {
			imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "gfxImgSet/Armor/"+itemName+".png";
			imgPathCashItem = "gfxImgSet/CashItem/"+itemName+".png";
			imgPathWeapon = "gfxImgSet/Weapon/"+itemName+".png";
		} else {
			imgPathUnit = "gfx_imgset_unitbox.swf";			
			imgPathArmor = UDKUtils.ArmorImgPath+itemName;
			
			var mark:String = itemName.slice(-4, -1);
			var markNum:Number = Number(itemName.slice(-1));
			if (mark == "_mk" && !isNaN(markNum))
			{
				itemName = itemName.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}
			
			chk = itemName.substr(-4);
			
			if (chk == "_ani") {
				imgPathCashItem = UDKUtils.CashImgAniPath+itemName
				imgPathWeapon = UDKUtils.WeaponImgAniPath+itemName
			} else {
				imgPathCashItem = UDKUtils.CashImgPath+itemName
				imgPathWeapon = UDKUtils.WeaponImgPath+itemName
			}
		}
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,tgMC);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,tgMC);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,tgMC);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,tgMC);
		}else if (n == "4"){
			mcLoader.loadClip(imgPathPersonal+_ImageURL,tgMC);
		}else if (n == "rank"){
			mcLoader.loadClip(imgPathImageSet,RankTg);
		}	
	}
	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "RankTg") {
			var lvNo:String = _Rank;
			var KD:String = lvNo.charAt(0);
			var LV:String = lvNo.charAt(1);
			var chkCl:String = lvNo.substr(2, 3);
			var CL:String;
			if (chkCl.charAt(0) == "0") {
				CL = chkCl.charAt(1);
			} else {
				CL = chkCl;
			}
			var rIndex1:Number;
			var rIndex2:Number;
			rIndex1 = Number(CL)+1;
			rIndex2 = Number(LV)+1;
			RankTg.lv0.gotoAndStop(rIndex1);
			RankTg.lv1.gotoAndStop(rIndex2);			
		}else if (mc._name == "tgMC") {
			if (data.Index == "0")
			{
				mc._xscale = 100;
				mc._yscale = 100;
				mc._x = -43;
				mc._y = -8;
			}
			else if (data.Index == "1")
			{
				mc._xscale = 70;
				mc._yscale = 70;
				mc._x = -5;
				mc._y = 14;
			}
			else if (data.Index == "2")
			{
				mc._xscale = 100;
				mc._yscale = 100;
				mc._x = 19;
				mc._y = 0;
			}
			else if (data.Index == "3")
			{
				mc._xscale = 100;
				mc._yscale = 100;
				mc._x = 23;
				mc._y = -3;
			}
			else if (data.Index == "4")
			{
				mc._xscale = 100;
				mc._yscale = 100;
				mc._x = 53;
				mc._y = 26;
			}
		}else if(mc._name=="iconMC"){
			if(_localVal=="JPN"){
				dropListBtn.iconMC.gotoAndStop((data.IsIcons+"_J"));
				bonusSpMC.bgMC.iconSp.gotoAndStop(2);
			}else if(_localVal=="USA"){
				if(data.IsIcons=="CASH"){
					dropListBtn.iconMC.gotoAndStop((data.IsIcons+"_USA"));
				}else{
					dropListBtn.iconMC.gotoAndStop((data.IsIcons));
				}				
				bonusSpMC.bgMC.iconSp.gotoAndStop(1);
			}else{				
				if(_channelVal=="NAVER"){
					dropListBtn.iconMC.gotoAndStop(data.IsIcons+"_NAVER");
				}else if(_channelVal=="HANGAME"){
					dropListBtn.iconMC.gotoAndStop(data.IsIcons+"_HANGAME");
				}else{
					dropListBtn.iconMC.gotoAndStop(data.IsIcons);					
				}
				bonusSpMC.bgMC.iconSp.gotoAndStop(1);
			}
		}
	}

	private function updateAfterStateChange():Void {		
		if (!initialized) {
			return;
		}			
		//버튼정보 설정
		dropListBtn.txt1.text = data.IsDate;
		if (data.IsDate != null && data.IsDate != "") { dropListBtn.txt2.text = "_shop_buy_period_day"; }
		else { dropListBtn.txt2.text = ""; }
		dropListBtn.txt3.text = data.IsPrice;			
		//아이템이름
		shopcheckBox.selected = false;
		shopcheckBox.textField.text = data.Label;
		shopcheckBox.selected = data.CheckBoxBoolean;			
		if(data.BonusSP !=""){
			bonusSpMC._visible = true;
			bonusSpMC.textField.text = data.BonusSP;
		}else{
			bonusSpMC._visible = false;
		}
		//SaleIcon
		if(data.SaleToday=="" ||data.SaleToday==undefined){
			dropListBtn.SaleMC._visible=false
		}else{
			dropListBtn.SaleMC._visible=true
			dropListBtn.SaleMC["txt_no"].text=data.SaleToday
		}
		_listClick=false;		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void {
		super.configUI();
		delete onRollOver;
		delete onRollOut;
		delete onPress;
		delete onRelease;
		delete onReleaseOutside;
		delete onDragOver;
		delete onDragOut;
		if(_Block!="1"){
			shopcheckBox.addEventListener ("click",this,"onCheckClick");
			dropListBtn.addEventListener("click",this,"onClickButton");
		}
		focusTarget = owner;
	}	
	
	private function onCheckClick (e:Object):Void
	{
		if(_Block!="1"){
			_global.onShopAllItemCheckBtnPress (this["dpId"],e.target.selected);
		}
	}
	
	private function onClickButton (e:Object):Void
	{
		if(_Block!="1"){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent;	
			_level0.setDownListView(this["dpId"],_DataroviderArray,arrowPoz.y)
		}

	}

	public function draw() {
		super.draw();
	}
	

}