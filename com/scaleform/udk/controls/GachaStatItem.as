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
 class com.scaleform.udk.controls.GachaStatItem extends ListItemRenderer
{
	private var txtTitle:TextField
	private var txtWeapon:TextField

	public function GachaStatItem()
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
		UpdateTextFields();
	}
	private function UpdateTextFields()
	{
		txtTitle.htmlText=data.UserName
		txtWeapon.text=data.GachaName
		
	}
}