/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import com.scaleform.udk.utils.Tool;
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.DifficultyIconListItem extends ListItemRenderer
{
	public var lockIcon:MovieClip;
	private var modeIcon:MovieClip;
	private var txtName:TextField;
	//private var _img:String;
	//private var _txt:String;
	//private var _imgPath:String;
	private var _enable:String;
	private var listModes:String;
	
	public function DifficultyIconListItem()
	{
		super();
		
		txtName.html = true;
		txtName.verticalAlign = "center";
		txtName.noTranslate = true;
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
		
		if(data.label.length > 3 && Tool.getByteString(data.label) > 5)
		{
			txtName.htmlText = "<font size='22'>" + data.label + "</font>";
		}
		else
		{
			txtName.htmlText = "<font size='26'>" + data.label + "</font>";
		}
		
		if(listModes=="ROUND"){
			//var format1:TextFormat = new TextFormat();
			//format1.letterSpacing = -10
			//txtName.setTextFormat(format1);
			//trace (txtName.text.length)
			if(txtName.text.length==1){
				txtName._x=-1;
			}else{				
				txtName._x=-2;
			}			
		}else{
			//var format1:TextFormat = new TextFormat();
			//format1.letterSpacing = -5
			//txtName.setTextFormat(format1);
			//txtName._x=2;
		}
		
		
		if(data.Enabled==false){
			//this._alpha=30;
			txtName._alpha = 30;
			lockIcon._visible = true;
			modeIcon._visible = false;
			this.disabled=true;
		}else{
			//this._alpha=100;
			txtName._alpha = 100;
			lockIcon._visible = false;
			modeIcon._visible = true;
			this.disabled=false;
		}
	}

	private function updateAfterStateChange():Void
	{
		if(data.label.length > 3 && Tool.getByteString(data.label) > 5)
		{
			txtName.htmlText = "<font size='22'>" + data.label + "</font>";
		}
		else
		{
			txtName.htmlText = "<font size='26'>" + data.label + "</font>";
		}
		
		if(data.Enabled==false){
			//this._alpha=30;
			txtName._alpha = 30;
			lockIcon._visible = true;
			modeIcon._visible = false;
			this.disabled=true;
		}else{
			//this._alpha=100;
			txtName._alpha = 100;
			lockIcon._visible = false;
			modeIcon._visible = true;
			this.disabled=false;
		}	
	}
}