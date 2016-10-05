/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.Button;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.IdCardWaponNameList extends ListItemRenderer
{
    private var _hit:MovieClip;
	private var txt:TextField;
	private var _index:Number
	private var redIcon:MovieClip;	
	public function IdCardWaponNameList ()
	{
		super ();
		// 오른쪽 하단 사람모양에 라인 및 점 표시 모션 실행
		_parent._parent._parent._parent.tar1MC.gotoAndPlay(2);
		_parent._parent._parent._parent.tar2MC.gotoAndPlay(2);
		_parent._parent._parent._parent.tarlineMC.gotoAndPlay(2);
	}

	public function setData (data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;				
		_index = Number(data.Index);		
		txt.text = data.IdCardMyWaponName; //내 보유 주 무기 이름
		//버튼에 빨간점 표시 유무
		if(data.RedDot == "0"){
			redIcon._visible = false;
		}else{
			redIcon._visible = true;
		}
	}	
	
	private function configUI ():Void
	{
		constraints = new Constraints (this, true);

		if (!_disableConstraints)
		{
			constraints.addElement (textField,Constraints.ALL);
		}
		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		_hit._disableFocus = true;
        _hit.onRollOver = Delegate.create(this, handleMouseRollOver);          
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
	}
	
	private function updateAfterStateChange ():Void
	{
		if (!initialized)
		{
			return;
		}
		validateNow ();		
		if (constraints != null)
		{
			constraints.update (width,height);
		}
		dispatchEvent ({type:"stateChange", state:state});
	}

	private function draw ()
	{
		super.draw ();
	}


	private function handleMousePress (mouseIndex:Number, button:Number):Void
	{
		_global.onMyWeaponInfoChangePress(_index);
		dispatchEvent ({type:"press", mouseIndex:mouseIndex, button:button});
		_parent._parent._parent._parent.tar1MC.gotoAndPlay(2);
		_parent._parent._parent._parent.tar2MC.gotoAndPlay(2);
		_parent._parent._parent._parent.tarlineMC.gotoAndPlay(2);		
	}
}