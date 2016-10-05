import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.EventCheckItemView_new extends ListItemRenderer {
	 
   	//private var urlPath:String = "gamedir://\\FlashMovie\\image\\imgset\\";
	//private var urlPath:String = "gfxImgSet/";
	//private var imgPathArmor:String = urlPath+"gfx_imgset_armor.swf";
	//private var imgPathWeapon:String = urlPath+"gfx_imgset_weapon.swf";
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	//private var imgPathCashItem:String = urlPath+"gfx_imgset_cashItem.swf";
	
	private var txtConCash:MovieClip;
	private var txtConArmo:MovieClip;
	private var txtConWeapon:MovieClip;
	private var txtConSp:MovieClip;
	private var imgBox:MovieClip
	private var _ItemImg:String
	private var _index:String

	public function EventCheckItemView_new() {
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
		
		trace (_ItemImg+",,,,,"+_index)
		txtConCash._visible = false;
		txtConArmo._visible = false;
		txtConWeapon._visible = false;
		txtConSp._visible = false;		
		
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay
		
		if (data.Index== "0") {			
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay				
		}else if (data.Index == "1") {
			//lvLoader("1");
			txtConWeapon._visible = true;
			txtConWeapon["txtName"].text = data.ItemName
			txtConWeapon["txtDay"].text = data.ItemDay			
		}else if (data.Index == "2") {
			//lvLoader("2");
			txtConArmo._visible = true;
			txtConArmo["txtName"].text = data.ItemName
			txtConArmo["txtDay"].text = data.ItemDay	
		}else if (data.Index == "3") {
			//lvLoader("3");
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
				txtConCash._x=(160/2)-(txtConCash["txtName"].textWidth/2)				
				txtConCash["txtDay"]._x=(txtConCash["txtName"].textWidth/2)-(txtConCash["txtDay"].textWidth/2)
				
			}
		}
		
		lvLoader(data.Index);			
		
	}
	private function lvLoader(n:String){
		var imgPathArmor:String = "img://Imgset_Armor."+_ItemImg;
		
		var imgPathWeapon:String
		var imgPathCashItem:String;
		
		var itemName=_ItemImg
		
		var len=itemName.length
		var chk=itemName.substr(-4,len)				
		
		if(chk=="_ani"){
			imgPathCashItem="CashItem_Ani/"+itemName+".swf";
			imgPathWeapon="Weapon_Ani/"+itemName+".swf";
		}else{
			imgPathCashItem="img://Imgset_CashItem."+itemName;
			imgPathWeapon="img://Imgset_Weapon."+itemName;
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
			mc._x = -36;
		} else if (_index == "1") {
			mc._x = -36;
		} else if (_index == "2") {
			mc._x = 0;
			imgBox.gotoAndStop(_ItemImg);
		} else if (_index == "3") {
			mc._x = -20;
		}
	}
}