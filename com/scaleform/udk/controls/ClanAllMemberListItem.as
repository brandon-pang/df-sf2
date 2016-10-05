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


class com.scaleform.udk.controls.ClanAllMemberListItem extends ListItemRenderer
{
	private var _index:Number;//리스트 번호
	private var _ImgIndex:String;//개인이미지
	private var _iconImgPath2:String = "img://Imgset_Personal_Small.";

	private var nameTx:TextField;
	private var _hit:MovieClip;
	private var ImgTg:MovieClip;
	
	//private var loadListener:Object;


	public function ClanAllMemberListItem ()
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
		this._visible = true;

		_index = data.Index;
		_ImgIndex = data.ImgIndex;		
		nameTx.text = data.CodeName;

		lvLoader ();

		invalidate ();
		
		
	}

	private function lvLoader ()
	{
		
		var mcLoader2:MovieClipLoader = new MovieClipLoader ();
		mcLoader2.addListener (this);
		mcLoader2.loadClip (_iconImgPath2+_ImgIndex,ImgTg);
	}

	private function onLoadInit (mc:MovieClip)
	{
		ImgTg._xscale = ImgTg._yscale = 40;
		//ImgTg.imgs.gotoAndStop (String (_ImgIndex));
	}
	


	public function updateAfterStateChange ():Void
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

		/*_hit.onRollOver = Delegate.create (this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create (this, handleMouseRollOut);
		_hit.onPress = Delegate.create (this, handleMousePress);
		_hit.onRelease = Delegate.create (this, handleMouseRelease);
		_hit.onDragOver = Delegate.create (this, handleDragOver);
		_hit.onDragOut = Delegate.create (this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create (this, handleReleaseOutside);*/

		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw ()
	{
		super.draw ();

	}


	private function handleMouseRollOver (mouseIndex:Number, button:Number):Void
	{
		setState ("over");
		//_global.OnClanMemberListOver (_index);
	}
	private function handleMouseRollOut (mouseIndex:Number, button:Number):Void
	{
		setState ("out");
	}
	private function handleMousePress (mouseIndex:Number, button:Number):Void
	{
		setState ("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent ({type:"press", mouseIndex:mouseIndex, button:button});

		//_global.OnClanMemberListClick (_index);

	}
	private function handleMouseRelease (mouseIndex:Number, button:Number):Void
	{
		setState ("release");
		handleClick (mouseIndex,button);
	}	

}