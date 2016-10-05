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
import gfx.controls.CheckBox;
import com.scaleform.udk.utils.UDKUtils;


[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.GranListItem extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var hit:MovieClip;
	private var txtName:TextField;
	private var _img:String;
	private var _txt:String;
	
	private var camoTg:MovieClip;
	private var _camo:String;

	public function GranListItem()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);
		_img = data.IconImg;
		_camo = data.CamoBgName;			
		
		UpdateTextFields();
	}
	
	
		
		
		
	private function lvLoader(caseBy)
	{		
		var imgPathWeapon
		var camoImgPath
		var itemName=_img		
		var len=itemName.length
		var chk=itemName.substr(-4,len)				
		var camoChk:String = _camo.substr(-4);		
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);		
		
		if (caseBy == "_mode") {
			if(chk=="_ani"){			
				imgPathWeapon=UDKUtils.WeaponImgAniPath+itemName
			}else{
				imgPathWeapon=UDKUtils.WeaponImgPath+itemName;
			}		
			mcLoader.loadClip(imgPathWeapon,modeIcon);
		}
		
		if (caseBy == "_camo") {			
			if(camoChk=="_ani"){
				camoImgPath=UDKUtils.CamoImgAniPath+_camo
			}else{
				camoImgPath=UDKUtils.CamoImgPath+_camo
			}	
			mcLoader.loadClip(camoImgPath,camoTg);
		}
		
		

		
	}
	private function onLoadComplete(mc:MovieClip)
	{
		var n = mc._name;
		
		if (n == "modeIcon") {
			//var imgName:String = _img;
			modeIcon._xscale = 60;
			modeIcon._yscale = 60;
			//modeIcon.gotoAndStop(imgName);
			modeIcon._x=-26
			modeIcon._y=-16
		}		
		if (n == "camoTg") {
			camoTg._xscale = 36;
			camoTg._yscale = 36;			
		}

	}

	private function UpdateTextFields()
	{
		if (_img == "")
		{
			modeIcon._visible = false;
		}
		else
		{
			modeIcon._visible = true;
			lvLoader("_mode");
		}		
		//_camo = "CAMO_MAPLE"
		
		if (_camo != "") {
			camoTg._visible = true;
			lvLoader("_camo");
		}else{
			camoTg._visible = false;
		}

	}
	private function configUI():Void
	{
		constraints = new Constraints(this, true);
		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		// Setup MouseEvents on the "hit" MovieClip on the bottom-most layer of the         
		// component on the Stage. This allows Mouse events to reach the sub-components.
		//hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		//hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		hit.onPress = Delegate.create(this, handleMousePress);

		//hit.onRelease = Delegate.create(this, handleMouseRelease);
		//hit.onDragOver = Delegate.create(this, handleDragOver);
		//hit.onDragOut = Delegate.create(this, handleDragOut);
		//hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

		//focusTarget = owner;
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{

		//trace("sssssdf press  " + this.index);
		//trace("sssssdf config  " + this.owner["_selectedIndex"]);

		_global.inven_OnClickedEquipedThrowWeapon(this.index);
		
		if (_disabled)
		{
			return;
		}
		if (!_disableFocus)
		{
			Selection.setFocus(this);
		}
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}


	private function draw():Void
	{
		if (sizeIsInvalid)
		{// The size has changed.   
			_width = __width;
			_height = __height;
		}
	}
}