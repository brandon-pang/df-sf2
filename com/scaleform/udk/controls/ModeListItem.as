/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import com.scaleform.Tooltip;
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.CheckBox;
import gfx.controls.Button;
import flash.external.ExternalInterface;
import com.scaleform.udk.utils.UDKUtils;
import gfx.controls.UILoader;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ModeListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var checkBox:Button;
	private var selectMc:MovieClip;
	private var txtName:TextField;
	
	private var numberTxt:TextField;//보유아이템 갯수
	
	private var _img:String;
	private var _txt:String;
	
	private var _imgPath:String;
	private var _chk:String;
	
	private var _hit:MovieClip;
	private var _prevNo:String;
	private var _setName:String;
	
	private var _warning:String;
	private var _day:String;
	private var txtDayBg:MovieClip;
	
	private var pcroomIconMC:MovieClip;
	private var vipIconMC:MovieClip;
	private var _pcroom:String;
	
	private var useBtn:Button;//사용버튼
	private var _NotUsed:String;
	
	private var _itemLength:String;//보유아이템 갯수
	
	private var _CamoDay:String;
	
	private var mcLoader:MovieClipLoader;
	private var dayNo:MovieClip;
	
	private var daySetMc:MovieClip;
	private var t_expire:String;
	
	private var _resell:String
	//private var textBox:MovieClip;
	private var btnResell:Button;
	private var btnDisResell:Button;
	private var btnReDelete:Button;
	
	public function ModeListItem()
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
		_chk=data.Chk;	
		_txt=data.Title;
		_img=data.IconImg;		
		_warning = data.Warning;
		_day = data.Day;		
		_pcroom = data.PCRoomIcon;
		_NotUsed = data.NotUsed;
		_itemLength = data.ItemLength;
		_CamoDay = data.CamoDay;
		t_expire=data.Expire
		//0:none 1:resell 2:resell disable
		_resell = data.resell
		
		checkBox.tooltipMulti = data.Tooltip;
		
		lvLoader();
		
		txtName.htmlText = _txt;
		
		trace (this.index +" ,,,"+_chk);
		
		if (_chk == "0")
		{
			selectMc.gotoAndPlay(1);
		}
		else
		{
			selectMc.gotoAndPlay("start");
		}
		/*if (_setName != "")
		{
			selectMc.txtMount.text = _setName
		}
		else
		{
			selectMc.txtMount.text = "";
		}
		*/
		//------------------------------------- 기간제 정보 노출 추가(게이지에 값이 없을 때 노출)
		txtDayBg.gotoAndStop(1);
        
		if(_day != ""){
			txtDayBg._visible = true;				
			dayNo._visible = true;
			dayNo.text = _day;
			txtDayBg._width=(dayNo.textWidth+8)
			
			if (_warning == "1")
			{
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}else{
			txtDayBg._visible = false;
			dayNo._visible = false
			dayNo.text ="";
		}
		
	
		//-------------------------------------피시방 아이콘 노출
		if (data.PCRoomIcon == "0"||data.PCRoomIcon == ""||data.PCRoomIcon == undefined)
		{
			pcroomIconMC._visible = false;				
		}else{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(_pcroom);
			txtDayBg._visible = false;		
		}			
		
		if (data.VipIcon == "0" || data.VipIcon == undefined || data.VipIcon == "")
		{
			vipIconMC._visible = false;			
		}
		else
		{
			vipIconMC._visible = true;
			if(_root.LanguageIndex=="EUR"){				
				var vipPath="img://Imgset_VipClass_EUR.small."
				vipIconMC["vipClassLoader"].source=vipPath+data.VipIcon
			}else{
				var vipPath="img://Imgset_VipClass.small."
				vipIconMC["vipClassLoader"].source=vipPath+data.VipIcon
			}
		}
		
		//-- 사용하기 버튼 노출유무
		if(_NotUsed != "0" && _NotUsed != undefined){
			useBtn._visible = true;
			//modifyBtn._visible = false;
			selectMc._visible = false;
		}else{
			useBtn._visible = false;
			selectMc._visible = true;
		}
		
		//-- 아이템 보유겟수 표시
		if(_itemLength == ""||_itemLength == "0"){
			numberTxt._visible = false;
		}else{
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
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
	private function lvLoader()
	{		
		var IconImgPath2="gfx_imgset_camo_bg.swf";		
		var IconImgPath:String;			
		var itemName=_img;		
		var len=itemName.length
		var chk=itemName.substr(-4,len);				
		
		if(chk=="_ani"){
			IconImgPath="CashItem_Ani/"+itemName+".swf";
		}else{
			IconImgPath="img://Imgset_CashItem."+itemName;			
		}				
		
		mcLoader= new MovieClipLoader();
		mcLoader.addListener(this);
		if(itemName!=undefined){
			mcLoader.loadClip(IconImgPath,modeIcon);
		}
		/*
		if(_camoBgName=="" ||_camoBgName==undefined ){

		}else{
			mcLoader.loadClip(IconImgPath2,camoTg);
		}
		*/
	}
	private function onLoadComplete(mc:MovieClip)
	{
	
		modeIcon._x=4;
		modeIcon._y=-5;
	}
	private function onLoadingError(e) {
		// trace (mc._name+" , "+code)
		mcLoader.loadClip("",modeIcon);
	}
	private function updateAfterStateChange():Void
	{
		lvLoader();
		//txtName._visible = false;
		//textFieldBg._visible = false;
		txtName.htmlText = _txt
		
		trace (this.index +" ,,,"+_chk)
		
		if (_chk == "0")
		{
			selectMc.gotoAndPlay(1);
		}
		else
		{
			selectMc.gotoAndPlay("start");
		}
		if (_setName != "")
		{
			selectMc.txtMount.text = _setName
		}
		else
		{
			selectMc.txtMount.text = "";
		}
		
		//------------------------------------- 기간제 정보 노출 추가(게이지에 값이 없을 때 노출)
		txtDayBg.gotoAndStop(1);
		
		if(_day != ""){
			txtDayBg._visible = true;				
			dayNo._visible = true;
			dayNo.text = _day;
			txtDayBg._width=(dayNo.textWidth+8)
			
			if (_warning == "1")
			{
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}else{
			txtDayBg._visible = false;
			dayNo._visible = false
			dayNo.text ="";
		}
		
		
		//-------------------------------------피시방 아이콘 노출
		if (_pcroom != "")
		{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(_pcroom);
			txtDayBg._visible = false;			
		}else{
			pcroomIconMC._visible = false;
		}		
		if(_pcroom == undefined){
			pcroomIconMC._visible = false;
		}
		
		//-- 사용하기 버튼 노출유무
		if(_NotUsed != "0" && _NotUsed != undefined){
			useBtn._visible = true;
			//modifyBtn._visible = false;
			selectMc._visible = false;
		}else{
			useBtn._visible = false;
			selectMc._visible = true;
		}
		//-- 아이템 보유겟수 표시
		if(_itemLength == ""||_itemLength == "0"){
			numberTxt._visible = false;
		}else{
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
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
		
		
		
		checkBox._disableFocus = true;
		//checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		//checkBox.addEventListener("click",this,"onChkHandler");
		//checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");
		checkBox.addEventListener("dragOut",this,"onChkDragOut");

		
		//사용하기 버튼 클릭
		useBtn.addEventListener("rollOver",this,"onuseBtnRollOver");
		useBtn.addEventListener("rollOut",this,"onuseBtnRollOut");
		useBtn.addEventListener("press",this,"onuseBtnPress");
		
		if(_day != ""){
			txtDayBg._visible = true;
			txtDayBg.dayNo.text=_day;
			if (_warning == "1")
			{
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}
		
		//===============
		// 되팔기
		//===============
		btnResell.addEventListener("click",this,"onResellHandler")
		btnResell.addEventListener("releaseOutside",this,"onResellOutSideHandler")
  		
		btnReDelete.addEventListener("click",this,"onReDelHandler")
		btnReDelete.addEventListener("releaseOutside", this, "onReDelOutSideHandler")

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

	private function onChkHandler(e:Object)
	{		
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;		
		ExternalInterface.call("GetOverlapModeItemIndex",this._parent._id,this.index);				
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
			_global.OnModeItemUseBtnClick(this._parent._parent._parent._id,this.index);
		}
		else
		{
			_global.OnModeChkData(this._parent._parent._parent._id,this.index);
		}
		
	}
	
	/*private function onDblChkHandler(e:Object){
		var root=_parent._parent._parent._parent._parent._parent._parent._parent		
		ExternalInterface.call("GetOverlapWeaponItemIndex",this._parent._id,this.index);				
		var __chk = root.weaponDp[this._parent._id].dataProvider[this.index].Chk;
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
		root.weaponDp[this._parent._id].dataProvider[this.index].Chk = selNo;		
		_global.OnWeaponChkDblData(this._parent._id,this.index);
	}*/
	
	private function modifyAllReset(id:Number){
		
		//_global.getInvenItemOut(this._parent._id,this.index,"true");
		
		var no:Number = this._parent._parent._parent.owner["_dataProvider"].length;
		
		for(var i:Number=0; i<no; i++){
			for(var a:Number=0;a<4;a++){
				if (this._parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].modifyBtn.btnMc1._visible!=true)
				{				
					this._parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].modifyBtn.btnMc0._visible = false;
					this._parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].modifyBtn.bar.gotoAndStop(1);
					this._parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].modifyBtn.bar._visible = false;
					//this._parent._parent["renderer"+i]["item"+a].txtName._visible = false;
					//this._parent._parent["renderer"+i]["item"+a].textFieldBg._visible = false;
				}
				
			}
		}
		
		trace("*************************************************** "+ id + "=" + no);
		trace("*************************************************** "+ this._parent._parent._parent._parent["renderer"+0]._name);
		
	}
	private function onChkOverHandler(e:Object)
	{
		//----------------전체 리셋
		modifyAllReset(this.index);
		/*
		if(_modify!=""){
			if (Number(_modify) < 31)
			{
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = true;
				modifyBtn.bar._visible = true;
			}
			else
			{
				modifyBtn.btnMc0._visible = true;
				modifyBtn.btnMc1._visible = false;
				modifyBtn.bar._visible = true;
			}
			modifyBtn.setGaugeValue(Number(data.Modify));			
			modifyBtn._visible = true;			
		}
		*/
		//textFieldBg._visible = true;
		//textFieldBg._width = txtName.textWidth + 15;
		//txtName._visible = true;
		_prevNo = this._name;
		trace("index Over :=" + checkBox.selected);
		
		//_global.OnWeaponChkData(this.index,_boo);
		_global.getModeItemOver(this._parent._parent._parent._id,this.index,"true");
		
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipView(arrowPoz.x,arrowPoz.y,_CamoDay);
		}
		
		trace("==================== getInvenItemOver =================="+ this.index);
	}
	private function onChkOutHandler(e:Object)
	{
		/*
		if (modifyBtn.hitTest(_root._xmouse, _root._ymouse, true) == false)
		{
			trace("chkOutIn");
			//txtName._visible = false;	
			if(_modify!=""){
				if (Number(_modify) < 31)
				{
					modifyBtn.btnMc0._visible = false;
					modifyBtn.btnMc1._visible = true;
					modifyBtn.bar.gotoAndStop(2);
					modifyBtn.bar._visible = true;
					
				}
				else
				{
					modifyBtn.btnMc0._visible = false;
					modifyBtn.bar.gotoAndStop(1);
					modifyBtn.bar._visible = false;
					
				}
			}
		}
		else
		{
			trace("chkOut");
		}
		*/
		//textFieldBg._visible = false;
		_global.getModeItemOut(this._parent._parent._parent._id,this.index,"true");
		//setHidenDurability(this.index);
		trace("==================== getInvenItemOut =================="+ this.index);
		
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipHide();
		}
	}
	
	private function onChkReleaseOutside(e:Object)
	{
		/*
		if (modifyBtn.hitTest(_root._xmouse, _root._ymouse, true) == false)
		{
			trace("chkOutIn");
			//txtName._visible = false;	
			if(_modify!=""){
				if (Number(_modify) < 31)
				{
					modifyBtn.btnMc0._visible = false;
					modifyBtn.btnMc1._visible = true;
					modifyBtn.bar.gotoAndStop(2);
					modifyBtn.bar._visible = true;
					
				}
				else
				{
					modifyBtn.btnMc0._visible = false;
					modifyBtn.bar.gotoAndStop(1);
					modifyBtn.bar._visible = false;
					
				}
			}
		}
		else
		{
			trace("chkOut");
		}
		*/
		//textFieldBg._visible = false;
		_global.getModeItemOut(this._parent._parent._parent._id,this.index,"true");
		//setHidenDurability(this.index);
		
		trace("==================== getInvenItemOut =================="+ this.index);
	}
	//
	
	private function onChkDragOut():Void
	{
		trace("==================== getInvenItemDragOut =================="+ this.index);
	}

	private function onModifyRollOver(e:Object)
	{
		trace(e.target._name);
		trace(e.target._parent._parent._name);
		checkBox.setState("over");
		var _n = e.target._name;
		if (_n == "btnMc1")
		{
			e.target.ani.gotoAndStop(1);
		}
		else
		{

		}
	}
	private function onModifyRollOut(e:Object)
	{
		trace(e.target._name);
		trace(e.target._parent._parent._name);
		checkBox.setState("up");
		var _n = e.target._name;
		if (_n == "btnMc1")
		{
			e.target.ani.gotoAndPlay("open");
		}
		else
		{

		}
	}
	//
	private function onModifyPress(e:Object)
	{
		trace(e.target._name);
		trace(e.target._parent._parent._name);
		//checkBox.setState("over");
		var _n = e.target._name;		
	}
	
	//------------- 사용하기 버튼
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
		_global.OnModeItemUseBtnClick(this._parent._parent._parent._id,this.index);
	}
}