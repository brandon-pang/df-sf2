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
 class com.scaleform.udk.controls.InvenCashUnitItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var txtDayBg:MovieClip;
	private var btn_change:Button;
	
	public var _hit:MovieClip;
	
	private var _img:String;
	//private var IconImgPath:String = "gamedir://\\FlashMovie\\image\\imgset\\gfx_imgset_cashItem.swf";
	private var _day:String;//남은날
	private var _alarmDay:String;//빨간색으로표시
	private var _btnchange:String;//
	private var dayNo:MovieClip;
	
	public function InvenCashUnitItem ()
	{
		super ();
	}

	public function setData (data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate ();
		this._visible = true;

		super.setData (data);
		
		_img = data.IconImg;	
		_day = data.Day;
		_alarmDay = data.AlarmDay;
		_btnchange=data.ChangeBtn
		
		UpdateTextFields ();
	}
	
	private function lvLoader (caseBy:String)
	{
		var IconImgPath:String;	
		
		var itemName=_img
		
		var len=itemName.length
		var chk=itemName.substr(-4,len)			
		
		if(chk=="_ani"){
			IconImgPath=UDKUtils.CashImgAniPath+itemName;
		}else{
			IconImgPath=UDKUtils.CashImgPath+itemName;	
		}				
		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if(itemName==""||itemName==undefined){
			//
		}else{
			mcLoader.loadClip(IconImgPath,modeIcon);
		}
		
	}
	
	private function onLoadComplete (mc:MovieClip)
	{
		//var imgName:String = _img;
		//modeIcon.gotoAndStop (imgName);
		modeIcon._xscale = 70;
		modeIcon._yscale = 70;
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
	
	private function UpdateTextFields ()
	{
		lvLoader ();
		
		txtDayBg._visible = false;
		dayNo._visible = false;				
		dayNo.text = _day;
		txtDayBg._width=(dayNo.textWidth+16)
		
				
		if(_day != ""){
			txtDayBg._visible = true;			
			dayNo._visible =true;		
			if(_alarmDay == "1"){
				txtDayBg.gotoAndStop(3);
			}else{
				txtDayBg.gotoAndStop(2);
			}
		}else{
			txtDayBg._visible = false;
			dayNo._visible = false;				
		}
		if(_btnchange==undefined ||_btnchange==""||_btnchange=="0"){
			btn_change._visible=false
		}else{
			btn_change._visible=true
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
		btn_change.addEventListener("click",this,"onUseBtnPress");
		btn_change.label="_inven_change_btn"
		btn_change._visible=false
		
		
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
		ExternalInterface.call("Inven_cashitem_change_btn_click",n);
	}

	public function draw()
	{
		super.draw();

	}	
}