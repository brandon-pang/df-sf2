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
class com.scaleform.udk.controls.CrateListItem extends ListItemRenderer
{	
	private var imgBox:MovieClip;
	private var txtName:TextField;	
	private var _txtname:String;	
	private var _img:String;
	private var _index:String
	private var _rare:String
	private var frame:MovieClip;
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	
	// Initialization:

	public function CrateListItem()
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

		_txtname = data.ItemName		
		_img = data.ItemImg
		_index=data.ItemIndex
		_rare=data.Rare

		UpdateTextFields();
	}
	
	private function lvLoader(n:String){
		var urlPath:String = "img://Imgset_";
		var imgPathArmor:String = urlPath+"Armor."+_img;
		
		var imgPathWeapon:String
		var imgPathCashItem:String;
		
		var itemName=_img
		
		var len=itemName.length
		var chk=itemName.substr(-4,len)	
		
		if (_global.gfxPlayer) {
			imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "gfxImgSet/Armor/"+itemName+".png";
			imgPathCashItem = "gfxImgSet/CashItem/"+itemName+".png";
			imgPathWeapon = "gfxImgSet/Weapon/"+itemName+".png";
		} else {
			imgPathUnit = "gfx_imgset_unitbox.swf";			
			imgPathArmor = "img://Imgset_Armor."+itemName;
			if (chk == "_ani") {
				imgPathCashItem = "CashItem_Ani/"+itemName+".swf";
				imgPathWeapon = "Weapon_Ani/"+itemName+".swf";
			} else {
				imgPathCashItem = "img://Imgset_CashItem."+itemName;
				imgPathWeapon = "img://Imgset_Weapon."+itemName;
			}
		}
				
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,imgBox);			
		}else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,imgBox);
		}else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,imgBox);
		}else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,imgBox);
		}
	}
	private function onLoadInit(mc:MovieClip) {	
		mc._xscale=mc._yscale=70
		
		if (_index == "0") {
			mc._y=5
			mc._x=-35
		}else if (_index == "1") {
			mc._xscale=mc._yscale=60
			mc._y=12
			mc._x=-19			
		}else if (_index == "2") {
			mc._x=0
			imgBox.gotoAndStop(_img);
		}else if (_index == "3") {
			mc._y=5
			mc._x=14
		}
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
		if(_rare=="1"){
			frame.gotoAndStop(2)
		}else{
			frame.gotoAndStop(1)
		}
		
		lvLoader(data.ItemIndex)
	}	
}