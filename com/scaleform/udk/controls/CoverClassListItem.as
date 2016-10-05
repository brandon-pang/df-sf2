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
class com.scaleform.udk.controls.CoverClassListItem extends ListItemRenderer
{
	private var mcLoader:MovieClipLoader;
	private var classicon:MovieClip;
	private var urlPath = "";
	private var _imgPath:String = urlPath + "imgset_class.swf";
	
	public function CoverClassListItem()
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
		invalidate();
		UpdateTextFields()
	}
	public function toString():String
	{
		return "[Scaleform ServerItemRenderer " + _name + "]";
	}
	
	private function updateAfterStateChange():Void
	{			
		UpdateTextFields()
	}
	// Private Methods:    
	private function UpdateTextFields()
	{
		lvLoader(_imgPath,classicon.tg);
	}
	
	private function lvLoader(path, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(path,mc);
	}
	
	private function onLoadInit(mc:MovieClip)
	{			
		mc.set_level(data.ClassCode);
		
		if(data.isDisable==""||data.isDisable==null||data.isDisable==" "){
			return
		}else{
			this.disabled=Boolean(data.isDisable)
		}
	}
	
	private function configUI():Void {
		super.configUI();
	}
}