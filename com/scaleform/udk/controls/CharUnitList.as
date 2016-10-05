/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.CharUnitList extends ListItemRenderer
{
	private var unit_img:MovieClip;
	private var lockIcon:MovieClip;
	private var _hit:MovieClip;
	private var _img:String;
	private var _lock:String;
	
	public function CharUnitList()
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
		
		if (data.Lock == "1")
		{
			unit_img._visible = false;
			lockIcon.gotoAndStop(2);
			this.disabled=true
		}
		else
		{			
			unit_img._visible = true;
			lockIcon.gotoAndStop(1);
			if(data.ItemImg==undefined ||data.ItemImg==""){
				
			}else{
				lvLoader();
			}
			
			this.disabled=false
		}
	}
	private function updateAfterStateChange():Void
	{
		if (data.Lock == "1")
		{
			unit_img._visible = false;
			lockIcon.gotoAndStop(2);
			this.disabled=true
		}
		else
		{			
			unit_img._visible = true;
			lockIcon.gotoAndStop(1);
			if(data.ItemImg==undefined ||data.ItemImg==""){
				
			}else{
				lvLoader();
			}
			this.disabled=false
		}
	}
	private function lvLoader()
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		var _imgPath="img://Imgset_Unit."+data.ItemImg
		mcLoader.loadClip(_imgPath,unit_img);
	}
	private function onLoadComplete(mc:MovieClip)
	{
		
	}
}