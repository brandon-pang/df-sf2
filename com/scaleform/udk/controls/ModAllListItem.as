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
import gfx.motion.Tween;
import mx.transitions.easing.*;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ModAllListItem extends ListItemRenderer
{
	private var checkBox:MovieClip;
	private var imgIcon:MovieClip;
	private var markMC:MovieClip;
	private var txtName:MovieClip;	
	private var textFieldBg:MovieClip;
	private var modifyBtn:MovieClip;
	
	private var _img:String;
	private var _txt:String;
	private var _imgPath:String;
	private var _boo:Boolean;
	//private var IconImgPath:String="gamedir://\\FlashMovie\\image\\imgset\\gfx_imgset_weapon.swf"
	
	private var _stat:String;
	private var _day:String;
	private var txtDayBg:MovieClip;

	public function ModAllListItem()
	{
		super();
	}
	
	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined || data.itemChk==undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;		
		invalidate();

		
		_img = data.itemImg;
		txtName.text = data.itemName
		textFieldBg._width = txtName.textWidth + 15;	
		
		checkBox.selected=false
		checkBox.disabled=false
		
		if(data.itemChk=="0"){
			checkBox.selected=false
			_boo=false
		}
		if (data.itemChk=="1"){
			checkBox.selected=true
			_boo=true
		}
		if (data.itemChk=="2"){
			checkBox.disabled=true
			checkBox.selected=false
			_boo=false
		}
		
		lvLoader();
		
		if(data.itemModValue != ""){
			setGaugeValue(Number(data.itemModValue))
			txtDayBg._visible = false;
		}else{
			modifyBtn._visible = false;
			txtDayBg._visible = true;
			txtDayBg.dayNo.text=data.Day;
			if (data.Warning == "1")
			{
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}
	}

	private function updateAfterStateChange():Void
	{
		if (data == undefined || data.itemChk==undefined)
		{
			this._visible = false;
			return;
		}
		
		_img = data.itemImg;
		txtName.text = data.itemName
		textFieldBg._width = txtName.textWidth + 15;	
		
		checkBox.selected=false
		checkBox.disabled=false
		
		if(data.itemChk=="0"){
			checkBox.selected=false
			_boo=false
		}
		if (data.itemChk=="1"){
			checkBox.selected=true
			_boo=true
		}
		if (data.itemChk=="2"){
			checkBox.disabled=true
			checkBox.selected=false
			_boo=false
		}
		
		
		//----------------------------------------  게이지 값이 없을 때 기간제 아이템 노출함
		if(data.itemModValue != ""){
			setGaugeValue(Number(data.itemModValue))
			txtDayBg._visible = false;
		}else{
			modifyBtn._visible = false;
			txtDayBg._visible = true;
			txtDayBg.dayNo.text=data.Day;
			if (data.Warning == "1")
			{
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}
	}
	
	
	function setGaugeValue(no:Number)
	{
		
		Tween.init();
		
		if(no>=31){
			modifyBtn["modifyMc"].gotoAndStop(1)
			modifyBtn["bar"].gotoAndStop(1)
		}else{
			modifyBtn["modifyMc"].gotoAndStop(2)
			modifyBtn["bar"].gotoAndStop(2)
		}
		var tWid = (36 / 100) * no;
		modifyBtn["bar"].tweenTo(0.3,{_width:tWid},Strong.easeOut);
	}
	
	private function lvLoader(caseBy:String)
	{		
		var IconImgPath:String;
		var itemName:String = _img;
		
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
			IconImgPath=UDKUtils.WeaponImgAniPath+itemName+".swf";
		}else{
			IconImgPath=UDKUtils.WeaponImgPath+itemName;
		}
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);		
		if(_img==""||_img==undefined){
			mcLoader.unloadClip(imgIcon);
		}else{
			mcLoader.loadClip(IconImgPath,imgIcon);
		}		
	}
	private function onLoadInit(mc:MovieClip)
	{
		var imgName:String = _img;
		//imgIcon.gotoAndStop(imgName);
		mc._x=-36
		mc._y=-16
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
		checkBox._disableFocus = true;
		//checkBox.doubleClickEnabled=true;
		checkBox.addEventListener("click",this,"onChkHandler");
		//checkBox.addEventListener("doubleClick",this,"onDblChkHandler");
		//checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		//checkBox.addEventListener("rollOut",this,"onChkOutHandler");

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
		if (_boo==false)
		{
			_boo=true
		}
		else
		{
			_boo=false
		}		
		checkBox.selected = _boo
		
        trace("index press 1 :=" + this._parent._id+","+this.index + "," + checkBox.selected);		
		
		_global.OnModifyAllPopupChkData(this.index,_boo);
	}	
}