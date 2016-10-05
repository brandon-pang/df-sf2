/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.Button;
import gfx.utils.Delegate;

 class com.scaleform.udk.controls.MsnChatTapListItem extends ListItemRenderer
{

	private var btn1:Button
	private var btnAni:MovieClip	
	private var txtCodeName:TextField;
	
	private var _hit:MovieClip;
	
	// Initialization:
	public function MsnChatTapListItem()
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
		//invalidate();
		
		txtCodeName.noTranslate=true
		if(data.ani=="1"){
			btnAni.gotoAndPlay("open")
		}else{
			btnAni.gotoAndStop(1)
		}
		txtCodeName.text=data.codename
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
		//*/ 
		//btn1._disableFocus = true;
		btn1.addEventListener("press",this,"onBtnHandler");

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

	private function onBtnHandler(e:Object)
	{
		_global.onBtnHandler();
	}
}