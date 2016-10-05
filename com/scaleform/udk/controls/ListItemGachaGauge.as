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
import gfx.motion.Tween;
import mx.transitions.easing.*;


//import gfx.utils.Delegate;
//import com.greensock.*;
//import com.greensock.easing.*;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ListItemGachaGauge extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var txt_apply:MovieClip;
	private var icon_cash:MovieClip;
	private var icon_new:MovieClip;
	private var txt_name:MovieClip;
	private var gachaNumBall:MovieClip;
	private var _hit:MovieClip;	
	private var _weaponName:String;
	private var sGaugeSet:MovieClip;
	private var pveIcon:MovieClip;
	private var _leftNo:String;
	private var _icon:String;
	private var _mtype:String;
	private var _index:String;
	private var _tCount:String;
	private var _yCount:String;
	private var _mode:String;
	private var _modeType:String;
	private var saleIcon:MovieClip;
	private var _sale:String;
	
	//private var txtGaugeBox:MovieClip;
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";

	public function ListItemGachaGauge()
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
		invalidate();

		this._visible = true;

		super.setData(data);

		txt_apply._visible = false;
		_weaponName = data.itemName;
		_leftNo = data.leftCount;
		//(0:New,1:Hot)
		_icon = data.icons;
		//(SP,CASH);
		_mtype = data.moneyType;
		_index = data.Index;
		_yCount = data.nCount;
		_tCount = data.tCount;
		_mode=data.Mode
		_modeType=data.ModeType;
		//Sale
		_sale=data.SaleValue;

		UpdateTextFields();
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
		//lvLoader();

		if (_leftNo == "0" || _leftNo == "")
		{
			gachaNumBall.gotoAndStop(1)
			txt_apply._visible = false;
			txt_apply.text = "";
		}
		else
		{
			gachaNumBall.gotoAndStop(2)
			txt_apply._visible = true;
			txt_apply.text = _leftNo;
		}

		if (_icon == "")
		{
			icon_new._visible = false;
		}
		else if (_icon == "NEW")
		{
			icon_new._visible = true;
			icon_new.gotoAndStop(1);
		}
		else if (_icon == "HOT")
		{
			icon_new._visible = true;
			icon_new.gotoAndStop(2);
		}
		else if (_icon == "SALE")
		{
			icon_new._visible = true;
			icon_new.gotoAndStop(3);
		}
		
		icon_cash._visible=true
		icon_cash.htmlText = _mtype;
		txt_name.text=_weaponName;
		
		if (_yCount == "")
		{
			modeIcon._visible = true;
			sGaugeSet._visible = false;
			txt_name._width=190
			icon_new._x=222
			pveIcon.gotoAndStop(1);
			txt_name._x=icon_cash.textWidth+8
		}
		
		else
		{
			modeIcon._visible = true;
			sGaugeSet._visible = true;
			txt_name._width=175
			icon_new._x=190
			pveIcon.gotoAndStop(1);
			//
			setTxtCountDp(_yCount,_tCount);
			txt_name._x=icon_cash.textWidth+8
		}
		
		if (_mode == "pve")
		{
			icon_cash._visible=false			
		}

		if(_mode == "shooter"){
			icon_cash._visible=false			
		}
		
		if(_sale==undefined || _sale=="" || _sale=="0"){
			saleIcon._visible=false
			saleIcon["txt_no"].text=""
		}else{
			saleIcon._visible=true
			saleIcon["txt_no"].text=_sale
		}

		if (_modeType == "pve")
		{		
			pveIcon.gotoAndStop(2);
			txt_name._x=35
		}
		if(_modeType == "shooter"){
			pveIcon.gotoAndStop(4);
			txt_name._x=35
		}
	}

	private function setTxtCountDp(yc, tc)
	{		
		var per = (yc / tc) * 100;
		//구간설정
		if (per <= 25)
		{
			sGaugeSet.gotoAndStop(1);
		}
		else if (per >= 26 && per <= 50)
		{
			sGaugeSet.gotoAndStop(2);
		}
		else if (per >= 51 && per <= 75)
		{
			sGaugeSet.gotoAndStop(3);
		}
		else if (per >= 76 && per <= 100)
		{
			sGaugeSet.gotoAndStop(4);
		}
	}

}