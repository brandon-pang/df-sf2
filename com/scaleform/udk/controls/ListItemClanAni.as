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

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.ListItemClanAni extends ListItemRenderer
{	
	private var imgMc:MovieClip;	
	private var _img:String;
	public function ListItemClanAni()
	{
		super();
	}
	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;

		if (data == undefined)
		{
			this._visible = false;
			return;
		}

		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);
		_img = data.ImgItem;
		lvLoader();
	}

	private function updateAfterStateChange():Void
	{
		_img = data.ImgItem;
	}
	private function lvLoader()
	{
		var imgPathClanAni:String;
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if (_global.gfxPlayer)
		{
			imgPathClanAni = "gfxImgSet/Clan_ani/" + _img + ".png";
		}
		else
		{
			imgPathClanAni = "img://Imgset_ClanAni." + _img;
		}
		mcLoader.loadClip(imgPathClanAni,imgMc);
	}
	private function onLoadInit(mc:MovieClip)
	{
		mc._width=mc._height=41
	}
	
	
}