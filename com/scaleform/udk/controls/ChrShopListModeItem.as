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
import gfx.controls.UILoader;


[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ChrShopListModeItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;
	private var eventMc:MovieClip;
	private var txtName:TextField;
	private var txtBgMC:MovieClip;
	private var bg:MovieClip;
	
	private var _img:String;
	private var _txt:String;
	//private var _stat:String;
	private var _imgPath:String;
	private var _chk:String;
	private var _event:String;
	private var boo:Boolean;	
	
	//private var urlPath:String="gamedir://\\FlashMovie\\image\\imgset\\";
	//private var urlPath:String = "";
	//private var IconImgPath:String = urlPath+"gfx_imgset_cashItem.swf";

	
	private var hotIconMC:MovieClip;
	private var newIconMC:MovieClip;
	private var eventIconMC:MovieClip;
	private var pcroomIconMC:MovieClip;
	private var iconTextField:TextField;
	private var bestIconMC:MovieClip;
	private var tagIconPos:Array = [16, 43, 70,100];	
	private var vipIconMC:MovieClip;
	private var SaleIconMC:MovieClip;
	
	private var buyLimitIcon:MovieClip;
	private var _limitCase:String
	private var _limitNo:String
	private var _limitMeNo:String

	public function ChrShopListModeItem()
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
		
		
		//_stat = data.Stat;
		
		lvLoader();
		txtName.noTranslate=true;
		txtName.text = data.Title;
		txtBgMC._width = txtName.textWidth + 12;
		txtBgMC._x = (bg._width - txtBgMC._width >> 1) + 3;
		_limitCase=data.BuyLimitCase
	    _limitNo=data.BuyLimitNo
	    _limitMeNo=data.BuyLimitMeNo
		//trace("&&&&&&&&&&&&&&&&&&&&&&&" + data.Title + "&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

		var boo:Boolean;
		
		if (data.Chk == "0")
		{
			//boo = false;
			//checkBox._alpha = 100;
			selectMc.gotoAndPlay(1);
		}
		else
		{		
			selectMc.gotoAndPlay("start");
		}				
		
		//============
		//
		//============
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

		
		
		//iconTextField.htmlText = "<img src='SHOP_SP' width='18' height='21'><img src='SHOP_TP' width='23' height='21'><img src='SHOP_CASH' width='27' height='21'>"
		
		if(data.CurrencyIcon != undefined){
			iconTextField.htmlText = data.CurrencyIcon;
		}else{
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
			iconArr.push(SaleIconMC);
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
			//buyLimitIcon._x=177/2-((10+buyLimitIcon["tagBg"]._width)/2)
		}
	}
	
	private function lvLoader()
	{
		var IconImgPath
		var itemName=data.IconImg
		var len=itemName.length
		var chk=itemName.substr(-4,len)			
		
		if(chk=="_ani"){
			IconImgPath="CashItem_Ani/"+itemName+".swf"
		}else{
			IconImgPath="img://Imgset_CashItem."+itemName
		}
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if(itemName != undefined){
			mcLoader.loadClip(IconImgPath,modeIcon);		
		}
		
	}
	private function onLoadComplete(mc:MovieClip)
	{
		//var imgName:String = data.IconImg;		
		//modeIcon.gotoAndStop(imgName);
	}

	private function updateAfterStateChange():Void
	{
		lvLoader();
		txtName.noTranslate=true;
		txtName.text = data.Title;
		txtBgMC._width = txtName.textWidth + 12;
		txtBgMC._x = (bg._width - txtBgMC._width >> 1) + 3;
		
		var boo:Boolean;
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
		
		setTagIcon();
		
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
		//checkBox.addEventListener("click",this,"onChkHandler");
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
		var root=_parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		
		selectReset(_parent._parent._parent._name.substring(8),this.index);
		
		var __chk = data.Chk;
		//root.weaponDp[this._parent._id].dataProvider[this.index].Chk;
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
		data.Chk = selNo;	
		//root.weaponDp[this._parent._id].dataProvider[this.index]	
		_global.OnChrShopModeItemChkData(this._parent._parent._parent._id,this.index,boo);		
	}
	private function onDblChkHandler(e:Object){
		var selNo:String;		
		//var root=_parent._parent._parent._parent._parent._parent._parent._parent		
		
		selectMc.gotoAndPlay("start");
		selNo = "1";
		
		data.Chk = selNo;	
		//root.cashItemDp[this._parent._id].dataProvider[this.index].Chk = selNo;		
		_global.OnChrShopModeItemChkDblData(this._parent._parent._parent._id,this.index);
	}
	private function onChkOverHandler(e:Object){	
		//
	}
	private function onChkOutHandler(e:Object){
		//
	}
	private function selectReset(preNo,nowNo) {
		//trace (_parent._name)
		for (var i = 0; i<4; i++) {
			for (var a = 0; a<owner.dataProvider.length; a++) {
				 if(i==preNo && a==nowNo){
					
				}else{					
					_parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].data.Chk=0;
					_parent._parent._parent._parent["renderer"+i].columList.container["renderer"+a].selectMc.gotoAndPlay(1);
				}
				
			}
		}
	}
}