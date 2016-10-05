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
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.CharWeaponList extends ListItemRenderer
{
	private var unit_img:MovieClip;
	private var _hit:MovieClip;
	private var _img:String;
	//private var _imgPath:String="gfx_imgset_big_weapon.swf"

	public function CharWeaponList()
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
		_img = data.ItemImg;
		UpdateTextFields();
	}
	private function lvLoader(caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		var _imgPath=UDKUtils.WeaponImgPath+data.ItemImg
		mcLoader.loadClip(_imgPath,unit_img);
	}
	private function onLoadComplete(mc:MovieClip)
	{
		//var imgName:String = _img;
		//unit_img.gotoAndStop(imgName);
	}
	private function UpdateTextFields()
	{
		lvLoader();
	}
}