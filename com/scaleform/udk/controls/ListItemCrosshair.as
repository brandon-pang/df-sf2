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
 class com.scaleform.udk.controls.ListItemCrosshair extends ListItemRenderer
{
	private var imgBox:MovieClip;
	private var imgMc_blue:MovieClip;
	private var imgMc_green:MovieClip;
	private var imgMc_red:MovieClip;

	private var _img:String;
	private var _color:String;
	public function ListItemCrosshair()
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
		
		_img = data.CrosshairImg;

		/*
		if (_color == "FF1919")
		{
			imgMc_blue._visible = false;
			imgMc_green._visible = false;
			imgMc_red._visible = !false;
		}
		if (_color == "00FF00")
		{
			imgMc_blue._visible = false;
			imgMc_green._visible = !false;
			imgMc_red._visible = false;
		}
		if (_color == "00FFDA")
		{
			imgMc_blue._visible = !false;
			imgMc_green._visible = false;
			imgMc_red._visible = false;
		}
		*/
		lvLoader();
	}

	private function updateAfterStateChange():Void
	{
		
		_img = data.CrosshairImg;

		/*	
	  	if (_color == "FF1919")
		{
			imgMc_blue._visible = false;
			imgMc_green._visible = false;
			imgMc_red._visible = !false;
		}
		if (_color == "00FF00")
		{
			imgMc_blue._visible = false;
			imgMc_green._visible = !false;
			imgMc_red._visible = false;
		}
		if (_color == "00FFDA")
		{
			imgMc_blue._visible = !false;
			imgMc_green._visible = false;
			imgMc_red._visible = false;
		}
		*/
		
		//lvLoader();
	}
	private function lvLoader()
	{
		var imgPathCrossHair:String;
		var mcTarget:MovieClip;
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		if (_global.gfxPlayer)
		{
			imgPathCrossHair = "gfxImgSet/crosshair/" + _img + ".png"
		}
		else
		{
			imgPathCrossHair = "img://Imgset_Crosshair." + _img;
		}
		
		mcLoader.loadClip(imgPathCrossHair,imgBox);
	}
	private function onLoadInit(mc:MovieClip)
	{

	}
}