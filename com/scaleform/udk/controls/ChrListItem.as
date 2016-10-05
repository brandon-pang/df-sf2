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
import com.scaleform.udk.utils.UDKUtils;
import gfx.controls.UILoader;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ChrListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var packImg:MovieClip;
	private var checkBox:MovieClip;
	private var selectMc:MovieClip;

	private var txtDayBg:MovieClip;
	private var txtName:TextField;
	private var dayNo:TextField;
	private var _img:String;
	private var _txt:String;
	private var _stat:String;
	private var _day:String;
	private var _imgPath:String;
	private var _chk:String;

	private var _hit:MovieClip;
	private var boo:Boolean;
	private var spIcon:MovieClip;
	private var apIcon:MovieClip;

	private var pcroomIconMC:MovieClip;
	private var vipIconMC:MovieClip;
	private var useBtn:Button;//사용버튼
	private var _NotUsed:String;

	private var numberTxt:TextField;//보유아이템 갯수
	private var _itemLength:String;//보유아이템 갯수

	private var setIcons:MovieClip;
	private var speedIcon:MovieClip;
	private var packBoolean:Boolean;
	private var mcLoader:MovieClipLoader;
	private var daySetMc:MovieClip;
	private var t_expire:String;
	private var _resell:String;
	//private var textBox:MovieClip;
	private var btnResell:Button;
	private var btnDisResell:Button;
	private var btnReDelete:Button;

	private var _lp:String;
	private var _ap:String;
	private var _sp:String;
	private var _cp:String;
	private var _jump:String;
	private var _hp:String;
	private var _swap:String;
	private var _reload:String;

	private var mouseListener:Object;

	public function ChrListItem()
	{
		super();
		spIcon._visible = false;
		apIcon._visible = false;
		speedIcon._visible = false;
		numberTxt.autoSize = true;

		mouseListener = new Object();
		Mouse.addListener(mouseListener);
	}

	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);

		_chk = data.Chk;
		_stat = data.Stat;
		_img = data.IconImg;
		_txt = data.Title;
		_day = data.Day;
		_NotUsed = data.NotUsed;
		_itemLength = data.ItemLength;
		t_expire = data.Expire;
		//0:none 1:resell 2:resell disable
		_resell = data.resell;

		_lp = data.spNum;
		_ap = data.apNum;
		_sp = data.speedNum;
		_cp = data.clanPoint;
		_jump = data.jumpNum;
		_hp = data.hpNum;
		_swap = data.swapNum;
		_reload = data.reloadNum;

		setIcons.gotoAndStop(1);

		UpdateTextFields();
	}


	private function lvLoader(item)
	{
		var _item = item;
		var IconImgPath 
		if (_global.gfxPlayer) {			
			IconImgPath = "gfxImgSet/Armor/"+data.IconImg+".png";			
		} else {
			IconImgPath =UDKUtils.ArmorImgPath + data.IconImg; 
		}
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if (data.IconImg == null ||data.IconImg=="")
		{
			return;
		}else{
			mcLoader.loadClip(IconImgPath,modeIcon);
		}
	}

	private function onLoadComplete(mc:MovieClip)
	{
		var imgName:String = data.IconImg;
		packImg._visible = false;
		packImg.gotoAndStop(imgName);
		setIcons.gotoAndStop(imgName);
		packBoolean = true;
		modeIcon._x = -64;
		modeIcon._y = -10;
	}

	private function updateAfterStateChange():Void
	{
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

	private function UpdateTextFields()
	{
		lvLoader(data.IconImg);
		dayNo._visible = false;
		txtName.htmlText = _txt;
		dayNo.text = _day;
		txtDayBg._width = (dayNo.textWidth + 16);
		if (_chk == "0")
		{
			if (_day == "")
			{
				dayNo._visible = false;
				txtDayBg.gotoAndStop(1);
			}
			else
			{
				if (_stat == "1")
				{
					dayNo._visible = true;
					txtDayBg.gotoAndStop(3);
					//txtName._visible = false;
					//textFieldBg._visible = false;
				}
				else
				{
					dayNo._visible = false;
					txtDayBg.gotoAndStop(1);
					//txtName._visible = false;
					//textFieldBg._visible = false;
				}
			}

			selectMc.gotoAndPlay(1);
		}
		else
		{
			if (_day == "")
			{
				dayNo._visible = false;
				txtDayBg.gotoAndStop(1);
			}
			else
			{
				if (_stat == "1")
				{
					dayNo._visible = true;
					txtDayBg.gotoAndStop(3);
					//txtName._visible = false;
					//textFieldBg._visible = false;
				}
				else
				{
					dayNo._visible = false;
					txtDayBg.gotoAndStop(1);
					//txtName._visible = false;
					//textFieldBg._visible = false;
				}
			}
			selectMc.gotoAndPlay("start");
		}

		//-------------------------------------피시방 아이콘 노출
		if (data.PCRoomIcon == "0" || data.PCRoomIcon == "" || data.PCRoomIcon == undefined)
		{
			pcroomIconMC._visible = false;
		}
		else
		{
			pcroomIconMC._visible = true;
			pcroomIconMC.gotoAndStop(data.PCRoomIcon);
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
		if (_NotUsed != "0" && _NotUsed != undefined)
		{
			useBtn._visible = true;
			dayNo.text = "";
			dayNo._visible = false;
		}
		else
		{
			useBtn._visible = false;
		}
		//-- 아이템 보유겟수 표시
		if (_itemLength == "" || _itemLength == "0")
		{
			numberTxt._visible = false;
		}
		else
		{
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
		}

		if (t_expire == "" || t_expire == null)
		{
			daySetMc._visible = false;
			daySetMc["bg_expire"]._visible = false;
			daySetMc["txt_expire"].htmlText = "";
		}
		else
		{
			daySetMc._visible = true;
			daySetMc["bg_expire"]._visible = true;
			daySetMc["txt_expire"].htmlText = t_expire;
			daySetMc["bg_expire"]._width = daySetMc["txt_expire"].textWidth + 8;
		}

		var textBox:MovieClip = btnDisResell["textBox"];
		if (_resell == "1")
		{
			btnResell.visible = true;
			btnDisResell.visible = false;
			textBox.textField.text = "";
			//버리기
			btnReDelete.visible = false;
		}
		else if (_resell == "2")
		{
			btnResell.visible = false;
			btnDisResell.visible = true;
			//2주무기
			textBox.textField.text = "_inven_resell_main_weapon_text";
			//버리기
			btnReDelete.visible = false;
		}
		else if (_resell == "3")
		{
			btnResell.visible = false;
			btnDisResell.visible = true;
			//3기타
			textBox.textField.text = "_inven_resell_etc_weapon_text";
			//버리기
			btnReDelete.visible = false;
		}
		else if (_resell == "4")
		{
			btnResell.visible = false;
			btnDisResell.visible = false;
			//버리기 옵션
			textBox.textField.text = "";
			//버리기
			btnReDelete.visible = true;
		}
		else
		{
			btnResell.visible = false;
			btnDisResell.visible = false;
			textBox.textField.text = "";

			//버리기
			btnReDelete.visible = false;
		}

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
		//checkBox.doubleClickEnabled = true;
		checkBox.addEventListener("press",this,"onChkHandler");
		//checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
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
		btnResell.addEventListener("click",this,"onResellHandler");
		btnResell.addEventListener("releaseOutside",this,"onResellOutSideHandler");
		btnReDelete.addEventListener("click",this,"onReDelHandler");
		btnReDelete.addEventListener("releaseOutside",this,"onReDelOutSideHandler");
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

	private function onResellHandler(e:Object)
	{
		setBtnRelease(0);
	}
	private function onResellOutSideHandler(e:Object)
	{
		btnResell.setState("up");
	}

	private function onReDelHandler(e:Object)
	{
		setBtnRelease(1);
	}

	private function setBtnRelease(value:Number)
	{
		var _v = value;
		var weaponPoz:Object = {x:0, y:0};
		this.localToGlobal(weaponPoz);

		_global.OnResellBtnData(this._parent._parent._parent._id,this.index,Math.ceil(weaponPoz.x),Math.ceil(weaponPoz.y),_v);
	}

	private function onReDelOutSideHandler(e:Object)
	{
		btnReDelete.setState("up");
	}


	private function onChkHandler(e:Object)
	{
		//var root=_parent._parent._parent._parent._parent._parent._parent._parent
		//ExternalInterface.call("GetOverlapChrItemIndex",this._parent._id,this.index);
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
		//root.chrDp[this._parent._id].dataProvider[this.index].Chk = selNo;
		if (_NotUsed != "0" && _NotUsed != undefined)
		{
			_global.OnCashItemUseBtnClick(this._parent._parent._parent._id,this.index);
		}
		else
		{
			_global.OnChrChkData(this._parent._parent._parent._id,this.index,boo);
		}
	}

	private function onChkOverHandler(e:Object)
	{			
		mouseListener.onMouseUp = Delegate.create(this, handleMouseUp);
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;	
		if (_day == "")
		{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		else
		{
			if (_stat == "1")
			{
				dayNo._visible = true;
				txtDayBg.gotoAndStop(3);
				//txtName._visible = false;
				//textFieldBg._visible = false;
			}
			else
			{
				dayNo._visible = true;
				txtDayBg.gotoAndStop(2);
				//txtName._visible = false;
				//textFieldBg._visible = false;
			}
		}
		packImg._visible = true;

		var armorPos:Object = {x:0, y:0};
		this.localToGlobal(armorPos);
		root.setInfoPointData(Math.ceil(armorPos.x),
							Math.ceil(armorPos.y),
							_lp,_ap,
							_sp,_cp,
							_jump,_hp,
							_swap,_reload)
	}

	private function onChkOutHandler(e:Object)
	{
		delete mouseListener.onMouseUp;
		if (_day == "")
		{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		else
		{
			if (_stat == "1")
			{
				dayNo._visible = true;
				txtDayBg.gotoAndStop(3);
			}
			else
			{
				dayNo._visible = false;
				txtDayBg.gotoAndStop(1);
				//txtName._visible = false;
				//textFieldBg._visible = false;
			}
		}
		
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		root.resetStat()
	}

	private function onChkReleaseOutside(e:Object)
	{
		delete mouseListener.onMouseUp

		if (_day == "")
		{
			dayNo._visible = false;
			txtDayBg.gotoAndStop(1);
		}
		else
		{
			if (_stat == "1")
			{
				dayNo._visible = true;
				txtDayBg.gotoAndStop(3);
				//txtName._visible = false;
				//textFieldBg._visible = false;
			}
			else
			{
				dayNo._visible = false;
				txtDayBg.gotoAndStop(1);
				//txtName._visible = false;
				//textFieldBg._visible = false;
			}
		}
		var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		root.resetStat()

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

	private function handleMouseUp(button, target, idx):Void
	{	
		trace (button)
		if(button==2){
			var root = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
			root.resetStat()
			checkBox.setState("up");
		}
	}
}