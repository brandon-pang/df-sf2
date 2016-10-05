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
import com.scaleform.udk.utils.UDKUtils;
import flash.external.ExternalInterface;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.PmcInvenList extends ListItemRenderer {
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	private var imgTg:MovieClip;//이미지
	private var checkBox:MovieClip;//선택배경
	private var selectMc:MovieClip;//선택표시
	private var useBtn:Button;//사용버튼
	private var txtDayBg:MovieClip;//남은기간배경
	private var dayNo:TextField;//남은기간날짜
	private var txtName:TextField;//아이탬이름
	private var numberTxt:TextField;//보유아이템 갯수
	
	private var t_stat:String;
	private var _stat:String;//사용하고있는지유무
	private var _day:String;//남은날
	private var _alarmDay:String;//빨간색으로표시
	private var t_img:String;//이미지이름
	private var _txt:String;//아이템이름
	private var _itemLength:String;//보유아이템 갯수

	//private var IconImgPath:String = "gfx_imgset_cashItem.swf";

	private var _chk:String;
	private var _NotUsed:String;
	private var _hit:MovieClip;
	//private var _hit2:MovieClip;
	
	private var pcroomIconMC:MovieClip;
	private var vipIconMC:MovieClip;
	private var _Limitedclass:String;
	
	private var daySetMc:MovieClip;
	private var t_expire:String
	
	private var _resell:String
	//private var textBox:MovieClip;
	private var btnResell:Button;
	private var btnDisResell:Button;
	private var btnReDelete:Button;

	
	
	private var _lp:String;
	private var _ap:String;
	private var _sp:String;
	private var _cp:String;
	private var _jump:String;
	private var _hp:String;
	private var _swap:String;
	private var _reload:String;

	private var mouseListener:Object;

	//private var _hitB:Boolean;
	
	public function PmcInvenList() {
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
		
		t_stat=data.ItemIndex
		_stat = data.Stat;
		t_img = data.IconImg;
		_txt = data.Title;
		_day = data.Day;
		_alarmDay = data.Warning;
		_itemLength = data.ItemLength;
		_Limitedclass = data.Limitedclass;
		_chk = data.Chk;
		_NotUsed = data.NotUsed;
		t_expire = data.Expire
		
		//0:none 1:resell 2:resell disable
		_resell = data.resell
		//lvLoader(t_stat);
		_lp = data.spNum;
		_ap = data.apNum;
		_sp = data.speedNum;
		_cp = data.clanPoint;
		_jump = data.jumpNum;
		_hp = data.hpNum;
		_swap = data.swapNum;
		_reload = data.reloadNum;
		
		UpdateTextFields();
	}


	private function lvLoader(n:String)
	{		
		var imgPathArmor:String = UDKUtils.ArmorImgPath+ t_img;
		var imgPathWeapon:String;
		var imgPathCashItem:String;

		var itemName = t_img;
		var len = itemName.length;
		var chk = itemName.substr(-4, len);
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (t_img == "" || t_img == undefined)
		{
			//Do something
		}
		else
		{
			if (_global.gfxPlayer)
			{
				imgPathCashItem = "gfxImgSet/CashItem/" + itemName + ".png";
				imgPathWeapon = "gfxImgSet/Weapon/" + itemName + ".png";
				imgPathArmor = "gfxImgSet/Armor/" + itemName + ".png";
			}
			else
			{
				if (chk == "_ani") {
					imgPathCashItem = UDKUtils.CashImgAniPath+itemName
					imgPathWeapon = UDKUtils.WeaponImgAniPath+itemName
				} else {
					imgPathCashItem = UDKUtils.CashImgPath+itemName
					imgPathWeapon = UDKUtils.WeaponImgPath+itemName
				}
			}
		}
		

		if (n == "0")
		{
			mcLoader.loadClip(imgPathArmor,imgTg);
		}
		else if (n == "1")
		{
			mcLoader.loadClip(imgPathWeapon,imgTg);
		}
		else if (n == "2")
		{
			mcLoader.loadClip(imgPathUnit,imgTg);
		}
		else if (n == "3")
		{
			mcLoader.loadClip(imgPathCashItem,imgTg);
		}
	}
	private function onLoadInit(mc:MovieClip)
	{
		if (t_stat == "0")
		{
			mc._x=-30
			mc._y=-5
			//mc._xscale=mc._yscale=30
		}
		else if (t_stat == "1")
		{
			mc._x=22
			mc._y=0
			//mc._xscale=mc._yscale=25
		}
		else if (t_stat == "2")
		{
			mc._x=22
			mc._y=0
			//mc._xscale=mc._yscale=30
			imgTg.gotoAndStop(t_img);
		}
		else if (t_stat == "3")
		{
			mc._x=28
			mc._y=0
			//mc._xscale=mc._yscale=30
		}
	}

	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}

		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function UpdateTextFields() {
		
		//아이템이름
		txtName.htmlText = _txt;
		txtDayBg.gotoAndStop(1);
		
		//-- 아이템 보유겟수 표시
		if(_itemLength == ""||_itemLength == "0"){
			numberTxt._visible = false;
		}else{
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
		}
		
		dayNo._visible = true;
		dayNo.text = _day;
		txtDayBg._width=(dayNo.textWidth+16)
		
		if(_day != ""){
			if(_alarmDay == "1"){
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}else{
			txtDayBg.gotoAndStop(1);
		}
		
		/*if (_stat == "1") {
			useBtn._visible = false;
		}else{
			useBtn._visible = true;		
		}*/
		
		if (data.PCRoomIcon == "0"||data.PCRoomIcon == ""||data.PCRoomIcon == undefined)
		{
			pcroomIconMC._visible = false;				
		}else{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(data.PCRoomIcon);
			txtDayBg._visible = false;		
		}			
		
		if (data.VipIcon == "0" || data.VipIcon == undefined || data.VipIcon == "")
		{
			vipIconMC._visible = false;
			vipIconMC.gotoAndPlay(1);
		}
		else
		{
			vipIconMC._visible = true;
			vipIconMC.gotoAndPlay("open");
		}
		
		//-------계급제한일때 반투명으로 보이고 계급로드하기(오버효과 안됨)
		if(_Limitedclass!="" && _Limitedclass != undefined){
			useBtn._visible = false;
		}else{
			useBtn._visible = true;
		}

		if (_chk == "0" || _chk == null)
		{
			selectMc.gotoAndPlay(1);
		}
		else
		{
			selectMc.gotoAndPlay("start");
		}
		
		//-- 사용하기 버튼 노출유무
		if(_NotUsed != "0" && _NotUsed != undefined){
			useBtn._visible = true;
			selectMc._visible = false;
		}else{
			useBtn._visible = false;
			selectMc._visible = true;
		}
		
		if(t_expire==""||t_expire==null){						
			daySetMc._visible=false
			daySetMc["bg_expire"]._visible=false
			daySetMc["txt_expire"].htmlText=""
		}else{						
			daySetMc._visible=true
			daySetMc["bg_expire"]._visible=true
			daySetMc["txt_expire"].htmlText=t_expire
			daySetMc["bg_expire"]._width=daySetMc["txt_expire"].textWidth+8
		}	
		
		var textBox:MovieClip = btnDisResell["textBox"]
		
		if(_resell=="1"){
			btnResell.visible=true
			btnDisResell.visible=false
			textBox.textField.text="";
			//버리기
			btnReDelete.visible=false
		}else if(_resell=="2"){
			btnResell.visible=false
			btnDisResell.visible=true
			//2주무기
			textBox.textField.text="_inven_resell_main_weapon_text";
			//버리기
			btnReDelete.visible=false
		}else if(_resell=="3"){
			btnResell.visible=false
			btnDisResell.visible=true			
			//3기타
			textBox.textField.text="_inven_resell_etc_weapon_text";
			//버리기
			btnReDelete.visible=false
				
		}else if(_resell=="4"){
			btnResell.visible=false
			btnDisResell.visible=false			
			//버리기 옵션
			textBox.textField.text="";
			//버리기
			btnReDelete.visible=true
		}else{			
			btnResell.visible=false
			btnDisResell.visible=false
			textBox.textField.text="";
			
			//버리기
			btnReDelete.visible=false			
		}
		
		lvLoader(t_stat);
	}
	private function configUI():Void {
		constraints = new Constraints(this, true);

		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		/*_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/ 
		
		
		//_hit2.onRollOver = Delegate.create(this, onhitBtnRollOver);;
		//_hit2.onRollOut = Delegate.create(this, onhitBtnRollOut);
		//_hit2.onPress = Delegate.create(this, onhitBtnPress);
		
		checkBox._disableFocus = true;
		checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		//selectMc.addEventListener("doubleClick",this,"onDblChkHandler");
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");
		//사용하기 버튼 클릭
		useBtn.addEventListener("rollOver",this,"onuseBtnRollOver");
		useBtn.addEventListener("rollOut",this,"onuseBtnRollOut");
		useBtn.addEventListener("press",this,"onuseBtnPress");
		
		//===============
		// 되팔기
		//===============
		btnResell.addEventListener("click",this,"onResellHandler")
		btnResell.addEventListener("releaseOutside",this,"onResellOutSideHandler")
  		
		btnReDelete.addEventListener("click",this,"onReDelHandler")
		btnReDelete.addEventListener("releaseOutside", this, "onReDelOutSideHandler")
		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	public function draw() {
		super.draw();

	}
	
	private function onResellHandler(e:Object){
		setBtnRelease(0)
	}
	private function onResellOutSideHandler(e:Object){
		btnResell.setState("up");
	}
	
	private function onReDelHandler(e:Object){
		setBtnRelease(1)
	}
	
	private function setBtnRelease(value:Number){
		var _v=value
		var weaponPoz:Object = {x:0, y:0};
		this.localToGlobal (weaponPoz);	
		
		_global.OnResellBtnData(this._parent._parent._parent._id,
			this.index,
			Math.ceil(weaponPoz.x),
			Math.ceil(weaponPoz.y),
			_v);
	}
	
	private function onReDelOutSideHandler(e:Object){
		btnReDelete.setState("up");
	}
	
	private function onChkHandler(e:Object):Void
	{		
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;		
		ExternalInterface.call("GetOverlapPmcItemIndex",this._parent._id,this.index);				
		var __chk = data.Chk;
		var selNo:String;		
		if (__chk=="0") {			
			selectMc.gotoAndPlay("start");
			selNo = "1";
		} else {
			selectMc.gotoAndPlay(1);
			selNo = "0";
		}		
		data.Chk = selNo;						
		//root.weaponDp[this._parent._id].dataProvider[this.index].Chk = selNo;
		if(_NotUsed != "0" && _NotUsed != undefined)
		{
			_global.OnPmcItemUseBtnClick(this._parent._parent._parent._id,this.index);
		}
		else
		{
			_global.OnPmcChkData(this._parent._parent._parent._id,this.index);
		}
	}
	
	private function onChkOverHandler(e:Object) {
		
		mouseListener.onMouseUp = Delegate.create(this, handleMouseUp);
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		
		//오버시 
		//-- 사용중인 아이템일 경우 날짜 표시 아니면 사용버튼만 표시		
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
		_global.getPmcItemOver(this._parent._parent._parent._id, this.index, "true");
		
		var armorPos:Object = {x:0, y:0};
		this.localToGlobal(armorPos);
		root.setInfoPointData(Math.ceil(armorPos.x),
							Math.ceil(armorPos.y),
							_lp,_ap,
							_sp,_cp,
							_jump,_hp,
							_swap,_reload)
		
	}
	private function onChkOutHandler(e:Object) {
		delete mouseListener.onMouseUp;
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
		_global.getPmcItemOut(this._parent._parent._parent._id,this.index,"true");
		
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		root.resetStat()
	}
	private function onChkReleaseOutside(e:Object){		
		_global.getPmcItemOut(this._parent._parent._parent._id, this.index, "true");
		
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		root.resetStat()
	}
	
	private function onuseBtnRollOver(e:Object)
	{
		useBtn.setState("over");
	}
	private function onuseBtnRollOut(e:Object)
	{
		useBtn.setState("up");
	}
	private function onuseBtnPress(e:Object)
	{
		_global.OnPmcItemUseBtnClick(this._parent._parent._parent._id,this.index);
	}
	
	private function onhitBtnRollOver(e:Object)
	{
		checkBox.setState("over");		
		
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
		
		
		var arrowPoz:Object = {x:0, y:0};
		this.localToGlobal (arrowPoz);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		
		//trace("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%% %%%%%% %%%%%% %%%%%%"+_level0);
		
		//_level0.setLimitedTipView("0012",arrowPoz.x,arrowPoz.y);  
		//툴팁노출
		if(_Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipView(_Limitedclass,arrowPoz.x,arrowPoz.y);  
		}
	}
	private function onhitBtnRollOut(e:Object)
	{
		checkBox.setState("up");
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
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if(_Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipHide();
		}
	}
	private function onhitBtnPress(e:Object)
	{
		checkBox.setState("up");
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
		_global.OnPmcItemUseBtnClick(this._parent._parent._parent._id,this.index);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if(_Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipHide();
		}
	}
	private function handleMouseUp(button, target, idx):Void
	{	
		trace (button)
		if(button==2){
			var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			root.resetStat()
			checkBox.setState("up");
		}
	}
	
}