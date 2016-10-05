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

class com.scaleform.udk.controls.ClanEntirelyListItem extends ListItemRenderer
{
	private var _index:String;
	private var _Mode:String; 
	private var _MapImage:String;
	private var _iconImgPath:String = "img://Imgset_ClanMap.";
	private var _iconImgPath2:String = "img://Imgset_Mode.";	
	private var dataTx:TextField;
	private var mNameTx:TextField;
	private var roundTx:TextField;
	private var clanTx:TextField;
	private var clanLinkBtn:MovieClip;
	private var _hit:MovieClip;
	private var ImgTg:MovieClip;
	private var ModeTg:MovieClip;	
	private var victoryMc:MovieClip;
	private var clanCloseMC:MovieClip;	
		
	public function ClanEntirelyListItem ()
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
		/*data.IsWin; //승패
		data.Mode; // 모드 이미지번호
		data.MapImage; //맵 이미지번호		
		data.Time; //날짜시간
		data.MapName; //맵이름
		data.Score; //스코어
		data.Enemy; //클랜이름
		data.OtherType; //폐쇄유무*/		
		_index = data.Index;		
		if(data.IsWin == "1"){
			victoryMc.gotoAndStop(1);
		}else if(data.IsWin == "2"){
			victoryMc.gotoAndStop(2);
		}else{
			victoryMc._visible = false;
		}		
		_Mode = data.Mode; 
		_MapImage = data.MapImage; 		
		dataTx.text = data.Time;
		mNameTx.text = data.MapName
		roundTx.text = data.Score;
		clanTx.htmlText = data.Enemy;		
		if(data.OtherType == "1"){
			clanCloseMC._visible = true;
			clanTx.htmlText=""
		}else{
			clanCloseMC._visible = false;
		}		
		lvLoader ();		
		var myformat:TextFormat = new TextFormat();
		myformat.underline = true;
		clanTx.setTextFormat(myformat);		
	}

	private function lvLoader ()
	{	
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);		
		mcLoader.loadClip (_iconImgPath+_MapImage,ImgTg);		
		mcLoader.loadClip (_iconImgPath2+_Mode,ModeTg);			
	}
	
	private function onLoadInit (mc:MovieClip)
	{
		if(mc._name == "ModeTg"){
			mc._xscale = mc._yscale = 50;
		}else{
			mc._y = -25;
		}
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
		_hit.onRollOver = Delegate.create (this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create (this, handleMouseRollOut);
		_hit.onDragOver = Delegate.create (this, handleMouseRollOver);
		_hit.onDragOut = Delegate.create (this, handleMouseRollOut);
		_hit.onReleaseOutside = Delegate.create (this, handleMouseRollOut);		
		clanLinkBtn.addEventListener("rollOver",this,"clanOverFn");
		clanLinkBtn.addEventListener("rollOut",this,"clanOutFn");
		clanLinkBtn.addEventListener("click",this,"clanPressFn");	
	}

	public function draw ()
	{
		super.draw ();
	}
	private function handleMouseRollOver (mouseIndex:Number, button:Number):Void
	{
		setState ("over");
	}
	private function handleMouseRollOut (mouseIndex:Number, button:Number):Void
	{
		setState ("up");
	}	
	private function clanOverFn  ():Void
	{
		setState ("over");
		clanTx.textColor = 0xffda77;
	}
	private function clanOutFn  ():Void
	{
		setState ("up");
		clanTx.textColor = 0x949494;
	}
	private function clanPressFn  ():Void
	{
		setState ("up");
		_global.clanEntirelyListClanHomePageOpen(_index);
	}


}