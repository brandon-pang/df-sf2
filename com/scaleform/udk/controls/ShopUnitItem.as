/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import flash.filters.ColorMatrixFilter;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ShopUnitItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var takeIcon:MovieClip;
	private var txtUnitName:MovieClip;
	private var newIconMC:MovieClip;
	private var hotIconMC:MovieClip;
	private var eventIconMC:MovieClip;

	private var _img:String;
	private var _take:String;
	private var hit:MovieClip;
	//gamedir://\\FlashMovie\\image\\imgset\\gfx_imgset_unitbox.swf
	//d:/sf2perforce.dragonflygame.com/webbug_webbug-PC/depot/Root/SFGame/FlashMovie/Image/imgset/
	private var _imgUnitPath:String="gfx_imgset_unitbox.swf"
	// instance of a generic MovieClip on the bottom-most layer of the component.
	//private var BlackObj:ColorMatrixFilter
	//private var NormalObj:ColorMatrixFilter

	public function ShopUnitItem()
	{
		super();
		/*BlackObj=new ColorMatrixFilter();
		NormalObj=new ColorMatrixFilter();
		BlackObj.matrix=new Array(1/3,1/3,1/3,0,0,
		  1/3,1/3,1/3,0,0,
		  1/3,1/3,1/3,0,0,
		  0,0,0,1,0)
		
		NormalObj.matrix=new Array(1,0,0,0,0,
		   0,1,0,0,0,
		   0,0,1,0,0,
		   0,0,0,1,0)*/
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
		//lvLoader();

		_img = data.IconImg;
		txtUnitName.text = "_shop_unit_name_" + data.IconImg;
		_take = data.Take;
		trace("============================")
		trace(" ****** " + _take +" ****** ")
		trace("============================")
		//UpdateTextFields();
		
		lvLoader();
		
		if(data.NewIcon == undefined || data.NewIcon == "0"){
			newIconMC._visible = false;
		}else{
			newIconMC._visible = true;
			newIconMC._x = 82;
		}
		
		if(data.HotIcon == undefined || data.HotIcon == "0"){
			hotIconMC._visible = false;
		}else{
			hotIconMC._visible = true;
			hotIconMC._x = 82;
		}
		
		if (data.HotIcon != "0" && data.NewIcon != "0"){
			hotIconMC._x = 55;
			newIconMC._x = 82;
		}
		
		if(data.EventIcon == undefined || data.EventIcon == "0"){
			eventIconMC._visible = false;
		}else{
			eventIconMC._visible = true;
		}


	}
	private function lvLoader()
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(_imgUnitPath, modeIcon);
	}
	//private function onLoadComplete(mc:MovieClip)
	
	private function onLoadInit (mc:MovieClip)
	{
		var imgName:String = _img;
		modeIcon.gotoAndStop(imgName);
		//modeIcon.filters=[BlackObj]

		var no = this.owner["_selectedIndex"];

		if (this.index == no)
		{
			modeIcon["img"].gotoAndStop(3);
		}
		else
		{
			if (_take == "1")
			{
				modeIcon["img"].gotoAndStop(2);
			}
			else
			{
				modeIcon["img"].gotoAndStop(1);
			}

		}
		//trace(" ****** " + _take +" ****** ")

	}
	
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		if (_disabled)
		{
			return;
		}
		if (!_disableFocus)
		{
			Selection.setFocus(this);
		}
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}


	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{

		setState("over");// Focus changes in the setState will override those in the changeFocus (above)
		//modeIcon.filters=[NormalObj]
		dispatchEvent({type:"rollOver", mouseIndex:mouseIndex, button:button});

		//if (owner.focused && this.selected)
		//{
		modeIcon["img"].gotoAndStop(3);
		//}
	}

	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{

		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		//modeIcon.filters=[NormalObj]
		dispatchEvent({type:"click", mouseIndex:mouseIndex, button:button});

		//if (owner.focused && this.selected)
		//{
		modeIcon["img"].gotoAndStop(3);
		//}
	}

	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		//modeIcon.filters=[BlackObj]
		setState("up");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"rollOut", mouseIndex:mouseIndex, button:button});
		var no = this.owner["_selectedIndex"];

		if (this.index == no)
		{
			modeIcon["img"].gotoAndStop(3);
		}
		else
		{
			if (_take == "1")
			{
				modeIcon["img"].gotoAndStop(2);
			}
			else
			{
				modeIcon["img"].gotoAndStop(1);
			}

		}
	}

	private function handleReleaseOutside(mouseIndex:Number, button:Number):Void
	{
		//modeIcon.filters=[BlackObj]
		setState("up");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"rollOut", mouseIndex:mouseIndex, button:button});
		var no = this.owner["_selectedIndex"];

		if (this.index == no)
		{
			modeIcon["img"].gotoAndStop(3);
		}
		else
		{
			if (_take == "1")
			{
				modeIcon["img"].gotoAndStop(2);
			}
			else
			{
				modeIcon["img"].gotoAndStop(1);
			}

		}
	}



	private function draw():Void
	{
		if (sizeIsInvalid)
		{// The size has changed.   
			_width = __width;
			_height = __height;
		}
	}

	private function configUI():Void
	{

		// Setup MouseEvents on the "hit" MovieClip on the bottom-most layer of the
		// component on the Stage. This allows Mouse events to reach the sub-components.
		hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		hit.onPress = Delegate.create(this, handleMousePress);
		hit.onRelease = Delegate.create(this, handleMouseRelease);
		hit.onDragOver = Delegate.create(this, handleDragOver);
		hit.onDragOut = Delegate.create(this, handleDragOut);
		hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

		focusTarget = owner;
	}

	private function changeFocus():Void
	{
		if (_disabled)
		{
			return;
		}
		if (hit == null)
		{
			setState((_focused || _displayFocus) ? "over" : "up");
		}
		if (hit != null)
		{
			setState("up");
			if (this.selected)
			{

				modeIcon["img"].gotoAndStop(3);
			}
			else
			{
				if (_take == "1")
				{
					modeIcon["img"].gotoAndStop(2);
				}
				else
				{
					modeIcon["img"].gotoAndStop(1);
				}

			}
		}
	}

}