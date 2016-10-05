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

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.CashListItem extends ListItemRenderer {
	private var imgTg:MovieClip;//이미지
	private var checkBox:MovieClip;//선택배경
	private var selectMc:MovieClip;//선택표시
	private var useBtn:Button;//사용버튼
	private var txtDayBg:MovieClip;//남은기간배경
	private var dayNo:TextField;//남은기간날짜
	private var txtName:TextField;//아이탬이름
	private var numberTxt:TextField;//보유아이템 갯수

	private var _stat:String;//사용하고있는지유무
	private var _day:String;//남은날
	private var _alarmDay:String;//빨간색으로표시
	private var _img:String;//이미지이름
	private var _txt:String;//아이템이름
	private var _itemLength:String;//보유아이템 갯수

	//private var IconImgPath:String = "gfx_imgset_cashItem.swf";

	private var _chk:String;
	private var _NotUsed:String;
	private var _hit:MovieClip;
	private var _hit2:MovieClip;
	
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

	//private var _hitB:Boolean;
	
	public function CashListItem() {
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
		_img = data.ImgName;
		_txt = data.Title;
		_day = data.Day;
		_alarmDay = data.Warning;
		_itemLength = data.ItemLength;
		_Limitedclass = data.Limitedclass;
		_chk = data.Chk;
		_NotUsed = data.NotUsed;
		t_expire = data.Expire
		
		//0:none 1:resell 2:resell disable
		_resell=data.resell
		UpdateTextFields();
	}


	private function lvLoader(item) {		
		
		var IconImgPath:String;			
		var itemName=item		
		var len=itemName.length
		var chk=itemName.substr(-4,len)			
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);		
		if(chk=="_ani"){			
			IconImgPath=UDKUtils.CashImgAniPath+itemName
		}else{
			IconImgPath=UDKUtils.CashImgPath+itemName
		}		
		if(itemName!=undefined){
			mcLoader.loadClip(IconImgPath,imgTg);
		}
	}
	private function onLoadComplete(mc:MovieClip) {
		
		imgTg._y = -5;
		//imgTg.gotoAndStop(_img);
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
		
		lvLoader(_img);
		
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
		if(_NotUsed != "0" && _NotUsed != undefined)
		{
			_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
		}
		else
		{
			_global.OnCashChkData(this._parent._parent._parent._id,this.index);
		}
		
	}
	/*private function onDblChkHandler(e:Object) {
		trace("OnChrChkDblData  :="+this._parent._id+","+this.index);
		_global.OnCashChkDblData(this._parent._id,this.index);
	}*/
	private function onChkOverHandler(e:Object) {
		
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
		
		
		
	}
	private function onChkOutHandler(e:Object) {
		/*if (_stat == "1") {
			useBtn._visible = false;
		}else{
			useBtn._visible = true;		
		}*/
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
	private function onuseBtnPress(e:Object)
	{
		_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
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
		_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if(_Limitedclass!="" && _Limitedclass != undefined){
			_level0.setLimitedTipHide();
		}
	}
	
}