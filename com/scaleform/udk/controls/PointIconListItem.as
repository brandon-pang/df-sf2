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
 class com.scaleform.udk.controls.PointIconListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var txtName:TextField;
	//private var _img:String;
	//private var _txt:String;
	//private var _imgPath:String;
	private var _enable:String;
	private var listModes:String;
	
	public function PointIconListItem()
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

		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);		
		txtName.text = data.label;
		if(listModes=="ROUND"){
			//var format1:TextFormat = new TextFormat();
			//format1.letterSpacing = -10
			//txtName.setTextFormat(format1);
			//trace (txtName.text.length)
			if(txtName.text.length==1){
				txtName._x=-1
			}else{				
				txtName._x=-2
			}			
		}else if(listModes=="POINT"){
			//var format1:TextFormat = new TextFormat();
			//format1.letterSpacing = -5
			//txtName.setTextFormat(format1);
			txtName._x=2
		}else{
			txtName._x=1
		}
		
		
		if(data.Enabled=="false"){
			this._alpha=30
			this.disabled=true
		}else{
			this._alpha=100
			this.disabled=false
		}
	}

	private function updateAfterStateChange():Void
	{
		txtName.text = data.label;
		
		if(data.Enabled=="false"){
			this._alpha=30
			this.disabled=true
		}else{
			this._alpha=100
			this.disabled=false
		}	
	}
}