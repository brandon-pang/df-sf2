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
import flash.external.ExternalInterface;
import gfx.controls.UILoader;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ChrShopListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var packImg:MovieClip;
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;
	private var eventMc:MovieClip;
	private var txtName:TextField;

	private var _img:String;
	private var _txt:String;
	private var _stat:String;
	private var _imgPath:String;
	private var _chk:String;
	private var _event:String;
	private var boo:Boolean;

	//private var spIcon:MovieClip;
	private var apIcon:MovieClip;

	private var urlPath:String = "";
	//private var urlPath:String = "";
	//private var IconImgPath:String = urlPath+"gfx_imgset_armor.swf";
	private var overImgPath:String = urlPath + "gfx_imgset_armor_pack.swf";
	private var classImgPath:String = urlPath + "imgset_mid_class.swf";

	private var hotIconMC:MovieClip;
	private var newIconMC:MovieClip;
	private var eventIconMC:MovieClip;
	private var pcroomIconMC:MovieClip;
	private var bestIconMC:MovieClip;
	private var SaleIconMC:MovieClip;

	private var _Limitedclass:String;
	private var classIcon:MovieClip;
	//private var bonusSpMC:MovieClip;
	private var _BonusSP:String;

	private var readyPaidMC:MovieClip;
	private var classTxtMC:MovieClip;

	private var setIcons:MovieClip;
	private var iconTextField:TextField;

	private var tagIconPos:Array = [98, 71, 44,14];
	
	private var vipIconMC:MovieClip;
	
	private var buyLimitIcon:MovieClip;
	private var _limitCase:String
	private var _limitNo:String
	private var _limitMeNo:String

	public function ChrShopListItem()
	{
		super();
		apIcon._visible = false;
		//spIcon._visible = false;

	}

	public function setData(data:Object):Void
	{
		//trace (targetPath(this));
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		_Limitedclass = data.Limitedclass;
		
		_limitCase=data.BuyLimitCase
	    _limitNo=data.BuyLimitNo
	    _limitMeNo=data.BuyLimitMeNo
		//_Limitedclass = "0007";

		//apIcon._visible = false;
		//spIcon._visible = false;
		_stat = data.Stat;

		lvLoader();
		txtName.text = data.Title;
		txtName.noTranslate = true;
		if (data.Chk == "0")
		{
			selectMc.gotoAndPlay(1);
		}
		else
		{
			selectMc.gotoAndPlay("start");
		}
		//eventMc.gotoAndStop(Number(_event) + 1);

		if (data.EventIcon == "0" || data.EventIcon == undefined || data.EventIcon == "")
		{
			eventIconMC._visible = false;
		}
		else
		{
			eventIconMC._visible = true;
		}

		if (data.PCRoomIcon == "0" || data.PCRoomIcon == undefined || data.PCRoomIcon == "")
		{
			pcroomIconMC._visible = false;
		}
		else
		{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(data.PCRoomIcon);
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

		setTagIcon();

		//-------계급제한일때 반투명으로 보이고 계급로드하기(오버효과 안됨)
		if (_Limitedclass != "" && _Limitedclass != undefined)
		{
			modeIcon._alpha = 30;
			packImg._alpha = 80;
			setIcons._alpha = 80;
		}
		else
		{
			modeIcon._alpha = 100;
			packImg._alpha = 100;
			setIcons._alpha = 100;
			classIcon._visible = false;
		}
		setIcons.gotoAndStop(1);
		//------------------------------------------------------------------- 보너스 sp
		//_BonusSP = data.BonusSP;
		//_BonusSP = "30,000";
		/*if(_BonusSP != "0"){
		bonusSpMC.textField.text = _BonusSP;
		}
		bonusSpMC._visible = false;*/

		//------------------------ 보유중
		if (data.bAlreadyPaid)
		{
			readyPaidMC._visible = true;
		}
		else
		{
			readyPaidMC._visible = false;
		}
		if (data.bAlreadyPaid == undefined)
		{
			readyPaidMC._visible = false;
		}
		//------------------- 계급제한 텍스트내용 
		if (data.LimitedLevel)
		{
			classTxtMC._visible = true;
			classTxtMC.textField.text = data.LimitedLevel;
		}
		else
		{
			classTxtMC._visible = false;
		}
		if (data.LimitedLevel == undefined)
		{
			classTxtMC._visible = false;
		}
		//iconTextField.htmlText = "<img src='SHOP_SP' width='18' height='21'><img src='SHOP_TP' width='23' height='21'><img src='SHOP_CASH' width='27' height='21'>" 
		if (data.CurrencyIcon != undefined)
		{
			iconTextField.htmlText = data.CurrencyIcon;
		}
		else
		{
			iconTextField.htmlText = "";
		}


	}

	private function setTagIcon():Void
	{
		var iconArr:Array = [];
		
		if (data.BestIcon != null && data.BestIcon != "0" && data.BestIcon != "")
		{
			iconArr.push(bestIconMC);
			bestIconMC._visible = true;
		}
		else
		{
			bestIconMC._visible = false;
		}
		
		if (data.HotIcon != null && data.HotIcon != "0" && data.HotIcon != "")
		{
			iconArr.push(hotIconMC);
			hotIconMC._visible = true;
		}
		else
		{
			hotIconMC._visible = false;
		}
		
		if (data.NewIcon != null && data.NewIcon != "0" && data.NewIcon != "")
		{
			iconArr.push(newIconMC);
			newIconMC._visible = true;
		}
		else
		{
			newIconMC._visible = false;
		}
		if (data.SaleIcon != null && data.SaleIcon != "0" && data.SaleIcon != "")
		{
			//iconArr.push(SaleIconMC);
			SaleIconMC._visible = true;
			SaleIconMC["txt_no"].text=data.SaleIcon
		}
		else
		{
			SaleIconMC._visible = false;
			SaleIconMC["txt_no"].text=""
		}
		
		for (var i:Number=0; i<iconArr.length; i++)
		{
			iconArr[i]._x = tagIconPos[i];
		}
		//구매제한 관련 세팅
		if (_limitCase==null||_limitCase=="")
		{
			buyLimitIcon._visible = false;
		}else{
			buyLimitIcon._visible = true;
			//로컬
			if(_limitCase=="0"){
				buyLimitIcon["tagIcon"].gotoAndStop(1);
				buyLimitIcon["onlineMeSet"]._visible=false
				buyLimitIcon["txt"].text=_limitNo
				buyLimitIcon["tagBg"]._x=10
				buyLimitIcon["tagBg"]._width=11+buyLimitIcon["txt"].textWidth
			}
			//온라인
			if(_limitCase=="1"){
				buyLimitIcon["tagIcon"].gotoAndStop(2);				
				buyLimitIcon["txt"].text=_limitNo
				buyLimitIcon["tagBg"]._x=10
				buyLimitIcon["tagBg"]._width=11+buyLimitIcon["txt"].textWidth
				buyLimitIcon["onlineMeSet"]._visible=true
				buyLimitIcon["onlineMeSet"]["txt_me"].text=_limitMeNo
				buyLimitIcon["onlineMeSet"]["bg"]._width=buyLimitIcon["onlineMeSet"]["txt_me"].textWidth+10
			}
			buyLimitIcon._x=137/2-((10+buyLimitIcon["tagBg"]._width)/2)
		}
	}

	private function lvLoader()
	{
		var IconImgPath;
		var itemName = data.IconImg;
		var len = itemName.length;
		var chk = itemName.substr(-4, len);
		if (chk == "_ani")
		{
			IconImgPath = "Armor_Ani/" + itemName + ".swf";
		}
		else
		{
			IconImgPath = "img://Imgset_Armor." + itemName;
		}
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if(itemName==undefined||itemName==""){
			mcLoader.unloadClip(modeIcon);
			modeIcon._visible=false
		}else{
			modeIcon._visible=true
			mcLoader.loadClip(IconImgPath,modeIcon);
		}
		
		mcLoader.loadClip(overImgPath,packImg);

		if (_Limitedclass != "" && _Limitedclass != undefined)
		{
			mcLoader.loadClip(classImgPath,classIcon);
		}
		else
		{
			mcLoader.unloadClip(classIcon);
		}
	}
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classIcon")
		{
			var lvNo:String = _Limitedclass;			
			classIcon._visible = true;
			classIcon.set_level(lvNo)			
			classIcon.lv0._alpha = 75;
		}
	}
	private function onLoadComplete(mc:MovieClip)
	{
		var imgName:String = data.IconImg;
		//modeIcon.gotoAndStop(imgName);
		modeIcon._x = -64;
		modeIcon._y = 0;
		packImg._visible = false;
		packImg.gotoAndStop(imgName);
		setIcons.gotoAndStop(imgName);
	}

	private function updateAfterStateChange():Void
	{
		lvLoader();
		txtName.text = data.Title;
		txtName.noTranslate = true;



		if (data.Chk == "0")
		{
			selectMc.gotoAndPlay(1);
		}
		else
		{
			selectMc.gotoAndPlay("start");
		}

		if (data.EventIcon != "0")
		{
			eventMc.gotoAndStop(Number(_event) + 1);
		}

		if (data.Limitedclass != "")
		{
			classIcon._visible = true;
		}
		else
		{
			classIcon._visible = false;
		}

		setTagIcon();

		//------------------------ 보유중
		if (data.bAlreadyPaid)
		{
			readyPaidMC._visible = true;
		}
		else
		{
			readyPaidMC._visible = false;
		}
		if (data.bAlreadyPaid == undefined)
		{
			readyPaidMC._visible = false;
		}
		//------------------- 계급제한 텍스트내용 
		if (data.LimitedLevel)
		{
			classTxtMC._visible = true;
			classTxtMC.textField.text = data.LimitedLevel;
		}
		else
		{
			classTxtMC._visible = false;
		}
		if (data.LimitedLevel == undefined)
		{
			classTxtMC._visible = false;
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

		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		/*_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/ 
		checkBox._disableFocus = true;
		checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		checkBox.addEventListener("rollOut",this,"onChkOutHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");

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

	private function onChkHandler(e:Object)
	{
		//var root=_parent._parent._parent._parent._parent._parent._parent._parent
		ExternalInterface.call("GetOverlapItemIndex",this._parent._parent._parent._id,this.index);
		var __chk = data.Chk;
		var selNo:String;
		if (__chk == "0")
		{
			selectMc.gotoAndPlay("start");
			selNo = "1";
		}
		else
		{
			selectMc.gotoAndPlay(1);
			selNo = "0";
		}
		data.Chk = selNo;
		_global.OnChrShopChkData(this._parent._parent._parent._id,this.index,boo);

		//var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		//_level0.setChrItemInfoHide2();

		trace("++++++++++++++++++++++ char +++++++++++++++++" + targetPath(this));
	}
	private function onDblChkHandler(e:Object)
	{
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		ExternalInterface.call("GetOverlapItemIndex",this._parent._parent._parent._id,this.index);
		var selNo:String;
		selectMc.gotoAndPlay("start");
		selNo = "1";
		data.Chk = selNo;
		//root.chrDp[this._parent._id].dataProvider[this.index].Chk = selNo;
		_global.OnChrShopChkDblData(this._parent._parent._parent._id,this.index);
	}
	private function onChkOverHandler(e:Object)
	{

		packImg._visible = true;
		trace("data.IconView =" + data.IconView);
		//ap 노출 , sp 노출, 두개다 노출


		var arrowPoz:Object = {x:0, y:0};
		this.localToGlobal(arrowPoz);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;


		//툴팁노출
		if (_Limitedclass != "" && _Limitedclass != undefined)
		{
			_level0.setLimitedTipView(_Limitedclass,arrowPoz.x,arrowPoz.y);
		}
		
		ExternalInterface.call("GetArmorRollOverItemIndex",this._parent._parent._parent._id,this.index);
		
		/*"Price_Type1", "SP" 
		"Price_Type2", "Cash" 
		"Price_Type3", "Cash + TP" 
		"Price_Type4", "SP&TP" 
		"Price_Value1", "SP" 
		"Price_Value2", "Cash" 
		"Price_Value3", "Cash + TP" 
		"Price_Value4", "SP&TP" 
		"Variations_Defence", "방어 증감량" 
		"Variations_Speed", "이속 증감량"
		"Variations_Lucky", "럭키 증감량" 
		"BonusSP", "보너스 SP" 
		"OverlapLimit", "중복불가염" 
		"Descrition", "설명" */ 
	}
	private function onChkOutHandler(e:Object)
	{
		packImg._visible = false;
		apIcon._visible = false;
		//spIcon._visible = false;
		//bonusSpMC._visible = false;
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		if (_Limitedclass != "" && _Limitedclass != undefined)
		{
			_level0.setLimitedTipHide();
		}
		ExternalInterface.call("GetArmorRollOutItemIndex",this._parent._parent._parent._id,this.index);
		//_level0.setChrItemInfoHide();

	}


	private function onChkReleaseOutside(e:Object)
	{
		packImg._visible = false;
		apIcon._visible = false;
		//spIcon._visible = false;
		//bonusSpMC._visible = false;
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		if (_Limitedclass != "" && _Limitedclass != undefined)
		{
			_level0.setLimitedTipHide();
		}
		//_level0.setChrItemInfoHide();

	}
}