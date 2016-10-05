/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.EquipItemRenderer extends ListItemRenderer
{

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var equip_text:TextField;	
	private var equip_img:MovieClip;

	private var _text:String;
	private var _img:String;

	// Initialization:
	public function EquipItemRenderer()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);
		trace(data.ClassIcon);

		_text = data.Text
		_img = data.Img;		

		UpdateTextFields();
	}
	private function lvLoader(caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);				
		mcLoader.loadClip("imgset_armor.swf",equip_img);		
	}
	private function onLoadInit(mc:MovieClip)
	{		
		var imgName:String = _img
		equip_img.gotoAndStop(imgName);	
		equip_img._xscale = 55
		equip_img._yscale = 55
	}
	private function updateAfterStateChange():Void
	{	
		if (!initialized) {
			return;
		}
	
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	// Private Methods:    
	private function UpdateTextFields()
	{
		equip_text.htmlText = _text;
		if (_img != "")
		{
			lvLoader()
		}
	}
}