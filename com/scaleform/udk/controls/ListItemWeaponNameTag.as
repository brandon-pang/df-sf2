/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.Button;
import com.scaleform.udk.utils.UDKUtils;


[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ListItemWeaponNameTag extends ListItemRenderer {
	private var modeIcon:MovieClip;
	private var markMC:MovieClip;
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;
	private var unselectMc:MovieClip;
	private var txtBox:MovieClip;
	private var txtName:TextField;
	private var txtBg:MovieClip;
	private var camo_bg:MovieClip;
	private var tagIcon:MovieClip;
	private var _weaponImg:String;
	private var _weaponName:String;

	private var _chk:String;
	private var _hit:MovieClip;
	private var _boo:Boolean;
	private var _camobg:String;
	private var _tag:String;
	private var _CamoDay:String;
	
	public function ListItemWeaponNameTag() {
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

		_chk = data.Chk;
		_weaponName = data.WeaponName;
		_weaponImg = data.WeaponImg;
		_camobg = data.CamoBgName;
		_tag=data.Tag;
		_CamoDay = data.CamoDay;
		
		UpdateTextFields();
	}
	private function lvLoader() {
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);		
		var IconImgPath:String;
		var camoBgPath:String;
		var itemName:String = _weaponImg;
		
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
		
		var chk:String = itemName.substr(-4);
		
		if(chk=="_ani"){
			IconImgPath=UDKUtils.WeaponImgAniPath+itemName
		}else{
			IconImgPath=UDKUtils.WeaponImgPath+itemName;
		}
		mcLoader.loadClip(IconImgPath,modeIcon);		
		
		if (_camobg == null || _camobg == "")
		{
			mcLoader.unloadClip(camo_bg);
		}
		else
		{
			var camoChk:String = _camobg.substr(-4);
			if (camoChk == "_ani")
			{
				camoBgPath = UDKUtils.CamoImgAniPath + _camobg;
			}
			else
			{
				camoBgPath = UDKUtils.CamoImgPath + _camobg;
			}
			mcLoader.loadClip(camoBgPath,camo_bg);
		}

	}

	//onLoadComplete
	//onLoadInit
	private function onLoadComplete(mc:MovieClip) {
		if (mc._name == "modeIcon") {
			var imgName:String = _weaponImg;
			//modeIcon.gotoAndStop(imgName);
			modeIcon._xscale = 70;
			modeIcon._yscale = 70;
			mc._x=-30
			mc._y=0
		} else {
			var camoName:String = _camobg;
			//camo_bg.gotoAndStop(camoName);
			camo_bg._xscale = 50;
			camo_bg._yscale = 50;
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
		lvLoader();

		txtName.text = _weaponName;
		trace(this.index+" ,,,"+_chk);
		if (_chk == "0") {
			_boo = false;
			checkBox._alpha = 100;
			selectMc.gotoAndPlay(1);
		} else {
			_boo = true;
			checkBox._alpha = 0;
			selectMc.gotoAndPlay("start");
		}
		
		if (data.Stat == "1") {
			checkBox.disabled = true;
			unselectMc.gotoAndStop(2);
		} else {
			checkBox.disabled = false;
			unselectMc.gotoAndStop(1);
		}
		if(_tag=="1"){
			tagIcon.gotoAndStop(2)
		}else{
			tagIcon.gotoAndStop(1)
		}
		
		var format1:TextFormat = new TextFormat();
		format1.letterSpacing = -1;

		txtBox._visible = false;
		txtBg._visible = false;
		txtBox["txt_name"].text = _weaponName;
		txtBox["txt_name"].setTextFormat(format1);
		trace(txtBox["txt_name"].textWidth);
		txtBg._width = txtBox["txt_name"].textWidth+10;
	}


	private function configUI():Void {
		constraints = new Constraints(this, true);

		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}

		checkBox._disableFocus = true;
		checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		//checkBox.addEventListener("click",this,"onChkHandler");
		//checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}



	public function draw() {
		super.draw();
	}

	
	private function onChkHandler(e:Object) {		
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		
		root.chkResetData();
		selectReset()
		trace (_parent.item1.selectMc)
		var __chk = root.weaponDp[this._parent._parent._parent._id].dataProvider[this.index].Chk;
		var selNo:String;
		if (__chk=="0") {
			_boo = true;
			selectMc.gotoAndPlay("start");
			selNo = "1";
			
		} else {
			_boo = false;
			selectMc.gotoAndPlay(1);
			selNo = "0";
			
		}		
		root.weaponDp[this._parent._parent._parent._id].dataProvider[this.index].Chk = selNo;
		_global.WeaponNameTag_OnClick(this._parent._parent._parent._id,this.index)
		
		//
		trace("targetPath = "+selNo);
	}

	private function onDblChkHandler(e:Object) {
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		root.chkResetData();
		selectReset()
		
		var __chk =root.weaponDp[this._parent._parent._parent._id].dataProvider[this.index].Chk;
		var selNo:String;
		if (__chk=="0") {
			_boo = true;
			selectMc.gotoAndPlay("start");
			selNo = "1";			
		} else {
			_boo = false;
			selectMc.gotoAndPlay(1);
			selNo = "0";
			
		}		
		_global.WeaponNameTag_OnDblClick(this._parent._parent._parent._id,this.index);
		
		root.weaponDp[this._parent._parent._parent._id].dataProvider[this.index].Chk = selNo;
		
		
		
		
		//prvId=this._parent._id
		//prvIndex=this.index
		//
		trace("targetPath = "+selNo);
	}

	private function onChkOverHandler(e:Object) {
		//textFieldBg._visible = true;
		//textFieldBg._width = txtName.textWidth + 15;
		//txtName._visible = true;
		//_prevNo = this._name;
		//trace("index Over :=" + checkBox.selected);
		
		txtBox._visible = true;
		txtBg._visible = true;
		_global.WeaponNameTag_OnOver(this._parent._parent._parent._id,this.index,_boo);
		//trace("==================== getInvenItemOver =================="+ this.index);
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipView(arrowPoz.x,(arrowPoz.y-42),_CamoDay);
		}
	}
	private function onChkOutHandler(e:Object) {
		
		txtBox._visible = false;
		txtBg._visible = false;
		_global.WeaponNameTag_OnOut(this._parent._parent._parent._id,this.index,_boo);
		//trace("==================== getInvenItemOut =================="+ this.index);
		if(_CamoDay != "" && _CamoDay != undefined){
			var arrowPoz:Object = {x:0, y:0};
			this.localToGlobal (arrowPoz);
			var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			_level0.setCamoToolTipHide();
		}
	}
	private function onChkReleaseOutside(e:Object) {
		
		
		txtBox._visible = false;
		txtBg._visible = false;
		//_global.OnCamoOut(this._parent._id,this.index,_boo);
		//trace("==================== getInvenItemOut =================="+ this.index);
	}
	private function selectReset() {
		for(var i=0; i<4;i++){
			for(var a=0; a<3; a++){
				_parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].selectMc.gotoAndPlay(1);
			}			
		}
	}
}