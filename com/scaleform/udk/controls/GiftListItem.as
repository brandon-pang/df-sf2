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
import gfx.controls.Button;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.GiftListItem extends ListItemRenderer {
	private var imgTg:MovieClip;//이미지
	private var selectMc:MovieClip;//선택배경
	private var useBtn:Button;//사용버튼
	private var txtDayBg:MovieClip;//남은기간배경
	private var dayNo:TextField;//남은기간날짜
	private var txtName:TextField;//아이탬이름
	private var numberTxt:TextField;//보유아이템 갯수
	private var _stat:String;//사용하고있는지유무
	private var _day:String;//남은날
	private var _alarmDay:String;//빨간색으로표시
	private var _txt:String;//아이템이름
	private var _itemLength:String;//보유아이템 갯수
	private var urlPath:String=""
	private var classImgPath:String = urlPath+"imgset_mid_class.swf";	
	//private var imgPathArmor:String = urlPath+"gfx_imgset_armor.swf";
	//private var imgPathWeapon:String = urlPath+"gfx_imgset_weapon.swf";
	private var imgPathUnit:String = urlPath+"gfx_imgset_unitbox.swf";
	//private var imgPathCashItem:String = urlPath+"gfx_imgset_cashItem.swf";
	private var imgPathImageSet:String = urlPath+"imgset_class.swf";
	private var tgMC:MovieClip;
	private var tgMC2:MovieClip;
	private var tgMC3:MovieClip;
	private var _chk:String;
	private var _hit:MovieClip;
	private var _hit2:MovieClip;	
	private var pcroomIconMC:MovieClip;
	private var _Limitedclass:String;
	private var _GiftCodeName:String;
	private var classIcon:MovieClip;
	private var _ImageURL:String;
	private var _NotUsed:String;
	private var _indexLoad:String
	
	public function GiftListItem() {
		super();

	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);

		_stat = data.Stat;
		_txt = data.Title;
		_day = data.Day;
		_alarmDay = data.AlarmDay;
		_itemLength = data.ItemLength;
		_Limitedclass = data.Limitedclass;
		_GiftCodeName = data.GiftCodeName;
		_ImageURL = data.IconImg;
		_NotUsed = data.NotUsed;
		_indexLoad = data.ImgSet;
		
		UpdateTextFields();
	}


	private function lvLoader(n:String) {
		var imgPathArmor="img://Imgset_Armor."+_ImageURL
		
		var imgPathWeapon
		var imgPathCashItem
		
		var itemName=_ImageURL		
		var len=itemName.length
		var chk=itemName.substr(-4,len)				
		
		if(chk=="_ani"){			
			imgPathWeapon="Weapon_Ani/"+itemName+".swf";
			imgPathCashItem="CashItem_Ani/"+itemName+".swf";
		}else{
			imgPathWeapon="img://Imgset_Weapon."+itemName
			imgPathCashItem="img://Imgset_CashItem."+itemName	
		}	
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		mcLoader.unloadClip(tgMC)
		mcLoader.unloadClip(tgMC2)
		mcLoader.unloadClip(tgMC3)
		mcLoader.unloadClip(imgTg)
		mcLoader.unloadClip(classIcon)
		
		if(itemName!=undefined){
			if (n == "0") {
				mcLoader.loadClip(imgPathArmor,tgMC);			
			}else if (n == "1") {
				mcLoader.loadClip(imgPathWeapon,tgMC2);
			}else if (n == "2") {
				mcLoader.loadClip(imgPathUnit,tgMC3);
			}else if (n == "3") {
				mcLoader.loadClip(imgPathCashItem,imgTg);
			}else if (n == "4") {
				mcLoader.loadClip(classImgPath,classIcon);
			}
		}

	}
	
	private function onLoadInit(mc:MovieClip)
	{
		
	}
	
	private function onLoadComplete(mc:MovieClip) {
		if (mc._name == "classIcon") {
			var lvNo:String = _Limitedclass;
			var KD:String = lvNo.charAt(0);
			var LV:String = lvNo.charAt(1);
			var chkCl:String = lvNo.substr(2, 3);
			var CL:String;
			if (chkCl.charAt(0) == "0") {
				CL = chkCl.charAt(1);
			} else {
				CL = chkCl;
			}
			classIcon._visible = true;
			classIcon.lv0.gotoAndStop(Number(CL)+1);
			classIcon.lv1.gotoAndStop(Number(LV)+1);	
			classIcon.lv0._alpha = 75;			
		}else if (mc._name == "imgTg") {
			mc._y = -8;
		}else if (mc._name == "tgMC") {
			mc._x=-56
			mc._y=-10
		}else if (mc._name == "tgMC2") {
			mc._x=-56
			mc._y=-10
		}else if (mc._name == "tgMC3") {
			tgMC3.img.gotoAndStop(3);
		} 
		//
	}

	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}
		
		UpdateTextFields();
		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function UpdateTextFields() {
		
		classIcon._visible = false;
		
		//장비, 무기, 부대, 캐시		
		if (_indexLoad == "0") {
			lvLoader("0");					
		}else if (_indexLoad == "1") {
			lvLoader("1");			
		}else if (_indexLoad == "2") {
			lvLoader("2");			
		}else if (_indexLoad == "3") {
			lvLoader("3");
		}
		
		
		
		//아이템이름
		txtName.text = _txt;
		txtDayBg.gotoAndStop(1);
		
		//-- 아이템 보유겟수 표시
		if(_itemLength == ""||_itemLength == "0"){
			numberTxt._visible = false;
		}else{
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
		}
		
		//-- 3일 이하일 경우 표시
		if(_alarmDay == "1"){
			dayNo._visible = true;
			dayNo.text = _day;
			txtDayBg.gotoAndStop(3);
		}else{
			dayNo._visible = false;
		}
			
		if(data.PCRoomIcon == undefined){
			pcroomIconMC._visible = false;
		}
		
		if (data.PCRoomIcon != "0")
		{
			pcroomIconMC._visible = true;
		}else{
			pcroomIconMC._visible = false;
		}
		
		//-- 사용하기 버튼 노출유무
		if(_NotUsed != "" && _NotUsed != "0" && _NotUsed != undefined){
			useBtn._visible = true;
		}else{
			useBtn._visible = false;
		}
		
		//-------계급제한일때 반투명으로 보이고 계급로드하기(오버효과 안됨)
		if(_Limitedclass!="" && _Limitedclass != undefined  && _Limitedclass != "0000"){
			imgTg._alpha = 30;
			numberTxt._alpha = 80;
			lvLoader("4");	
		}else{
			imgTg._alpha = 100;
			numberTxt._alpha = 100;
			classIcon._visible = false;
		}
		
	}
	private function configUI():Void {
		constraints = new Constraints(this, true);

		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize) {
			sizeIsInvalid = true;
		}

		_hit2.onRollOver = Delegate.create(this, onhitBtnRollOver);;
		_hit2.onRollOut = Delegate.create(this, onhitBtnRollOut);
		_hit2.onPress = Delegate.create(this, onhitBtnPress);
		
		selectMc._disableFocus = true;
		selectMc.doubleClickEnabled = true;
		selectMc.addEventListener("press",this,"onChkHandler");
		selectMc.addEventListener("rollOver",this,"onChkOverHandler");
		selectMc.addEventListener("rollOut",this,"onChkOutHandler");
		selectMc.addEventListener("releaseOutside",this,"onChkReleaseOutside");
		//사용하기 버튼 클릭
		useBtn.addEventListener("rollOver",this,"onuseBtnRollOver");
		useBtn.addEventListener("rollOut",this,"onuseBtnRollOut");
		useBtn.addEventListener("press",this,"onuseBtnPress");
		
		
		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	

	private function onChkHandler(e:Object) {
		trace("index:="+this._parent._id+", "+this.index);
		_global.OnCashChkData(this._parent._parent._parent._id,this.index);
	}

	private function onChkOverHandler(e:Object) {
		
		//오버시 
		//-- 사용중인 아이템일 경우 날짜 표시 아니면 사용버튼만 표시
		if (_stat == "1") {
			dayNo._visible = true;
			dayNo.text = _day;
			if(_day != ""){
				if(_alarmDay == "1"){
					txtDayBg.gotoAndStop(3);
				}else{
					txtDayBg.gotoAndStop(2);
				}
			}else{
				txtDayBg.gotoAndStop(1);
			}
		} else {			
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		
		
	}
	private function onChkOutHandler(e:Object) {
		
		if(_alarmDay == "1"){
			dayNo._visible = true;
			txtDayBg.gotoAndStop(3);
		}else{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		
	}
	private function onChkReleaseOutside(e:Object){		

	}
	
	private function onuseBtnRollOver(e:Object)
	{
		useBtn.setState("over");
	}
	private function onuseBtnRollOut(e:Object)
	{
		useBtn.setState("up");
	}

	
	private function onhitBtnRollOver(e:Object)
	{
		selectMc.setState("over");		
		
		if (_stat == "1") {
			//useBtn._visible = false;
			dayNo._visible = true;
			dayNo.text = _day;
			if(_day != ""){
				if(_alarmDay == "1"){
					txtDayBg.gotoAndStop(3);
				}else{
					txtDayBg.gotoAndStop(2);
				}
			}else{
				txtDayBg.gotoAndStop(1);
			}
		} else {			
			//useBtn._visible = true;
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		
		var arrowPoz:Object = {x:0, y:0};
		this.localToGlobal (arrowPoz);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	

		//툴팁노출
		if(_Limitedclass != "0000" && _Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipView(_Limitedclass,arrowPoz.x,arrowPoz.y);  
		}
		if(_GiftCodeName!="" && _GiftCodeName != undefined){
			_level0.setGiftFromAndToTipView(_GiftCodeName,arrowPoz.x,arrowPoz.y);  
		}
		
		
	}
	private function onhitBtnRollOut(e:Object)
	{
		selectMc.setState("up");
		
		if(_alarmDay == "1"){
			dayNo._visible = true;
			txtDayBg.gotoAndStop(3);
		}else{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if(_Limitedclass != "0000" && _Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipHide();
		}
		if(_GiftCodeName!="" && _GiftCodeName != undefined){
			_level0.setGiftFromAndToTipHide();
		}
	}
	private function onhitBtnPress(e:Object)
	{
		selectMc.setState("up");
		
		if(_alarmDay == "1"){
			dayNo._visible = true;
			txtDayBg.gotoAndStop(3);
		}else{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if(_Limitedclass != "0000" && _Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipHide();
		}
		if(_GiftCodeName!="" && _GiftCodeName != undefined){
			_level0.setGiftFromAndToTipHide();
		}
	}
	
	public function draw() {
		super.draw();

	}
}