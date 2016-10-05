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
import flash.external.ExternalInterface;
import com.scaleform.udk.utils.UDKUtils 

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.GachaGameItemList extends ListItemRenderer {
	 
   	//private var urlPath:String = "gamedir://\\FlashMovie\\image\\imgset\\";
	//private var urlPath:String = "gfxImgSet/";
	//private var imgPathArmor:String = urlPath+"gfx_imgset_armor.swf";
	//private var imgPathWeapon:String = urlPath+"gfx_imgset_weapon.swf";
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	//private var imgPathCashItem:String = urlPath+"gfx_imgset_cashItem.swf";
	private var blinkMc:MovieClip;
	private var txtConCash:MovieClip;
	private var txtConArmo:MovieClip;
	private var txtConWeapon:MovieClip;
	private var txtConSp:MovieClip;
	private var imgBox:MovieClip
	private var _ItemImg:String
	private var _index:String
	private var _rare:String

	public function GachaGameItemList() {
		super();
	}

	public function setData(data:Object):Void {

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		txtConCash._visible = false;
		txtConArmo._visible = false;
		txtConWeapon._visible = false;
		txtConSp._visible = false;		
		
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay
		
		_ItemImg = data.ItemImg
		_index=data.Index
		if (data.Index == "0") {
			lvLoader("0");	
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay				
		}else if (data.Index == "1") {
			lvLoader("1");
			txtConWeapon._visible = true;
			txtConWeapon["txtName"].text = data.ItemName
			txtConWeapon["txtDay"].text = data.ItemDay			
		}else if (data.Index == "2") {
			lvLoader("2");
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay	
		}else if (data.Index == "3") {
			lvLoader("3");
			if(data.ItemDay==""){
				txtConSp._visible = true;
				txtConCash._visible = false
				txtConSp["txtName"].text = data.ItemName			
				//txtConSp._x=(108/2)-(txtConSp["txtName"].textWidth/2)
			}else{
				txtConSp._visible = false
				txtConCash._visible = true;
				txtConCash["txtName"].text = data.ItemName			
				txtConCash["txtDay"].text = data.ItemDay			
				//txtConCash._x=(160/2)-(txtConCash["txtName"].textWidth/2)				
				//txtConCash["txtDay"]._x=(txtConCash["txtName"].textWidth/2)-(txtConCash["txtDay"].textWidth/2)
				
			}
		}
		if(data.Rare=="1"){
			blinkMc.gotoAndPlay("start")
		}else{
			blinkMc.gotoAndStop(1);
		}
	}
	private function lvLoader(n:String){
		
		var imgPathArmor:String = UDKUtils.ArmorImgPath+_ItemImg;
		
		var imgPathWeapon:String
		var imgPathCashItem:String;
		
		var itemName=_ItemImg
		
		var len=itemName.length
		var chk=itemName.substr(-4,len)				
		
		if(chk=="_ani"){
			imgPathCashItem=UDKUtils.CashImgAniPath+itemName
			imgPathWeapon=UDKUtils.WeaponImgAniPath+itemName
		}else{
			imgPathCashItem=UDKUtils.CashImgPath+itemName
			imgPathWeapon=UDKUtils.WeaponImgPath+itemName
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
		if (mc._name == "imgBox") {
			
		}
		if (_index == "0") {
			mc._y=5
			mc._x=-38
		}else if (_index == "1") {
			mc._y=5
			mc._x=-38
		}else if (_index == "2") {
			mc._x=0
			imgBox.gotoAndStop(_ItemImg);
		}else if (_index == "3") {
			mc._y=5
			mc._x=18
		}
	}

	private function updateAfterStateChange():Void {		
		if (!initialized) {
			return;
		}
		
		txtConArmo._visible = false;
		txtConWeapon._visible = false;
		txtConSp._visible = false;		
		
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay
		
		
		_ItemImg = data.ItemImg
		_index=data.Index
		//장비, 무기, 부대, 캐시
		txtConCash._visible = false;
		txtConArmo._visible = false;
		txtConWeapon._visible = false;
		txtConSp._visible = false;		
		
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay
		
		_ItemImg = data.ItemImg
		_index=data.Index
		//장비, 무기, 부대, 캐시
		if (data.Index == "0") {
			lvLoader("0");	
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay				
		}else if (data.Index == "1") {
			lvLoader("1");
			txtConWeapon._visible = true;
			txtConWeapon["txtName"].text = data.ItemName
			txtConWeapon["txtDay"].text = data.ItemDay			
		}else if (data.Index == "2") {
			lvLoader("2");
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay	
		}else if (data.Index == "3") {
			lvLoader("3");
			if(data.ItemDay==""){
				txtConSp._visible = true;
				txtConCash._visible = false
				txtConSp["txtName"].text = data.ItemName			
				//txtConSp._x=(108/2)-(txtConSp["txtName"].textWidth/2)
			}else{
				txtConSp._visible = false
				txtConCash._visible = true;
				txtConCash["txtName"].text = data.ItemName			
				txtConCash["txtDay"].text = data.ItemDay			
				//txtConCash._x=(160/2)-(txtConCash["txtName"].textWidth/2)				
				//txtConCash["txtDay"]._x=(txtConCash["txtName"].textWidth/2)-(txtConCash["txtDay"].textWidth/2)
			}
		}
		
		if(data.Rare=="1"){
			blinkMc.gotoAndPlay("start")
		}else{
			blinkMc.gotoAndStop(1);
		}
		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void {
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		/*_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/ 		
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw() {
		super.draw();
	}

}