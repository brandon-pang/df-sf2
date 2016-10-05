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
 class com.scaleform.udk.controls.ShopSaleListItem extends ListItemRenderer
{
	private var txt1:TextField;	
	
	private var isDate:String;
	private var isPrice:String;
	private var isIcons:String;	
	
	public function ShopSaleListItem()
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
		
		UpdateTextFields();
	}	
	
	private function UpdateTextFields()
	{
		var _txt=isPrice
		var _day=isDate;
		var _icon=isIcons;
		if(_icon=="" || _icon==undefined){
			txt1.htmlText=_txt
		}else{
			txt1.htmlText="<img src='"+_icon+"'vspace='-5'><font size='12'>"+_txt+" "+"<font size='10'>"+_day;
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