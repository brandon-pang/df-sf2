/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.controls.TileList

class com.scaleform.udk.controls.ShopMaskList extends ListItemRenderer
{
	private var columList:TileList;
	
	public function ShopMaskList ()
	{
		super ();
	}

	public function setData (data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined || data.No == "")
		{
			this._visible = false;
			return;
		}

		this._visible = true;
		this.data = data;	
		//_dataProvider = data.DataProvider;
		columList.dataProvider = data.dataProvider;

	}

	private function updateAfterStateChange ():Void
	{
		columList.dataProvider = data.dataProvider;
	}
}