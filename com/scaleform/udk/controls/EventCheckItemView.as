import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.EventCheckItemView extends ListItemRenderer {	 
 
	private var txtConWeapon:MovieClip;
	private var imgBox:MovieClip
	private var _ItemImg:String
	private var _index:String

	public function EventCheckItemView() {
		super();
	}

	public function setData(data:Object):Void {

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		_ItemImg = data.ItemImg
		_index=data.Index		
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay	
		if (data.Index == "3") {
			if(data.ItemDay==""){				
				txtConWeapon["txtDay"]._visible=false
				txtConWeapon["txtName"].text = data.ItemName
			}else{
				txtConWeapon["txtDay"]._visible=true
				txtConWeapon["txtName"].text = data.ItemName
				txtConWeapon["txtDay"].text = data.ItemDay	
			}
		}else{
			txtConWeapon["txtDay"]._visible=true
			txtConWeapon["txtName"].text = data.ItemName
			txtConWeapon["txtDay"].text = data.ItemDay				
		}
		
		lvLoader(data.Index);			
		
	}
	private function lvLoader(n:String){
		var imgPathArmor:String = "img://Imgset_Armor."+_ItemImg;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var imgPathUnit:String;
		var imgName = _ItemImg;
		var len = imgName.length;
		var chk = imgName.substr(-4, len);
		
		if (_global.gfxPlayer) {
			imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "gfxImgSet/Armor/"+imgName+".png";
			imgPathCashItem = "gfxImgSet/CashItem/"+imgName+".png";
			imgPathWeapon = "gfxImgSet/Weapon/"+imgName+".png";
		} else {
			imgPathUnit = "gfx_imgset_unitbox.swf";			
			imgPathArmor = "img://Imgset_Armor."+imgName;
			if (chk == "_ani") {
				imgPathCashItem = "CashItem_Ani/"+imgName+".swf";
				imgPathWeapon = "Weapon_Ani/"+imgName+".swf";
			} else {
				imgPathCashItem = "img://Imgset_CashItem."+imgName;
				imgPathWeapon = "img://Imgset_Weapon."+imgName;
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
	private function onLoadComplete(mc:MovieClip) {		
		//trace (mc._name +",,,,"+data.Index+",,,"+data.ItemImg)
	
		if (_index == "0") {
			mc._x = -56;
		} else if (_index == "1") {
			mc._x = -56;
		} else if (_index == "2") {
			mc._x = -56;
			imgBox.gotoAndStop(_ItemImg);
		} else if (_index == "3") {
			mc._x = 8;
		}
	}
}