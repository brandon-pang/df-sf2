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

class com.scaleform.udk.controls.ClanSettingMemberListItem extends ListItemRenderer
{
	private var _index:Number;//리스트 번호
	private var _class:String;//등급
	private var _RankIndex:String;//계급인덱스
	private var _iconImgPath:String = "imgset_class.swf";
	private var txt1:TextField;
	private var txt2:TextField;
	private var txt3:TextField;
	private var changCkeck:CheckBox;
	private var classicon:MovieClip;
	private var _hit:MovieClip;
	private var _checkTest:Boolean = false;
	private var _indexTest:Number;
	
	public function ClanSettingMemberListItem ()
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
		
		if(data.Selected=="1"){
			changCkeck.selected = true;
		}else{
			changCkeck.selected = false;
		}
		_index = data.Index;
		_class = data.ClassIndex;
		_RankIndex = data.RankIndex;
		txt1.text = data.CodeName;
		txt2.text = data.ClassID;
		txt3.text = data.DateTimes;		
		lvLoader ();		
	}

	private function lvLoader ()
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);
		mcLoader.loadClip (_iconImgPath,classicon);
	}

	private function onLoadInit (mc:MovieClip)
	{
		var lvNo:String = _RankIndex;
		
		if(lvNo != "" && lvNo != undefined){			
			classicon.set_level(lvNo)			
		}
	}
	public function updateAfterStateChange ():Void
	{
		if (!initialized)
		{
			return;
		}
		if(data.Selected=="1"){
			changCkeck.selected = true;
		}else{
			changCkeck.selected = false;
		}
		_index = data.Index;
		_class = data.ClassIndex;
		_RankIndex = data.RankIndex;
		txt1.text = data.CodeName;
		txt2.text = data.ClassID;
		txt3.text = data.DateTimes;		
		lvLoader ();	
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
		_hit.onRollOver = Delegate.create (this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create (this, handleMouseRollOut);
		_hit.onPress = Delegate.create (this, handleMousePress);
		_hit.onRelease = Delegate.create (this, handleMouseRelease);
		_hit.onDragOver = Delegate.create (this, handleDragOver);
		_hit.onDragOut = Delegate.create (this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create (this, handleReleaseOutside);

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
		this._parent._parent._parent._parent._parent.clanSlistIndexNum = _index;
	}
	
	private function handleMouseRelease (mouseIndex:Number, button:Number):Void
	{		
		changCkeck.selected=!changCkeck.selected		
		_global.OnClanSettingMemberCheck (_index);			
		var boo:String
		if(changCkeck.selected){
			boo = "1"
		}else{
			boo= "0"
		}		
		_parent._parent._parent.dataProvider[this.index].Selected=boo
		this._parent._parent._parent._parent._parent._parent._parent.cbList.removeMovieClip ();
	}	

}