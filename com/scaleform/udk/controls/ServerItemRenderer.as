/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.motion.Tween;
import mx.transitions.easing.*;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ServerItemRenderer extends ListItemRenderer
{
	private var lockIcon:MovieClip;
	private var fullIcon:MovieClip;
	private var vipIcon:MovieClip;
	private var vipBg:MovieClip;

	private var textField0:MovieClip;
	//private var textField1:MovieClip;
	private var textAni:MovieClip;
	private var textField2:MovieClip;
	private var textField3:MovieClip;
	private var textField4:MovieClip;
	private var textField5:MovieClip;
	private var _hit:MovieClip;
	private var _mask:MovieClip;
	private var doubleClickDuration:Number = 500;//LM: This could be public or public-static?
	private var doubleClickInterval:Number;
	private var mcLoader:MovieClipLoader

	// Initialization:
	public function ServerItemRenderer()
	{
		super();
		Tween.init();
	}

	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined || data.No == "")
		{
			this._visible = false;
			vipIcon._visible = false;
			vipBg._visible = false;
			
			return;
		}

		this._visible = true;
		this.data = data;
		
		vipIcon._visible = false;
		vipBg._visible = false;
		
		textAni._x = 50;
		textAni.tweenEnd();
		fullIcon.gotoAndStop(Number(data.Full) + 1);
		lockIcon.gotoAndStop(Number(data.Pass) + 1);

		textField0.text = data.No;
		textAni["txt"].text = data.ServerName;
		textField2.text = data.GameMode;
		textField3.text = data.Map;
		textField4.text = data.Players;
		textField5.text = data.Stat;
		this.disabled = data.bIsLocked
		if (data.bIsLocked)
		{
			textAni["txt"].textColor = "0x383838";
		}
		else
		{
			textAni["txt"].textColor = "0x797567";
		}
		//
		if (data.Vip == "0"||data.Vip == ""||data.Vip==undefined)
		{
			if(mcLoader.loadClip){
				mcLoader.unloadClip(vipIcon);
			}
			vipIcon._visible = false;
			vipBg._visible = false;
		}
		else
		{
			lvLoader();
			vipIcon._visible = true
			vipBg._visible = true
		}

	}

	private function updateAfterStateChange():Void
	{
		vipIcon._visible = false;
		vipBg._visible = false;
		
		textAni._x = 50;
		textAni.tweenEnd();
		fullIcon.gotoAndStop(Number(data.Full) + 1);
		lockIcon.gotoAndStop(Number(data.Pass) + 1);

		textField0.text = data.No;
		textAni["txt"].text = data.ServerName;
		textField2.text = data.GameMode;
		textField3.text = data.Map;
		textField4.text = data.Players;
		textField5.text = data.Stat;
		this.disabled = data.bIsLocked;
		if (data.bIsLocked)
		{
			textAni["txt"].textColor = "0x383838";
		}
		else
		{
			textAni["txt"].textColor = "0x797567";
		}
		//
		if (data.Vip == "0"||data.Vip == ""||data.Vip==undefined)
		{
			vipIcon._visible = false;
			vipBg._visible = false;
			if(mcLoader.loadClip){
				mcLoader.unloadClip(vipIcon);
			}
			
		}
		else
		{
			lvLoader();
			vipIcon._visible = true
			vipBg._visible = true
		}
		
		
	}
	private function lvLoader()
	{
		var urlPath:String = "img://Imgset_";
		var imgPathCardItem:String;

		var itemName = data.Vip;

		var len = itemName.length;
		var chk = itemName.substr(-4, len);
		if (_global.gfxPlayer)
		{
			imgPathCardItem = "gfxImgSet/vip/" + itemName + ".swf";
		}
		else
		{
			if (chk == "_ani")
			{
				imgPathCardItem = "VipCards_Ani/" + itemName + ".swf";
			}
			else
			{
				imgPathCardItem = urlPath + "VipCards." + itemName;
			}
		}

		mcLoader= new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPathCardItem,vipIcon);
	}

	private function onLoadInit(mc:MovieClip)
	{

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
		//_hit._disableFocus = true;        
		this.doubleClickEnabled = true;

		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		//checkBox._disableFocus = true;
		//checkBox.doubleClickEnabled=true;
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

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		if (!data.bIsLocked)
		{
			setState("over");
			textAni["txt"].textColor = "0xaa9f86";
			trace(this.index + " 번쨰 글자넓이= " + textAni["txt"].textWidth);
			if (textAni["txt"].textWidth > 137)
			{
				textAni._x = 50;
				var moveTxt = 50 - (textAni["txt"].textWidth);
				textAni.tweenTo(3,{_x:moveTxt});
				textAni.onTweenComplete = function()
				{
					_parent.textAni.tweenEnd();
					trace("xxxxxxx");
					_parent.textAni._x = 180;
					_parent.textAni.tweenTo(5,{_x:moveTxt});
				};
			}
			else
			{
				textAni._x = 50;
			}

		}
		else
		{
			delete _hit.onRollOver;
			delete _hit.onRollOut;
		}
		trace(" item over ");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		if (!data.bIsLocked)
		{
			setState("out");
			textAni["txt"].textColor = "0x797567";
			if (textAni["txt"].textWidth > 137)
			{
				textAni.tweenEnd();
				textAni._x = 50;
			}
			else
			{
				textAni._x = 50;
			}
		}
		else
		{
			delete _hit.onRollOver;
			delete _hit.onRollOut;
		}
		trace(" item Out ");
	}
	private function handleMousePress(controllerIdx:Number, keyboardOrMouse:Number, button:Number):Void
	{
		if (!data.bIsLocked)
		{
			setState("down");// Focus changes in the setState will override those in the changeFocus (above)
			dispatchEventAndSound({type:"press", controllerIdx:controllerIdx, button:button});
			if (autoRepeat)
			{
				buttonRepeatInterval = setInterval(this, "beginButtonRepeat", buttonRepeatDelay, controllerIdx, button);
			}
			textAni["txt"].textColor = "0xaa9f86";
			if (textAni["txt"].textWidth > 137)
			{
				textAni._x = 50;
				var moveTxt = 50 - (textAni["txt"].textWidth);
				textAni.tweenTo(3,{_x:moveTxt});
				textAni.onTweenComplete = function()
				{
					_parent.textAni.tweenEnd();
					trace("xxxxxxx");
					_parent.textAni._x = 180;
					_parent.textAni.tweenTo(5,{_x:moveTxt});
				};
			}
			else
			{
				textAni._x = 50;
			}
		}
		else
		{
			delete _hit.onRollOver;
			delete _hit.onRollOut;
		}

	}
	private function handleMouseRelease(controllerIdx:Number, keyboardOrMouse:Number, button:Number):Void
	{
		clearInterval(buttonRepeatInterval);
		delete buttonRepeatInterval;

		if (!data.bIsLocked)
		{
			if (doubleClickEnabled)
			{
				if (doubleClickInterval == null)
				{
					doubleClickInterval = setInterval(this, "doubleClickExpired", doubleClickDuration);

					handleClick(controllerIdx,button);

					textAni["txt"].textColor = "0xaa9f86";
					if (textAni["txt"].textWidth > 137)
					{
						textAni._x = 50;
						var moveTxt = 50 - (textAni["txt"].textWidth);
						textAni.tweenTo(3,{_x:moveTxt});
						textAni.onTweenComplete = function()
						{
							_parent.textAni.tweenEnd();
							trace("xxxxxxx");
							_parent.textAni._x = 180;
							_parent.textAni.tweenTo(5,{_x:moveTxt});
						};
					}
					else
					{
						textAni._x = 50;
					}
					trace("realse");
				}
				else
				{
					doubleClickExpired();
					dispatchEventAndSound({type:"doubleClick", controllerIdx:controllerIdx, button:button});

					trace("dbl");

					this.selected = false;
					textAni["txt"].textColor = "0x797567";
					if (textAni["txt"].textWidth > 137)
					{
						textAni.tweenEnd();
						textAni._x = 50;
					}
					else
					{
						textAni._x = 50;
					}
					return;
				}
			}
		}
		else
		{
			delete _hit.onRollOver;
			delete _hit.onRollOut;
		}

	}
	private function handleReleaseOutside(mouseIndex:Number, button:Number):Void
	{
		if (!data.bIsLocked)
		{
			setState("out");

			if (this.selected)
			{
				textAni["txt"].textColor = "0xaa9f86";
			}
			else
			{
				textAni["txt"].textColor = "0x797567";
			}

			if (textAni["txt"].textWidth > 137)
			{
				textAni.tweenEnd();
				textAni._x = 50;
			}
			else
			{
				textAni._x = 50;
			}
		}
		else
		{
			delete _hit.onRollOver;
			delete _hit.onRollOut;
		}
		trace(" item Out ");
	}
	// A double click did not happen. Clear the interval.
	private function doubleClickExpired():Void
	{
		clearInterval(doubleClickInterval);
		delete doubleClickInterval;

	}

	private function clearRepeatInterval():Void
	{
		clearInterval(buttonRepeatInterval);
		delete buttonRepeatInterval;
	}
}