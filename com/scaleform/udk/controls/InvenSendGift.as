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

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.InvenSendGift extends ListItemRenderer
{

	private var txt_item:MovieClip;
	private var txt_unit:MovieClip;
	private var txt_id:MovieClip;
	private var txt_day:MovieClip;
	private var icon_used:MovieClip;
	
	public var btn_delete:Button;
	public var btnTooltip:Button;
	
	public var _hit:MovieClip;
	
	private var t_item:String;
	private var t_unit:String;
	private var t_id:String;
	private var t_day:String;
	private var t_date:String;
	private var t_item_no:String;
	private var t_limit:String;
	private var t_tooltip:String;
	private var _used:String;

	//

	public function InvenSendGift()
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
		t_item_no=data.ItemLength
		
		//계급제한
		t_limit=data.LimitedClass
		
		//보낸사람 메시지
		t_tooltip=data.GiftMsg;
		
		//사용여부
		_used=data.Used
		
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
		txt_item.text = t_item+" "+t_day;
		txt_unit.text = t_unit;
		txt_id.text = t_id;
		txt_day.text = t_date;
		
		if(_used=="1"){
			icon_used._visible=true
		}else{
			icon_used._visible=false
		}
		btnTooltip.tooltipMulti=t_tooltip
		//btn_use.tooltipMulti="sdganfkajsdjfaskjhfkasjdhfj"
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
		btn_delete.addEventListener("rollOver",this,"onUseBtnRollOver");
		btn_delete.addEventListener("rollOut",this,"onUseBtnRollOut");
		btn_delete.addEventListener("click",this,"onUseBtnPress");
		
		

		btnTooltip.tooltipMulti=t_tooltip
		//icon_used._visible=false
		
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
	
	
	private function onUseBtnPress(e:Object)
	{
		var n=this.index
		ExternalInterface.call("gift_sendlist_delbtn_click",n);
	}
	
	
	private function onListRollOver(e:Object)
	{
		btnTooltip.setState("over");
	}

	private function onListRollOut(e:Object)
	{
		btnTooltip.setState("up");
	}
	private function onListPress(e:Object)
	{
		var n=this.index
		ExternalInterface.call("gift_sendlist_listrender_click",n);
	}

	public function draw()
	{
		super.draw();

	}

}