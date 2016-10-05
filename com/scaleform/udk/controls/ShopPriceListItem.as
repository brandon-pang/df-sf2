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

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ShopPriceListItem extends ListItemRenderer
{
	private var txt1:TextField;
	private var txt3:TextField;
	private var iconMC:MovieClip;
	private var isDate:String;
	private var isPrice:String;
	private var isIcons:String;
	private var loc:String;
	private var cha:String;
	private var mcLoader:MovieClipLoader;
	private var miconPath:String = "gfx_imgset_money.swf";

	public function ShopPriceListItem()
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
		isDate=data.IsDate
		isPrice=data.IsPrice
		isIcons=data.IsIcons
		loc=_parent._parent._parent._parent._parent._parent.localVar
		cha=_parent._parent._parent._parent._parent._parent.channelingVar
		lvLoader(miconPath,iconMC)		
	}
	private function lvLoader(path,mc) {
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(path,mc);
	}
	private function onLoadInit(mc:MovieClip) {
		UpdateTextFields();
	}
	
	private function UpdateTextFields()
	{
		txt1.text=isDate
		txt3.text=isPrice
		var _i
		if(loc=="JPN"){			
			iconMC.gotoAndStop(isIcons+"_J")		
		}else if(loc=="USA"){
			if(isIcons=="CASH"){
				_i=isIcons+"_USA";
			}else if(isIcons=="TP"){
				_i=isIcons+"_USA";
			}else{
				_i=isIcons;
			}
			iconMC.gotoAndStop(_i)
		}else{
			if(cha=="NAVER"){
				iconMC.gotoAndStop(isIcons+"_NAVER")		
			}else if(cha=="HANGAME"){
				iconMC.gotoAndStop(isIcons+"_HANGAME")		
			}else{	
				iconMC.gotoAndStop(isIcons)		
			}			
		}		
	}	
	
	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}

		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
}