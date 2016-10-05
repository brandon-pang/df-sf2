/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.CoreList;
import gfx.utils.Constraints;
import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import gfx.motion.Tween;
import gfx.controls.Button;
import mx.transitions.easing.*;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.InvenTypeItem extends ListItemRenderer {
	private var img0:MovieClip;
	private var img1:MovieClip;
	private var img2:MovieClip;
	private var img3:MovieClip;
	private var img4:MovieClip;
	private var img5:MovieClip;

	private var textNo:TextField;
	private var modifyBtn0:MovieClip;
	private var modifyBtn1:MovieClip;
	private var modifyBtn2:MovieClip;
	private var blackBtn:MovieClip;

	private var pcroomIconMC0:MovieClip;
	private var pcroomIconMC1:MovieClip;
	private var pcroomIconMC2:MovieClip;

	private var gray_main:TextField;
	private var gray_sub:MovieClip;
	private var gray_three:MovieClip;
	private var gray_thr1:MovieClip;
	private var gray_thr2:MovieClip;
	private var gray_thr3:MovieClip;

	private var btn0:Button;
	private var btn1:Button;
	private var btn2:Button;
	private var btn3:Button;
	private var btn4:Button;
	private var btn5:Button;
	private var _mImg:String;
	private var _subImg:String;
	private var _threeImg:String;
	private var _thr0:String;
	private var _thr1:String;
	private var _thr2:String;

	private var _mod0:String;
	private var _mod1:String;
	private var _mod2:String;
	private var _itemSelect:Number;

	private var hit:MovieClip;
	private var _hit2:Button;
	// instance of a generic MovieClip on the bottom-most layer of the component.
	private var MainChk:String;

	private var modAllBtn:Button;
	
	private var markMC:MovieClip;

	private var txtDayBg0:MovieClip;
	private var txtDayBg1:MovieClip;
	private var txtDayBg2:MovieClip;
	
	private var dayNo0:MovieClip;
	private var dayNo1:MovieClip;
	private var dayNo2:MovieClip;
	
	private var _warning0:String;
	private var _day0:String;
	private var _warning1:String;
	private var _day1:String;
	private var _warning2:String;
	private var _day2:String;

	private var _pcroomIcon0:String;
	private var _pcroomIcon1:String;
	private var _pcroomIcon2:String;
	
	private var camoTg0:MovieClip;
	private var camoTg1:MovieClip;
	private var camoTg2:MovieClip;
	
	private var _camo0:String;
	private var _camo1:String;
	private var _camo2:String;
	
	private var _imgPathCamoBg:String="gfx_imgset_camo_bg.swf";	
	public function InvenTypeItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		//trace("xxxx types"+this.data);
		this.data = data;
		invalidate();

		this._visible = true;
		super.setData(data);

		_mImg = data.MainImg;
		_subImg = data.SubImg;
		_threeImg = data.ThreeImg;
		_thr0 = data.Thr0;
		_thr1 = data.Thr1;
		_thr2 = data.Thr2;
		_mod0 = data.MainModify;
		_mod1 = data.SubModify;
		_mod2 = data.ThreeModify;

		_warning0 = data.Warning0;
		_day0 = data.Day0;
		_warning1 = data.Warning1;
		_day1 = data.Day1;
		_warning2 = data.Warning2;
		_day2 = data.Day2;
			

		
		txtDayBg0._visible = false
		txtDayBg1._visible = false
		txtDayBg2._visible = false
		dayNo0._visible = false
		dayNo1._visible = false
		dayNo2._visible = false
		
		dayNo0.text = data.Day0;
		dayNo1.text = data.Day1;
		dayNo2.text = data.Day2;
		
		txtDayBg0._width=(dayNo0.textWidth+16)
		txtDayBg1._width=(dayNo1.textWidth+16)
		txtDayBg2._width=(dayNo2.textWidth+16)
		
		if (data.Day0 != "") {
			txtDayBg0._visible = true;
			dayNo0._visible = true;
			
			if (data.Warning0 == "1") {
				txtDayBg0.gotoAndStop(3);
			} else {
				txtDayBg0.gotoAndStop(2);
			}
		} else {
			txtDayBg0.gotoAndStop(1);
			dayNo0._visible = false;
			txtDayBg0._visible = false;
		}

		if (data.Day1 != "") {
			txtDayBg1._visible = true;
			dayNo1._visible = true;
			if (data.Warning1 == "1") {
				txtDayBg1.gotoAndStop(3);
			} else {
				txtDayBg1.gotoAndStop(2);
			}
		} else {
			
			txtDayBg1.gotoAndStop(1);
			dayNo1._visible = false;
			txtDayBg1._visible = false;
		}

		if (data.Day2 != "") {
			txtDayBg2._visible = true;
			dayNo2._visible = true;
			if (data.Warning2 == "1") {
				txtDayBg2.gotoAndStop(3);
			} else {
				txtDayBg2.gotoAndStop(2);
			}
		} else {
			txtDayBg2["dayNo"].text = "";
			txtDayBg2.gotoAndStop(1);
			dayNo2._visible = false;
			txtDayBg2._visible = false;
		}


		modifyBtn0.setGaugeValue(data.MainModify);
		modifyBtn1.setGaugeValue(data.SubModify);
		modifyBtn2.setGaugeValue(data.ThreeModify);

		if (data.MainImg != "") {
			img0._visible = true;
			gray_main._visible = false;
			lvLoader("main");
		} else {
			img0._visible = false;
			gray_main._visible = true;
			markMC.gotoAndStop(1);
		}

		if (data.SubImg != "") {
			img1._visible = true;
			gray_sub._visible = false;
			lvLoader("sub");
		} else {
			img1._visible = false;
			gray_sub._visible = true;
		}

		if (data.ThreeImg != "") {
			img2._visible = true;
			gray_three._visible = false;
			lvLoader("three");
		} else {
			img2._visible = false;
			gray_three._visible = true;
		}

		//----------------------------------------- 피시방 아이콘 노출시 수리계이지 안보이게
		_pcroomIcon0 = data.PCRoomIcon0;
		_pcroomIcon1 = data.PCRoomIcon1;
		_pcroomIcon2 = data.PCRoomIcon2;
		
		pcroomIconMC0._visible = false;
		pcroomIconMC1._visible = false;
		pcroomIconMC2._visible = false;
		
		/*trace("#############################################################")
		trace("######################"+ _pcroomIcon0  + "#######################")
		trace("######################"+ _pcroomIcon1  + "#######################")
		trace("######################"+ _pcroomIcon2  + "#######################")*/

		//피씨방 국가별로 구분하기 위해 수정 2012-03-05
		if(_pcroomIcon0 != ""){
			pcroomIconMC0._visible = true;
			pcroomIconMC0.gotoAndStop(_pcroomIcon0);
		}else{
			pcroomIconMC0._visible = false;
		}
		if(_pcroomIcon1 != ""){
			pcroomIconMC1._visible = true;
			pcroomIconMC1.gotoAndStop(_pcroomIcon1);
		}else{
			pcroomIconMC1._visible = false;
		}
		if(_pcroomIcon2 != ""){
			pcroomIconMC2._visible = true;
			pcroomIconMC2.gotoAndStop(_pcroomIcon2);
		}else{
			pcroomIconMC2._visible = false;
		}

		if (_mImg == "" && _subImg == "" && _threeImg == "") {
			//보여주지 않는다.
			modAllBtn._y = -1000;
		} else {
			//보여준다.
			modAllBtn._y = -39;
		}
		
		
		if (data.CamoBgName0 != "") {
			_camo0 = data.CamoBgName0;
			camoTg0._visible = true;
			lvLoader("_camo0");
		}else{
			camoTg0._visible = false;
		}
		
		if (data.CamoBgName1 != "") {
			_camo1 = data.CamoBgName1;
			camoTg1._visible = true;
			lvLoader("_camo1");
		}else{
			camoTg1._visible = false;
		}
		
		if (data.CamoBgName2 != "") {
			_camo2 = data.CamoBgName2;
			camoTg2._visible = true;
			lvLoader("_camo2");
		}else{
			camoTg2._visible = false;
		}
		

		UpdateTextFields();
	}
	
	[Inspectable(defaultValue="false")]
	public function get selected():Boolean { return _selected; }
	public function set selected(value:Boolean):Void 
	{
		super.selected = value;
		
		if( value )
		{
			setScaleItem( this.owner.selectedIndex );
		}
	}


	private function lvLoader(caseBy) {
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		trace ("IMGS NAME = " + _mImg);
		trace ("IMGS NAME = " + _subImg);
		trace ("IMGS NAME = " + _threeImg);
		if (caseBy == "main") {
			var IconImgPath:String;			
			var itemName:String = _mImg;
			var chk:String = itemName.substr(-4);	
			
			
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
			
			
			if(chk=="_ani"){
				IconImgPath=UDKUtils.WeaponImgAniPath+itemName
			}else{
				IconImgPath=UDKUtils.WeaponImgPath+itemName;
			}
				mcLoader.loadClip(IconImgPath,img0);
			}
			
		if (caseBy == "sub") {
			var IconImgPath:String;			
			var itemName=_subImg;
			var len=itemName.length;
			var chk=itemName.substr(-4,len);
			
			if(chk=="_ani"){
				IconImgPath=UDKUtils.WeaponImgAniPath+itemName
			}else{
				IconImgPath=UDKUtils.WeaponImgPath+itemName;
			}
			mcLoader.loadClip(IconImgPath,img1);
		}
		if (caseBy == "three") {
			var IconImgPath:String;			
			var itemName=_threeImg;
			var len=itemName.length;
			var chk=itemName.substr(-4,len);
			if(chk=="_ani"){
				IconImgPath=UDKUtils.WeaponImgAniPath+itemName
			}else{
				IconImgPath=UDKUtils.WeaponImgPath+itemName;
			}
			mcLoader.loadClip(IconImgPath,img2);
		}
		
		if (caseBy == "_camo0") {
			var camoName=_camo0
			var camoChk:String=camoName.substr(-4);	
			var camoImgPath:String;			
			if(camoChk=="_ani"){
				camoImgPath=UDKUtils.CamoImgAniPath+camoName
			}else{
				camoImgPath=UDKUtils.CamoImgPath+camoName
			}	
			mcLoader.loadClip(camoImgPath,camoTg0);
		}
		if (caseBy == "_camo1") {
			var camoName=_camo1
			var camoChk:String=camoName.substr(-4);	
			var camoImgPath:String;			
			if(camoChk=="_ani"){
				camoImgPath=UDKUtils.CamoImgAniPath+camoName
			}else{
				camoImgPath=UDKUtils.CamoImgPath+camoName
			}	
			mcLoader.loadClip(camoImgPath,camoTg1);
		}
		if (caseBy == "_camo2") {
			var camoName=_camo2
			var camoChk:String=camoName.substr(-4);	
			var camoImgPath:String;			
			if(camoChk=="_ani"){
				camoImgPath=UDKUtils.CamoImgAniPath+camoName
			}else{
				camoImgPath=UDKUtils.CamoImgPath+camoName
			}	
			mcLoader.loadClip(camoImgPath,camoTg2);
		}
		
		

	}
	private function onLoadComplete(mc:MovieClip) {
		var n = mc._name;
		
		if (n == "img0") {
			
		}
		if (n == "img1") {
			mc._xscale = 70;
			mc._yscale = 70;
		}
		if (n == "img2") {
			mc._xscale = 70;
			mc._yscale = 70;
		}
		
		if (n == "camoTg0") {
			mc._xscale = mc._yscale = 59			
		}
		if (n == "camoTg1") {
			mc._xscale = mc._yscale = 50
		}
		if (n == "camoTg2") {
			mc._xscale = mc._yscale = 50
		}		
	}
	
	
	/*private function onLoadInit(mc:MovieClip) {
		modifyBtn0.setGaugeValue(data.MainModify);
		modifyBtn1.setGaugeValue(data.SubModify);
		modifyBtn2.setGaugeValue(data.ThreeModify);
	}*/
	
	private function UpdateTextFields() {
		var n = this.index;
		switch (n) {
			case 0 :
				textNo.text = "A";
				break;
			case 1 :
				textNo.text = "B";
				break;
			case 2 :
				textNo.text = "C";
				break;
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

	private function configUI():Void {
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize) {
			sizeIsInvalid = true;
		}

		hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		hit.onPress = Delegate.create(this, handleMousePress);
		hit.onReleaseOutside = Delegate.create(this, handleMouseReleaseOutside);

		_hit2.onRollOver = function() {
			_parent.modAllBtn.visible = false;
		};
		modAllBtn.addEventListener("click",this,"onModAllBtnHandler");

		if (focusIndicator != null && !_focused && focusIndicator._totalFrames == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		this._disableFocus = true;
	}

	private function btnMountClick() {
		var n = this._name.substring(3);
		_global.btnMountClick(n);
	}
	private function btnMountOver() {

	}
	private function btnMountOut() {

	}
	private function onModAllBtnHandler(e:Object) {
		var initPoz:Object = {x:0, y:0};
		e.target.localToGlobal(initPoz);
		trace(this.index+" , "+initPoz.x+" , "+initPoz.y);
		_global.AllTypeModify(this.index,initPoz.x,initPoz.y);
	}

	private function handleModAllBtnVisible() {

	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		trace("TypeItemIndex = "+this._parent.list.selectedIndex);
		trace("sssssdf press  "+this.index);
		trace("sssssdf config  "+this.owner["_selectedIndex"]);

		if (this.owner["_selectedIndex"] != this.index) {
			_global.onTypeBtnClick(this.index);
		}

		this.owner["_selectedIndex"] = this.index;

		var no = this.index;
		setScaleItem(no);
		setEquipmentBtn(no);
		if (_disabled) {
			return;
		}
		if (!_disableFocus) {
			Selection.setFocus(this);
		}

		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});


	}

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {
		//setState("over");// Focus changes in the setState will override those in the changeFocus (above).
		trace("sssssdf over  "+this._parent.weaponFlowList.selectedIndex);

		dispatchEvent({type:"rollOver", mouseIndex:mouseIndex, button:button});
		if (this.owner["_selectedIndex"] != this.index) {
			blackBtn._visible = false;
		}

		trace(_parent._parent._parent._name);
		//모두수리 보이기
		modAllBtn.visible = true;
		//Mouse.removeListener(_parent._parent._parent._parent.mouseListener);

	}

	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		//setState("out");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"rollOut", mouseIndex:mouseIndex, button:button});
		if (this.owner["_selectedIndex"] != this.index) {
			blackBtn._visible = true;
		}
		//Mouse.addListener(_parent._parent._parent._parent.mouseListener)                       

	}

	private function handleMouseReleaseOutside(mouseIndex:Number, button:Number):Void {

		modAllBtn.visible = false;
	}

	private function setEquipmentBtn(boo) {
		for (var i:Number = 1; i<4; i++) {
			if (i == (boo+1)) {
				for (var a:Number = 0; a<6; a++) {
					this._parent["item"+i]["btn"+a].onPress = btnMountClick;
				}
			} else {
				for (var a:Number = 0; a<6; a++) {
					delete this._parent["item"+i]["btn"+a].onPress;
				}
			}
		}

	}
	private function draw():Void {
		if (sizeIsInvalid) {// The size has changed.   
			_width = __width;
			_height = __height;
		}
	}


	private function setScaleItem(no) {		
		
		Tween.init();

		switch (no) {
			case 0 :				
				this._parent.item1.swapDepths(1000);
				this._parent.item2.swapDepths(990);
				this._parent.item3.swapDepths(980);							
				for (var i = 1; i<4; i++) {
					for (var a = 0; a<3; a++) {
						if (i == 1) {
							this._parent["item"+i]["modifyBtn"+a]._visible = true;
							if (_day0 != "") {
								this._parent["item"+i]["txtDayBg"+0]._visible = true;
							}
							
							if (_day1 != "") {
								this._parent["item"+i]["txtDayBg"+1]._visible = true;
							}
							
							if (_day2 != "") {
								this._parent["item"+i]["txtDayBg"+2]._visible = true;
							}							
							if(_pcroomIcon0 != ""){
								this._parent["item"+i]["pcroomIconMC"+0]._visible = true;
							}
							if(_pcroomIcon1 != ""){
								this._parent["item"+i]["pcroomIconMC"+1]._visible = true;
							}
							if(_pcroomIcon2 != ""){
								this._parent["item"+i]["pcroomIconMC"+2]._visible = true;
							}
							
						} else {
							this._parent["item"+i]["pcroomIconMC"+a]._visible = false;
							this._parent["item"+i]["modifyBtn"+a]._visible = false;
							this._parent["item"+i]["txtDayBg"+a]._visible = false;
							
						}
					}
					
				}
				this._parent.item1.tweenTo(0.3,{_x:203, _xscale:100, _yscale:100},Strong.easeOut);
				this._parent.item2.tweenTo(0.3,{_x:306, _xscale:80, _yscale:80},Strong.easeOut);
				this._parent.item3.tweenTo(0.3,{_x:395, _xscale:60, _yscale:60},Strong.easeOut);
				this._parent.item1.blackBtn._visible = false;
				this._parent.item2.blackBtn._visible = true;
				this._parent.item3.blackBtn._visible = true;
				break;
			case 1 :
				this._parent.item2.swapDepths(1000);
				this._parent.item1.swapDepths(990);
				this._parent.item3.swapDepths(980);
				for (var i = 1; i<4; i++) {
					for (var a = 0; a<3; a++) {
						if (i == 2) {
							this._parent["item"+i]["modifyBtn"+a]._visible = true;
							
							if (_day0 != "") {
								this._parent["item"+i]["txtDayBg"+0]._visible = true;
							}
							
							if (_day1 != "") {
								this._parent["item"+i]["txtDayBg"+1]._visible = true;
							}
							
							if (_day2 != "") {
								this._parent["item"+i]["txtDayBg"+2]._visible = true;
							}
							if(_pcroomIcon0 != ""){
								this._parent["item"+i]["pcroomIconMC"+0]._visible = true;
							}
							if(_pcroomIcon1 != ""){
								this._parent["item"+i]["pcroomIconMC"+1]._visible = true;
							}
							if(_pcroomIcon2 != ""){
								this._parent["item"+i]["pcroomIconMC"+2]._visible = true;
							}
						} else {
							this._parent["item"+i]["pcroomIconMC"+a]._visible = false;
							this._parent["item"+i]["modifyBtn"+a]._visible = false;
							this._parent["item"+i]["txtDayBg"+a]._visible = false;
						}
					}
					
				}
				this._parent.item2.tweenTo(0.3,{_x:280, _xscale:100, _yscale:100},Strong.easeOut);
				this._parent.item1.tweenTo(0.3,{_x:164, _xscale:80, _yscale:80},Strong.easeOut);
				this._parent.item3.tweenTo(0.3,{_x:372, _xscale:80, _yscale:80},Strong.easeOut);
				this._parent.item1.blackBtn._visible = true;
				this._parent.item2.blackBtn._visible = false;
				this._parent.item3.blackBtn._visible = true;
				break;
			case 2 :
				this._parent.item3.swapDepths(1000);
				this._parent.item2.swapDepths(990);
				this._parent.item1.swapDepths(980);
				for (var i = 1; i<4; i++) {
					for (var a = 0; a<3; a++) {
						if (i == 3) {
							this._parent["item"+i]["modifyBtn"+a]._visible = true;
							if (_day0 != "") {
								this._parent["item"+i]["txtDayBg"+0]._visible = true;
							}
							
							if (_day1 != "") {
								this._parent["item"+i]["txtDayBg"+1]._visible = true;
							}
							
							if (_day2 != "") {
								this._parent["item"+i]["txtDayBg"+2]._visible = true;
							}
							if(_pcroomIcon0 != ""){
								this._parent["item"+i]["pcroomIconMC"+0]._visible = true;
							}
							if(_pcroomIcon1 != ""){
								this._parent["item"+i]["pcroomIconMC"+1]._visible = true;
							}
							if(_pcroomIcon2 != ""){
								this._parent["item"+i]["pcroomIconMC"+2]._visible = true;
							}
						} else {
							this._parent["item"+i]["pcroomIconMC"+a]._visible = false;
							this._parent["item"+i]["modifyBtn"+a]._visible = false;
							this._parent["item"+i]["txtDayBg"+a]._visible = false;
						}
					}
					
				}
				this._parent.item3.tweenTo(0.3,{_x:350, _xscale:100, _yscale:100},Strong.easeOut);
				this._parent.item2.tweenTo(0.3,{_x:218, _xscale:80, _yscale:80},Strong.easeOut);
				this._parent.item1.tweenTo(0.3,{_x:121, _xscale:60, _yscale:60},Strong.easeOut);
				this._parent.item1.blackBtn._visible = true;
				this._parent.item2.blackBtn._visible = true;
				this._parent.item3.blackBtn._visible = false;
				break;
		}
	}
}