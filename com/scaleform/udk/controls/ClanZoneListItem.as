/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.controls.CoreList;
import gfx.utils.Delegate;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
 class com.scaleform.udk.controls.ClanZoneListItem extends ListItemRenderer
{

	private var _index:Number;
	private var _txt:String;
	private var _hit:MovieClip;
	private var txt:TextField;

	public function ClanZoneListItem ()
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
		super.setData (data);
		
		_index = data.DBCode;
		_txt = data.AreaName;
		txt.text = data.AreaName;
		trace(data.AreaName)
	}


	public function toString ():String
	{
		return "[Scaleform ListItemRenderer " + _name + "]";
	}


	private function configUI ():Void
	{
		super.configUI ();
		focusTarget = owner;
		_hit.onPress = Delegate.create (this, handleMousePress);
	}

	private function handleMousePress (e:Object)
	{
		//trace (targetPath(this)+"/////"+_parent.index+"/////"+_name);
		trace (_txt);
		_global.ClanAreaSelectDlg_OnClickArea(_index, "");

	}

}