/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.controls.CoreList;
import gfx.utils.Constraints;
import gfx.utils.Delegate;

class com.scaleform.udk.controls.GiftLeftFriendList extends ListItemRenderer
{
	//계급
	private var imgGrade:MovieClip;
	private var txtName:TextField;
	private var _txtName:String;
	private var _imgGrade:String;
	
	//private var urlPath:String="gfxImgSet/"
	private var urlPath:String="";
	public var gradeImgPath:String = urlPath + "imgset_class.swf";

	// Initialization:
	public function GiftLeftFriendList()
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

		txtName.noTranslate = true;
		_imgGrade = data.Rank;
		_txtName = data.Name;
		UpdateTextFields();
	}


	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	private function UpdateTextFields()
	{
		txtName.htmlText = _txtName;
		lvLoader(gradeImgPath);
	}

	private function lvLoader(imgPath:String)
	{
		var imgMc = imgGrade;
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPath,imgMc);
	}
	private function onLoadInit(mc:MovieClip)
	{
		mc.set_level(_imgGrade);
		mc._xscale = 80;
		mc._yscale = 80;
	}
}