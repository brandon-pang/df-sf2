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
import com.scaleform.udk.utils.UDKUtils 
//import gfx.utils.Delegate;
//import com.greensock.*;
//import com.greensock.easing.*;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ListItemGacha extends ListItemRenderer {
	private var modeIcon:MovieClip;
	private var txt_apply:MovieClip;
	private var icon_cash:MovieClip;
	private var icon_new:MovieClip;
	private var gachaNumBall:MovieClip;
	private var _hit:MovieClip;
	private var _weaponImg:String;
	private var txt_total:MovieClip;
	private var txtCountMc:MovieClip;
	private var bubbleMc:MovieClip;
	private var blueBg:MovieClip;
	private var pveIcon:MovieClip;
	private var _leftNo:String;
	private var _icon:String;
	private var _mtype:String;
	private var _index:String;
	private var _tCount:String;
	private var _yCount:String;
	private var _minCount:String;
	private var _maxCount:String;	
	private var _mode:String;
	private var _modeType:String;
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	
	public function ListItemGacha() {
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
		
		txt_apply._visible = false;
		_weaponImg = data.itemImg;
		_leftNo = data.leftCount;
		//(0:New,1:Hot)
		_icon = data.icons;
		//(SP,CASH);
		_mtype = data.moneyType;
		_index = data.Index;
		_yCount = data.nCount;
		_tCount = data.tCount;
		_mode=data.Mode
		_modeType=data.ModeType
		//_minCount = data.minCount;
		//_maxCount = data.maxCount;
		
		UpdateTextFields();
	}

	private function lvLoader(n:String) {
		var imgPathArmor:String = UDKUtils.ArmorImgPath+_weaponImg;
		var imgPathWeapon:String
		var imgPathCashItem:String;
		
		var itemName=_weaponImg
		
		var len=itemName.length
		var chk=itemName.substr(-4,len)				
		
		if(chk=="_ani"){
			imgPathCashItem=UDKUtils.CashImgAniPath+itemName
			imgPathWeapon=UDKUtils.WeaponImgAniPath+itemName
		}else{
			imgPathCashItem=UDKUtils.CashImgPath+itemName
			imgPathWeapon=UDKUtils.WeaponImgPath+itemName
		}				
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,modeIcon["img"]["img"]);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,modeIcon["img"]["img"]);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,modeIcon["img"]["img"]);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,modeIcon["img"]["img"]);
		}		
	}
	
	private function onLoadInit(mc:MovieClip) {
		var imgName:String = _weaponImg;
		mc._xscale = 80;
		mc._yscale = 80;
		//장비 무기 부대 캐쉬
		if (_index == "0") {
			mc._x = -8;
		} else if (_index == "1") {
			mc._x = -8;
		} else if (_index == "2") {
			modeIcon["img"]["img"].gotoAndStop(imgName);
			mc._y = 10;
			mc._x = 40;
		} else if (_index == "3") {
			mc._y = 0;
			mc._x = 45;
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
		//lvLoader();

		if (_leftNo == "0" || _leftNo == "") {
			gachaNumBall._visible = false;
			txt_apply._visible = false;
			txt_apply.text = "";
		} else {
			gachaNumBall._visible = true;
			txt_apply._visible = true;
			txt_apply.text = _leftNo;
		}

		if (_icon == "") {
			icon_new._visible = false;
		} else if (_icon == "NEW") {
			icon_new._visible = true;
			icon_new.gotoAndStop(1);
		} else if (_icon == "HOT") {
			icon_new._visible = true;
			icon_new.gotoAndStop(2);
		} else if (_icon == "SALE") {
			icon_new._visible = true;
			icon_new.gotoAndStop(3);
		}
		
		icon_cash.htmlText=_mtype

		if (data.Index == "0") {
			lvLoader("0");
		} else if (data.Index == "1") {
			lvLoader("1");
		} else if (data.Index == "2") {
			lvLoader("2");
		} else if (data.Index == "3") {
			lvLoader("3");
		}
		
		txt_total.htmlText = "<font size='8'>"+_yCount+"</font>/<font size='11'>"+_tCount+"</font>";
		
		
		if(_yCount==""){
			modeIcon._visible=true
			bubbleMc._visible=false
			txt_total._visible=false
			txtCountMc._visible=false
			blueBg.gotoAndStop(1)
			pveIcon.gotoAndStop(1)
		}else{
			modeIcon._visible=true
			bubbleMc._visible=true
			txt_total._visible=true
			txtCountMc._visible=true
			blueBg.gotoAndStop(1)
			pveIcon.gotoAndStop(1)
			//
			//setTxtCountDp(_minCount,_maxCount);
		}
		
		if(_mode=="pve"){
			modeIcon._visible=true
			bubbleMc._visible=false
			txt_total._visible=false
			txtCountMc._visible=false
			//아이콘 쇼
			blueBg.gotoAndStop(2)
			
		}else if(_mode=="shooter"){
			modeIcon._visible=true
			bubbleMc._visible=false
			txt_total._visible=false
			txtCountMc._visible=false
			//아이콘 쇼
			blueBg.gotoAndStop(2)
			
		}else if(_mode=="all"){
			modeIcon._visible=false
			bubbleMc._visible=false
			txt_total._visible=false
			txtCountMc._visible=false
			//아이콘 쇼
			blueBg.gotoAndStop(3)
		
		}

		if(_modeType=="pve"){			
			pveIcon.gotoAndStop(2)
		}else if(_modeType=="shooter"){			
			pveIcon.gotoAndStop(4)
		}else if(_modeType=="all"){			
			pveIcon.gotoAndStop(3)
		}
		
		
		
		
	}
	
	private function setTxtCountDp(min, max) {
		txtCountMc["txt_count"].text = min		
		var dis=max-min
		var countTime=4000/dis
		//trace (countTime)
		txtCountMc.beginInterval(countTime,min,max)		
	}
	
}