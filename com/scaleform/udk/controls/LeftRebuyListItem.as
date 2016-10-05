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


class com.scaleform.udk.controls.LeftRebuyListItem extends ListItemRenderer {
	private var imgBox:MovieClip;		
	private var txtItemName:TextField;
	private var txtPrice:TextField;
	private var txtPrice2:TextField;
	private var selectMc:MovieClip;	
	private var leftRebuy_CheckBox:Button;
	private var _itemImg:String;
	private var moneyFrame:MovieClip;
	private var markMC:MovieClip;
	
	public function LeftRebuyListItem() {
		super();
	}
	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;		
		txtItemName.noTranslate = true;
		txtPrice.noTranslate = true;
		
		if (data.Chk == "0") {
			selectMc.gotoAndStop(1);
		} else {
			selectMc.gotoAndStop(2);
		}
		//iconTextField.htmlText = "<img src='SHOP_SP' width='18' height='21'>
		//<img src='SHOP_TP' width='23' height='21'><img src='SHOP_CASH' width='27' height='21'>"
		
		txtPrice.htmlText = data.Micon;
		txtPrice2.text = data.Price		
		txtItemName.text = data.ItemName;
		lvLoader(data.ItemIndex);
	}	
	public function updateAfterStateChange():Void {		
		if (data.Chk == "0") {
			selectMc.gotoAndStop(1);
		} else {
			selectMc.gotoAndStop(2);
		}
		//iconTextField.htmlText = "<img src='SHOP_SP' width='18' height='21'>
		//<img src='SHOP_TP' width='23' height='21'><img src='SHOP_CASH' width='27' height='21'>"
		
		txtPrice.htmlText = data.Micon;
		txtPrice2.text = data.Price		
		txtItemName.text = data.ItemName;
		lvLoader(data.ItemIndex);
		
		if (!initialized) {
			return;
		}
		validateNow();// Ensure that the width/height is up to date.

		//arrow._z = -450;
		//arrow._y = -50;
		//trace (_label)
		if (textField != null && _label != null) {
			textField.text = _label;
		}
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});

	}
	private function lvLoader(n:String) {
		var imgPathArmor:String;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit:String;
		var itemName:String = data.ItemImg;
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
				imgPathCashItem = UDKUtils.CashImgPath+itemName;
				imgPathWeapon = UDKUtils.WeaponImgPath+itemName;
			}
		}
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,imgBox);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,imgBox);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,imgBox);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,imgBox);
		}
		
		
	}
	private function onLoadComplete(mc:MovieClip) {
		//trace (mc._name +",,,,"+data.Index+",,,"+data.ItemImg)
		if (data.ItemIndex== "0") {
			mc._xscale=mc._yscale=70
			mc._x = 46;
			mc._y=2
		} else if (data.ItemIndex == "1") {
			mc._xscale=mc._yscale=90
			mc._x=16
			mc._y=-12
			//mc._x = -36;
		} else if (data.ItemIndex == "2") {
			//mc._x = 0;
			imgBox.gotoAndStop(data.ItemImg);
		} else if (data.ItemIndex == "3") {
			mc._xscale=mc._yscale=70
			mc._x = 88
			mc._y=2
		}
		txtPrice2._x=(265-8)-txtPrice2.textWidth
		txtPrice._x=txtPrice2._x-txtPrice.textWidth
		moneyFrame._width=txtPrice.textWidth+txtPrice2.textWidth+12
	}

	private function configUI():Void {
		constraints = new Constraints(this, true);

		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		//_hit.onRollOver = Delegate.create(this, handleMouseRollOver);             
		//_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		//_hit.onPress = Delegate.create(this, handleMousePress);
		//_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.onDragOver = Delegate.create(this, handleDragOver);
		//_hit.onDragOut = Delegate.create(this, handleDragOut);
		//_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);


		leftRebuy_CheckBox._disableFocus = true;
		//checkBox.doubleClickEnabled = true;
		//checkBox.addEventListener("press",this,"onChkHandler");
		leftRebuy_CheckBox.addEventListener("click",this,"onChkHandler");
		//checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		//checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		//checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		//checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		//txtPrice.verticalAlign = "center";
		txtPrice2.verticalAlign = "center";
	}

	public function draw() {
		super.draw();
	}

	private function onChkHandler(e:Object) {		
		//selectReset(this.index);
		var __chk = data.Chk;
		var selNo:String;
		if (__chk == "0") {
			//_boo = true;
			selectMc.gotoAndStop(2);
			selNo = "1";
		} else {
			//_boo = false;
			selectMc.gotoAndStop(1);
			selNo = "0";
		}
		data.Chk = selNo;		
		dispatchEventAndSound({type:"click"});		
	}
}