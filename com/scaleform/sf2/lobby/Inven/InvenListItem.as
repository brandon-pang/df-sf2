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
import flash.external.ExternalInterface;
import com.scaleform.udk.utils.UDKUtils;
import gfx.controls.UILoader;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.sf2.lobby.Inven.InvenListItem extends ListItemRenderer
{
	private var tmc_imgload:MovieClip;
	private var tmc_camo:MovieClip;
	private var txt_item_name:TextField;
	//보유아이템 갯수
	private var txt_contain_number:TextField;	
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;
	
	private var modifyBtn:MovieClip;
	private var btnResell:Button;
	private var btnDisResell:Button;
	
	private var markMC:MovieClip;
	//private var textFieldBg:MovieClip;
	
	private var _img:String;
	private var _item_name:String;
	private var _item_modify:String;
	private var _item_select:String;
	private var _itemid:String;
	private var _imgPath:String;
	
	private var _hit:MovieClip;
	private var _prevNo:String;
	private var _setName:String;
	private var _boo:Boolean;
	private var _resell:String;
	
	private var _warning:String;
	private var _day:String;
	private var txtDayBg:MovieClip;
	
	private var pcroomIconMC:MovieClip;
	private var vipIconMC:MovieClip;
	private var _pcroom:String;
	
	private var _camoBgName:String;
	
	private var useBtn:Button;//사용버튼
	private var _NotUsed:String;
	
	private var _itemLength:String;//보유아이템 갯수
	
	private var _CamoDay:String;
	private var mcLoader:MovieClipLoader
	private var dayNo:MovieClip;
	
	private var daySetMc:MovieClip;
	private var t_expire:String
	
	private var btnReDelete:Button;
	
	public function WeaponListItem()
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
		_item_select = data.Chk
		_item_name   = data.Title;
		_itemid      = data.ItemIndex;		
		_item_modify = data.Modify
		_setName     = data.SetName;		
		_img         = data.IconImg
		//0:none 1:resell 2:resell disable
		_resell     = data.resell
		_warning    = data.Warning;
		_day        = data.Day;
		_pcroom     = data.PCRoomIcon;
		_camoBgName = data.CamoBgName;
		_NotUsed    = data.NotUsed;
		//
		_itemLength = data.ItemLength;
		_CamoDay = data.CamoDay;
		t_expire=data.Expire
		
		var img = _img
		var name = _item_name;
		var id = _itemid;
		
		lvLoader(id);
		txt_item_name.htmlText = name
		
		//trace (this.index +" ,,,"+_item_select)
		
		if (_item_select == "0")
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
        if(_item_modify!=""){
			if (Number(_item_modify) < 31)
			{
				//trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = true;
				modifyBtn.btnMc1.ani.gotoAndPlay("open");
				modifyBtn.bar._visible = true;
				modifyBtn.bar.gotoAndPlay(2)
				modifyBtn.setGaugeValue(Number(data.Modify));			
			}
			else if (Number(_item_modify) >31)
			{
				//trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = false;
				modifyBtn.bar._visible = false;
			}
			dayNo._visible = false;
			txtDayBg._visible = false;
		}else{
			modifyBtn.setGaugeValue("");
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
				txtDayBg._visible = false
				dayNo.text = ""
			}
		}
		
		var textBox:MovieClip=btnDisResell["textBox"]
		
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
			modifyBtn._visible = false;
			selectMc._visible = false;
		}else{
			useBtn._visible = false;
			selectMc._visible = true;
		}
		
		//-- 아이템 보유겟수 표시
		if(_itemLength == null||_itemLength == ""||_itemLength == "0"){
			txt_contain_number._visible = false;
			txt_contain_number.text = "";
		}else{
			txt_contain_number._visible = true;
			txt_contain_number.text = _itemLength;
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
	}
	private function lvLoader(n:String)
	{	
		var imgPathArmor:String;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit:String;
		var camoImgPath:String;
		var imgName = _img;
		var len = imgName.length;
		var chk = imgName.substr(-4);
		var mark:String = imgName.slice(-4, -1);
		var markNum:Number = Number(imgName.slice( -1));
		var camoChk:String = _camoBgName.substr(-4);	
		
		mcLoader= new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (_global.gfxPlayer)
		{
			imgPathUnit = "d:/UI_DESIGN_SVN/gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "d:/UI_DESIGN_SVN/이미지셋/장비/" + imgName + ".png";
			imgPathCashItem = "d:/UI_DESIGN_SVN/이미지셋/기능성아이템/아이템/" + imgName + ".png";
			imgPathWeapon = "d:/UI_DESIGN_SVN/이미지셋/무기/" + imgName + ".png";
			camoImgPath = "";
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
			//
			if (mark == "_mk" && !isNaN(markNum))
			{
				markNum = imgName.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}
			//
			if(_camoBgName==undefined||_camoBgName==""){
				tmc_camo._visible=false		
			}else {
				tmc_camo._visible = true
				
				if(camoChk=="_ani"){
					camoImgPath=UDKUtils.CamoImgAniPath+_camoBgName
				}else{
					camoImgPath=UDKUtils.CamoImgPath+_camoBgName
				}				
				mcLoader.loadClip(camoImgPath,tmc_camo);
			}
		}
		
		if (n == "0")
		{
			mcLoader.loadClip(imgPathArmor,tmc_imgload);
		}
		else if (n == "1")
		{
			mcLoader.loadClip(imgPathWeapon,tmc_imgload);
		}
		else if (n == "2")
		{
			mcLoader.loadClip(imgPathUnit,tmc_imgload);
		}
		else if (n == "3")
		{
			mcLoader.loadClip(imgPathCashItem,tmc_imgload);
		}
	}
	

	private function onLoadInit(mc:MovieClip)
	{
		var mcName:String=mc._name;
		var imgName:String = _img;
		//장비 무기 부대 캐쉬
		if(mc._name=="tmc_camo"){
			tmc_camo._xscale = tmc_camo._yscale = 67
		}else {
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
				tmc_imgload.gotoAndStop(imgName);
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
		// Redraw should only happen AFTER the initialization.
		if (!initialized) { return; }
		validateNow();// Ensure that the width/height is up to date.
		
		lvLoader();
		txt_item_name.htmlText = _item_name		
		//trace (this.index +" ,,,"+_item_select)		
		if (_item_select == "0")
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
		 if(_item_modify!=""){
			if (Number(_item_modify) < 31)
			{
				//trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = true;
				modifyBtn.btnMc1.ani.gotoAndPlay("open");
				modifyBtn.bar._visible = true;
				modifyBtn.bar.gotoAndPlay(2)
				modifyBtn.setGaugeValue(Number(data.Modify));			
			}
			else if (Number(_item_modify) >31)
			{
				//trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = false;
				modifyBtn.bar._visible = false;
			}
			dayNo._visible = false;
			txtDayBg._visible = false;
		}else{
			modifyBtn.setGaugeValue("");
			if(_day != ""){
				
				txtDayBg._visible = true;				
				dayNo._visible = true;
				dayNo.text = _day;
				txtDayBg._width=(dayNo.textWidth+16)
				
				if (_warning == "1")
				{
					txtDayBg.gotoAndStop(3);
				}else{
					txtDayBg.gotoAndStop(2);
				}
			}else{
				txtDayBg._visible = false
				dayNo.text = ""
			}
		}
       
		
		var textBox:MovieClip=btnDisResell["textBox"]
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
		
		//-------------------------------------피시방 아이콘 노출
		if (_pcroom != "")
		{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(_pcroom)
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
			modifyBtn._visible = false;
			selectMc._visible = false;
		}else{
			useBtn._visible = false;
			selectMc._visible = true;
		}
		//-- 아이템 보유겟수 표시
		if(_itemLength == ""||_itemLength == "0"){
			txt_contain_number._visible = false;
		}else{
			txt_contain_number._visible = true;
			txt_contain_number.text = _itemLength;
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
		
		if (constraints != null) { 
			constraints.update(width, height);
		}
		dispatchEvent( { type:"stateChange", state:state } );
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
		ExternalInterface.call("GetOverlapWeaponItemIndex",this._parent._id,this.index);				
		var __item_select = data.Chk;
		var selNo:String;		
		if (__item_select=="0") {			
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
			_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
		}
		else
		{
			_global.OnWeaponChkData(this._parent._parent._parent._id,this.index,_boo);
		}
		
	}

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
					//this._parent._parent["renderer"+i]["item"+a].txt_item_name._visible = false;
					//this._parent._parent["renderer"+i]["item"+a].textFieldBg._visible = false;
				}
				
			}
		}
		
		//trace("*************************************************** "+ id + "=" + no);
		//trace("*************************************************** "+ this._parent._parent._parent._parent["renderer"+0]._name);
		
	}
	private function onChkOverHandler(e:Object)
	{
		//----------------전체 리셋
		modifyAllReset(this.index);
		
		if(_item_modify!=""){
			if (Number(_item_modify) < 31)
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
		//textFieldBg._visible = true;
		//textFieldBg._width = txt_item_name.textWidth + 15;
		//txt_item_name._visible = true;
		_prevNo = this._name;
		//trace("index Over :=" + checkBox.selected);
		
		//_global.OnWeaponChkData(this.index,_boo);
		_global.getInvenItemOver(this._parent._parent._parent._id,this.index,"true");
		
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipView(arrowPoz.x,arrowPoz.y,_CamoDay);
		}
		
		//trace("==================== getInvenItemOver =================="+ this.index);
	}
	private function onChkOutHandler(e:Object)
	{
		if (modifyBtn.hitTest(_root._xmouse, _root._ymouse, true) == false)
		{
			trace("chkOutIn");
			//txt_item_name._visible = false;	
			if(_item_modify!=""){
				if (Number(_item_modify) < 31)
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
		//textFieldBg._visible = false;
		_global.getInvenItemOut(this._parent._parent._parent._id,this.index,"true");
		//setHidenDurability(this.index);
		//trace("==================== getInvenItemOut =================="+ this.index);
		
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipHide();
		}
	}
	
	private function onChkReleaseOutside(e:Object)
	{
		if (modifyBtn.hitTest(_root._xmouse, _root._ymouse, true) == false)
		{
			trace("chkOutIn");
			//txt_item_name._visible = false;	
			if(_item_modify!=""){
				if (Number(_item_modify) < 31)
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
		_global.getInvenItemOut(this._parent._parent._parent._id,this.index,"true");
	}
	//

	private function onModifyRollOver(e:Object)
	{
		//trace(e.target._name);
		//trace(e.target._parent._parent._name);
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
		//trace(e.target._name);
		//trace(e.target._parent._parent._name);
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
		_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
	}
	
	private function configUI():Void
	{
		constraints = new Constraints(this, true);

		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}
		
		checkBox._disableFocus = true;
		checkBox.addEventListener("press",this,"onChkHandler");	
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");

		modifyBtn.btnMc1.addEventListener("rollOver",this,"onModifyRollOver");
		modifyBtn.btnMc1.addEventListener("rollOut",this,"onModifyRollOut");
		modifyBtn.btnMc1.addEventListener("press",this,"onModifyPress");

		modifyBtn.btnMc0.addEventListener("rollOver",this,"onModifyRollOver");
		modifyBtn.btnMc0.addEventListener("rollOut",this,"onModifyRollOut");
		modifyBtn.btnMc0.addEventListener("press",this,"onModifyPress");
		
		//사용하기 버튼 클릭
		useBtn.addEventListener("rollOver",this,"onuseBtnRollOver");
		useBtn.addEventListener("rollOut",this,"onuseBtnRollOut");
		useBtn.addEventListener("press",this,"onuseBtnPress");

		if(_item_modify!=""){
			if (Number(_item_modify) < 31)
			{
				trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = true;
				modifyBtn.btnMc1.ani.gotoAndPlay("open");
				modifyBtn.bar._visible = true;
				modifyBtn.bar.gotoAndPlay(2)
				modifyBtn.setGaugeValue(Number(data.Modify));
			}
			else if (Number(_item_modify) >31)
			{
				trace("WeaponModify" + _item_modify);
				modifyBtn.btnMc0._visible = false;
				modifyBtn.btnMc1._visible = false;
				modifyBtn.bar._visible = false;
			}
		}else{
			modifyBtn.setGaugeValue("");
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
		}
		
		//===============
		// 되팔기
		//===============
		btnResell.addEventListener("click",this,"onResellHandler")
		btnResell.addEventListener("releaseOutside",this,"onResellOutSideHandler")
  		
		btnReDelete.addEventListener("click",this,"onReDelHandler")
		btnReDelete.addEventListener("releaseOutside",this,"onReDelOutSideHandler")

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
}