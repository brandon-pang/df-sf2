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
 class com.scaleform.udk.controls.ModeIconListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var txtName:TextField;
	private var newIcon:MovieClip;
	private var mapIcon:MovieClip;
	private var _img:String;
	private var _txt:String;
	private var _imgPath:String;
	private var _mapimg:String;
	private var _vipNone:String;
	private var IconImgPath:String;
	private var clanMatchList:Boolean;
	private var ModeConcept:String;
	private var mcLoader:MovieClipLoader;
	public var vipNone:MovieClip;
	public function ModeIconListItem()
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

		//super.setData(data);        
		_mapimg = data.MapImg;
		_img = data.IconImg;
		txtName.text = data.Title;
		_vipNone = data.VipNone
		
		switch (data.New)
		{
			case "" :
				newIcon.gotoAndStop(1);
				newIcon["txt"].text = "";
				break;
			case "0" :
				newIcon.gotoAndStop(1);
				newIcon["txt"].text = "";
				break;
			case "1" :
				if (ModeConcept == "old")
				{
					newIcon.gotoAndPlay("open");
				}
				else
				{
					newIcon.gotoAndStop(2);
					newIcon["txt"].text = "_modelist_new";
				}
				break;
			case "2" :
				newIcon.gotoAndStop(3);
				newIcon["txt"].text = "_modelist_hot";
				break;
			case "3" :
				newIcon.gotoAndStop(4);
				newIcon["txt"].text = "_modelist_easy";
				break;
			case "4" :
				newIcon.gotoAndStop(5);
				newIcon["txt"].text = "_modelist_hard";
				break;
		}

		if (data.Enabled == "false")
		{
			if (mcLoader.loadClip)
			{
				unLoader();
			}
			this.disabled = true;
		}
		else
		{
			lvLoader();
			this.disabled = false;
		}

		if (_mapimg == undefined || _mapimg == "")
		{
			mapIcon._visible = false;
			mcLoader.unloadClip(mapIcon);
		}
		else
		{
			mapIcon._visible = true;
		}
		
		if (_vipNone == undefined || _vipNone == "")
		{
			vipNone._visible = false;
			vipNone.txt.htmlText = "";
		}
		else
		{
			vipNone._visible = true;
			vipNone.txt.htmlText = _vipNone;
		}	
	}

	private function updateAfterStateChange():Void
	{
		_img = data.IconImg;
		_mapimg = data.MapImg;
		txtName.text = data.Title;
		_vipNone = data.VipNone;
		
		switch (data.New)
		{
			case "" :
				newIcon.gotoAndStop(1);
				newIcon["txt"].text = "";
				break;
			case "0" :
				newIcon.gotoAndStop(1);
				newIcon["txt"].text = "";
				break;
			case "1" :
				if (ModeConcept == "old")
				{
					newIcon.gotoAndPlay("open");
				}
				else
				{
					newIcon.gotoAndStop(2);
					newIcon["txt"].text = "_modelist_new";
				}
				break;
			case "2" :
				newIcon.gotoAndStop(3);
				newIcon["txt"].text = "_modelist_hot";
				break;
			case "3" :
				newIcon.gotoAndStop(4);
				newIcon["txt"].text = "_modelist_easy";
				break;
			case "4" :
				newIcon.gotoAndStop(5);
				newIcon["txt"].text = "_modelist_hard";
				break;
		}

		if (data.Enabled == "false")
		{
			if (mcLoader.loadClip)
			{
				unLoader();
			}
			this.disabled = true;
		}
		else
		{
			lvLoader();
			this.disabled = false;
		}

		if (_mapimg == undefined || _mapimg == "")
		{
			mapIcon._visible = false;
			mcLoader.unloadClip(mapIcon);
		}
		else
		{
			mapIcon._visible = true;
		}
		
		if (_vipNone == undefined || _vipNone == "")
		{
			vipNone._visible = false;
			vipNone.txt.htmlText = "";
		}
		else
		{
			vipNone._visible = true;
			vipNone.txt.htmlText = _vipNone;
		}
		//trace ("=========+++++++++++++===================="+"data.MapImg : "+data.MapImg+"    "+"data.IconImg ; "+data.IconImg+"+++++++++++=====================================")
	}

	private function lvLoader(caseBy:String)
	{

		var imgSetLoadName:String;
		var mapSetLoadName:String;
		if (_global.gfxPlayer)
		{
			imgSetLoadName = "gfxImgSet/" + IconImgPath + "/" + _img + ".png";
			mapSetLoadName = "gfxImgSet/Map/" + _mapimg + ".png";
		}
		else
		{
			imgSetLoadName = "img://Imgset_" + IconImgPath + "." + _img;
			mapSetLoadName = "img://Imgset_Map." + _mapimg;
		}

		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (_img != undefined)
		{
			mcLoader.loadClip(imgSetLoadName,modeIcon);
		}
		if (_mapimg == undefined || _mapimg == "")
		{
			//
		}
		else
		{
			mcLoader.loadClip(mapSetLoadName,mapIcon);
		}
	}
	private function unLoader()
	{
		if (_img != undefined)
		{
			mcLoader.unloadClip(modeIcon);
		}
		if (_mapimg != undefined)
		{
			mcLoader.unloadClip(mapIcon);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		//var imgName:String = _img;
		//modeIcon.gotoAndStop(imgName);
		if (clanMatchList)
		{
			if (mc._name == "modeIcon")
			{
				mc._x = 28;
				mc._y = 12;
				mc._xscale = mc._yscale = 75;
			}
			if (mc._name == "mapIcon")
			{
				mc._xscale = mc._yscale = 60;
				mc._x = -20;
				mc._y = 5;
			}
		}
		else
		{
			if (IconImgPath == "Mode")
			{
				if (mc._name == "modeIcon")
				{
					if (ModeConcept == "old")
					{
						mc._x = 0;
						mc._y = 0;
						mc._xscale = mc._yscale = 100;
					}
					else
					{
						mc._x = 33;
						mc._y = 12;
						mc._xscale = mc._yscale = 100;
					}

				}
				if (mc._name == "mapIcon")
				{
					mc._xscale = mc._yscale = 70;
					mc._x = -20;
					mc._y = 5;
				}
			}
		}
		if (IconImgPath == "Map")
		{
			mc._x = -15.5;
			mc._y = 0;
		}
		//  
		switch (data.New)
		{
			case "" :
				newIcon.gotoAndStop(1);
				break;
			case "0" :
				newIcon.gotoAndStop(1);
				break;
			case "1" :
				if (ModeConcept == "old")
				{
					newIcon.gotoAndPlay("open");
				}
				else
				{
					newIcon.gotoAndStop(2);
					newIcon["txtBg"]._width = newIcon["txt"].textWidth + 26;
				}
				
				break;
			case "2" :
				newIcon.gotoAndStop(3);
				newIcon["txtBg"]._width = newIcon["txt"].textWidth + 26;
				break;
			case "3" :
				newIcon.gotoAndStop(4);
				newIcon["txtBg"]._width = newIcon["txt"].textWidth + 26;
				break;
			case "4" :
				newIcon.gotoAndStop(5);
				newIcon["txtBg"]._width = newIcon["txt"].textWidth + 26;
				break;
		}

	}
}