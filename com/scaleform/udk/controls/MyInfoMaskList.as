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
import gfx.controls.TileList;

class com.scaleform.udk.controls.MyInfoMaskList extends ListItemRenderer
{
	private var columList:TileList;
	private var _id:Number;

	public function MyInfoMaskList()
	{
		super();
	}

	public function setData(data:Object):Void
	{

		if (data == undefined || data.No == "")
		{
			this._visible = false;
			return;
		}

		this.data = data;
		this._visible = true;
				
		columList.dataProvider = data.dataProvider;
		_id = this.index;
		
		//trace("---77777777777---"+data.dataProvider);
		//trace("---77777777777---"+columList.dataProvider);
		//trace("====="+_id);
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

	private function configUI():Void
	{
		constraints = new Constraints(this, true);

		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw()
	{
		super.draw();

	}
}