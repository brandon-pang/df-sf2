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
 class com.scaleform.udk.controls.ListItemGachaLeft extends ListItemRenderer {
	private var modeIcon:MovieClip;
	//private var _hit:MovieClip;	
	private var txt_title:MovieClip;
	
	private var _weaponImg:String;
	private var _title:String;
	private var _index:String
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";

	public function ListItemGachaLeft() {
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
		_index=data.Index
		_weaponImg = data.itemImg;
		_title = data.itemName
		
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
			mcLoader.loadClip(imgPathArmor,modeIcon["img"]);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,modeIcon["img"]);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,modeIcon["img"]);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,modeIcon["img"]);
		}
	}

	private function onLoadInit(mc:MovieClip) {
		var imgName:String = _weaponImg;		
		//장비 무기 부대 캐쉬
		if (_index == "0") {
			mc._xscale = 60;
			mc._yscale = 60;
			mc._x = -4;
			mc._y = 1
			
		} else if (_index == "1") {
			mc._xscale = 78;
		    mc._yscale = 78;
			mc._x = -26	
			mc._y=-8
			
		} else if (_index == "2") {
			modeIcon["img"].gotoAndStop(imgName);
			mc._xscale = 65;
			mc._yscale = 65;
			//mc._y = 10;
			//mc._x = 40;
			mc._x = 36;
			
		} else if (_index == "3") {
			mc._xscale = 65;
			mc._yscale = 65;
			mc._y = 5;
			mc._x = 36;
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
		if (data.Index == "0") {
			lvLoader("0");
		} else if (data.Index == "1") {
			lvLoader("1");
		} else if (data.Index == "2") {
			lvLoader("2");
		} else if (data.Index == "3") {
			lvLoader("3");
		}
		txt_title.text = _title
	}
}