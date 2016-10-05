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

class com.scaleform.udk.controls.ClanCommListItem extends ListItemRenderer
{
	private var _index:String;//리스트 번호
	private var _imgIndex:String;//이미지인덱스
	private var imgTg:MovieClip;//개인이미지 타겟
	private var _iconImgPath:String = "img://Imgset_Personal.";
	private var txtComm:TextField;
	private var txtDate:TextField;
	private var bgLMC:MovieClip;//배경
	private var deleteBtn:MovieClip;
	private var _hit:MovieClip;
	private var flag:Boolean;
	private var _IsCommDeleteBtn:Number;
	private var _over:Boolean;	

	public function ClanCommListItem ()
	{
		super ();
	}

	public function updateAfterStateChange ():Void
	{		
		if(_IsCommDeleteBtn == 0){
			deleteBtn._visible = false;
		}else{
			deleteBtn._visible = true;
			deleteBtn.gotoAndStop("up");
		}
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
		super.setData (data);

		_index = data.Index;
		_imgIndex = data.ImgIndex;
		txtComm.htmlText = data.Comments;
		txtDate.text = data.DateTimes;
		_IsCommDeleteBtn = data.IsCommDeleteBtn;
		
		txtComm.setImageSubstitutions (_parent._parent._parent._parent._parent._parent._parent._parent._parent.icons);	
		
		lvLoader ();
		if(_IsCommDeleteBtn == 0){
			deleteBtn._visible = false;
		}else{
			deleteBtn._visible = true;			
		}		
	}

	private function lvLoader ()
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);
		mcLoader.loadClip (_iconImgPath+_imgIndex,imgTg);
	}
	private function onLoadInit (mc:MovieClip)
	{
		//mc._width = mc._height = 35;
		bgLMC.gotoAndStop (String (data.BgIndex));
		
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
		deleteBtn.addEventListener ("press",this,"handleMousePress");		
		_hit.onRollOver = Delegate.create (this, handleListOver);
		_hit.onRollOut = Delegate.create (this, handleListOut);
		_hit.onReleaseOutside = Delegate.create (this, handleListOut);
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
	private function handleMousePress (e:Object)
	{
		setState("up");
		_global.OnClanCommListDel (_index);		
	}
	private function handleMouseOver (e:Object)
	{
		setState("over");
	}
	private function handleMouseOut (e:Object)
	{
		setState("up");
	}
	public function handleListOver (e:Object)
	{
		setState("over");
	}
	private function handleListOut (e:Object)
	{		
		setState("up");		
	}
}