/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import com.scaleform.Tooltip;
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.CheckBox;
import gfx.controls.Button;
import flash.external.ExternalInterface;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.ClanSearchListMode extends ListItemRenderer
{
	private var modeIcon:MovieClip;	
	private var textField:TextField;
	private var _img:String;
	private var _mname:String;	
	private var _imgPath:String="img://Imgset_Mode.";
	public var mcLoader:MovieClipLoader;
		

	public function ClanSearchListMode()
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
		_mname = data.ModeName;
		_img   = data.ModeImg;		
		UpdateTextFields()
	}

	private function UpdateTextFields()
	{			
		textField.htmlText=_mname
		var imgPath
		if(_global.gfxPlayer){
			imgPath="gfxImgSet/modeIcon/"+_img+".png";
		}else{
			imgPath=_imgPath+_img;
		}

		lvLoader(imgPath,modeIcon["tg"]);
	}

	private function onLoadInit(mc:MovieClip)
	{
		//
	}

	private function lvLoader(path, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		mcLoader.loadClip(path,mc);
	}

	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}
		validateNow();

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void
	{
		super.configUI();
	}

	public function draw ()
	{
		super.draw ();
	}	
}