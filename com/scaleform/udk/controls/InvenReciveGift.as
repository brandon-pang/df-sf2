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

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.InvenReciveGift extends ListItemRenderer
{

	private var txt_item:MovieClip;
	private var txt_unit:MovieClip;
	private var txt_id:MovieClip;
	//private var txt_day:MovieClip;
	private var imgBox:MovieClip;
	public var btn_use:Button;
	public var btnTooltip:Button;

	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";

	private var _hit:Button;
	private var t_item:String;
	private var t_unit:String;
	private var t_id:String;
	private var t_day:String;
	private var t_date:String;
	private var t_item_no:String;
	private var t_limit:String;
	private var t_tooltip:String;
	private var t_stat:String;
	private var t_img:String;
	private var t_expire:String;
	private var daySetMc:MovieClip;


	//

	public function InvenReciveGift()
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

		//아이템 속성 (0:장비,1:무기,2:부대,3:캐쉬템)
		t_stat = data.Stat;
		//아이템이름
		t_img = data.ImgName;
		//이름
		t_item = data.Title;

		//기간제 날짜
		t_day = data.Day;

		//장비면 부대 아니면 ALL
		t_unit = data.UnitName;

		//보낸사람
		t_id = data.GiftCodeName;

		//보낸 날짜
		t_date = data.SendDate;

		//아이템보유수
		t_item_no = data.ItemLength;
		//계급제한
		t_limit = data.LimitedClass;
		//보낸사람 메시지
		t_tooltip = data.GiftMsg;
		t_expire= data.Expire;


		UpdateTextFields();
	}


	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}

		UpdateTextFields();

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function UpdateTextFields()
	{
		txt_item.text = t_item + " " + t_day;
		txt_unit.text = t_unit;
		txt_id.text = t_id;
		if(t_expire==""||t_expire==null){
			daySetMc.gotoAndStop(1)
			daySetMc["txt_day"].text = t_date;
			daySetMc["bg_expire"]._visible=false
			daySetMc["txt_expire"].htmlText=""
		}else{
			daySetMc.gotoAndStop(2)
			daySetMc["txt_day"].text = t_date;
			daySetMc["bg_expire"]._visible=true
			daySetMc["txt_expire"].htmlText=t_expire
			daySetMc["bg_expire"]._width=daySetMc["txt_expire"].textWidth+6
		}
		
		
		btnTooltip.tooltipMulti = t_tooltip;
		
		lvLoader(t_stat);
		//btn_use.tooltipMulti="sdganfkajsdjfaskjhfkasjdhfj"
	}

	private function lvLoader(n:String)
	{		
		var imgPathArmor:String = UDKUtils.ArmorImgPath+ t_img;
		var imgPathWeapon:String;
		var imgPathCashItem:String;

		var itemName = t_img;
		var len = itemName.length;
		var chk = itemName.substr(-4, len);
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (t_img == "" || t_img == undefined)
		{
			//Do something
		}
		else
		{
			if (_global.gfxPlayer)
			{
				imgPathCashItem = "gfxImgSet/CashItem/" + itemName + ".png";
				imgPathWeapon = "gfxImgSet/Weapon/" + itemName + ".png";
				imgPathArmor = "gfxImgSet/Armor/" + itemName + ".png";
			}
			else
			{
				if (chk == "_ani") {
					imgPathCashItem = UDKUtils.CashImgAniPath+itemName
					imgPathWeapon = UDKUtils.WeaponImgAniPath+itemName
				} else {
					imgPathCashItem = UDKUtils.CashImgPath+itemName
					imgPathWeapon = UDKUtils.WeaponImgPath+itemName
				}
			}
		}
		
		
		trace ("++++++++++++++++ itemIndex = " + n +" itemName = " + itemName +" ++++++++++++++++++++++++++++");
		
		
		if (n == "0")
		{
			mcLoader.loadClip(imgPathArmor,imgBox);
		}
		else if (n == "1")
		{
			mcLoader.loadClip(imgPathWeapon,imgBox);
		}
		else if (n == "2")
		{
			mcLoader.loadClip(imgPathUnit,imgBox);
		}
		else if (n == "3")
		{			
			mcLoader.loadClip(imgPathCashItem,imgBox);
		}
	}
	private function onLoadInit(mc:MovieClip)
	{
		if (t_stat == "0")
		{
			mc._x=-10
			mc._y=3
			mc._xscale=mc._yscale=30
		}
		else if (t_stat == "1")
		{
			mc._x=-4
			mc._y=5
			mc._xscale=mc._yscale=25
		}
		else if (t_stat == "2")
		{
			mc._x=7
			mc._y=1
			mc._xscale=mc._yscale=30
			imgBox.gotoAndStop(t_img);
		}
		else if (t_stat == "3")
		{
			mc._x=7
			mc._y=1
			mc._xscale=mc._yscale=30
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


		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);


		//사용하기 버튼 클릭
		btn_use.addEventListener("rollOver",this,"onUseBtnRollOver");
		btn_use.addEventListener("rollOut",this,"onUseBtnRollOut");
		btn_use.addEventListener("click",this,"onUseBtnPress");		

		btnTooltip.tooltipMulti = t_tooltip;
		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		setState("release");
		handleClick(mouseIndex,button);
	}
	private function onUseBtnRollOver(e:Object)
	{
		btn_use.setState("over");
	}

	private function onUseBtnRollOut(e:Object)
	{
		btn_use.setState("up");
	}
	private function onUseBtnPress(e:Object)
	{
		var n = this.index;
		ExternalInterface.call("gift_recivelist_usebtn_click",n);
	}
	
	private function onListPress(e:Object)
	{
		var n = this.index;
		ExternalInterface.call("gift_recivelist_listrender_click",n);
	}

	public function draw()
	{
		super.draw();

	}

}