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
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.ListItemDetail extends ListItemRenderer
{	
	private var modeIcon:MovieClip;
	private var txtName:TextField;
	private var txtContent:TextField;
	
	private var _txtname:String;
	private var _txtcontent:String;
	private var _img:String;
	
	private var urlPath:String=""
	private var imgPath:String=urlPath+""
	
	// Initialization:

	public function ListItemDetail()
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

		_txtname = data.txtName
		_txtcontent = data.txtContent
		_img = data.img

		UpdateTextFields();
	}
	
	private function lvLoader(caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);				
		mcLoader.loadClip(imgPath,modeIcon);		
	}
	
	private function onLoadInit(mc:MovieClip)
	{		
		var imgName:String = _img
		modeIcon.gotoAndStop(imgName);		
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
		txtName.text=_txtname
		txtContent.text = _txtcontent
		
		lvLoader()
	}	
}