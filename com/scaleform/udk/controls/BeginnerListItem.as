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
[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.BeginnerListItem extends ListItemRenderer {
	 
    private var urlPath:String = "";
	private var imgPathUnit:String = urlPath+"gfx_imgset_unitbox.swf";
	private var imgPathImageSet:String = urlPath+"imgset_class.swf";	 
	public var charBg:MovieClip;
	public var charTxt:TextField;
	private var tgMC:MovieClip;
	private var tgMC2:MovieClip;
	private var tgMC3:MovieClip;
	private var markMC:MovieClip;
	private var RankTg:MovieClip;
	private var weaponMC:MovieClip;
	private var armorMC:MovieClip;
	private var _ImageURL:String;
	private var _Rank:String;
	private var cashMC:MovieClip;
    private var mcLoader:MovieClipLoader; 
	
	public function BeginnerListItem() {
		super();
		
		charBg._visible = false;
		charTxt.verticalAlign = "center";
		charTxt.noTranslate = true;
	}
	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		RankTg._visible = false;		
		weaponMC._visible = false;
		armorMC._visible = false;				
		cashMC._visible = false;
		charBg._visible = false;
		charTxt.text = "";
		//인덱스 data.Index
		//이름 data.Label
		//설명 data.ItemInfo
		//럭키포인트 data.Special
		//방어포인트 data.Armor
		//계급 data.Rank
		//아이템실제이름 data.ImageURL
		
		weaponMC.txt2.text=""
		armorMC.txt2.text=""
		
		mcLoader.unloadClip(tgMC);		
		_ImageURL = data.ImageURL;		
		//장비, 무기, 부대, 캐시
		if (data.Index == "0") {
			lvLoader("0");
			armorMC._visible = true;
			armorMC.txt1.text = data.Label;
			armorMC.txt2.text = data.ItemInfo;			
			
		}else if (data.Index == "1") {
			lvLoader("1");
			weaponMC._visible = true;
			weaponMC.txt1.text = data.Label;
			weaponMC.txt2.text = data.ItemInfo;
		}else if (data.Index == "2") {
			lvLoader("2");
			weaponMC._visible = true;
			weaponMC.txt1.text = data.Label;
			weaponMC.txt2.text = data.ItemInfo;
		}else if (data.Index == "3") {
			lvLoader("3");
			if(data.IconName!=""){
				cashMC._visible = true;
				cashMC.iconMC.gotoAndStop(data.IconName);
				cashMC.txt1.text = data.Label;				
			}else{
				cashMC._visible = false;
				weaponMC._visible = true;
				weaponMC.txt1.text = data.Label;
				weaponMC.txt2.text = data.ItemInfo;
			}
		}else if (data.Index == "5") {
			charBg._visible = true;
			charTxt.text = data.Label;
			weaponMC._visible = true;
			weaponMC.txt1.text = data.Label;		
		}
		if (data.Rank == "0000" || data.Rank == "" || data.Rank == undefined) {
			RankTg._visible = false;
			if(mcLoader.loadClip(imgPathImageSet,RankTg)){
				mcLoader.unloadClip(RankTg);
			}
		} else {
			_Rank = data.Rank;
			RankTg._visible = true;
			lvLoader("00");			
		}
	}
	private function lvLoader(n:String){
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		var imgPathArmor:String ="img://Imgset_Armor."+_ImageURL;		
		var imgPathWeapon:String;
		var imgPathCashItem:String;	
		var itemName:String =_ImageURL;
		
		var mark:String = itemName.slice(-4, -1);
		var markNum:Number = Number(itemName.slice(-1));
		if (mark == "_mk" && !isNaN(markNum))
		{
			itemName = itemName.slice(0, -4);
			markMC.gotoAndStop(markNum);
		}
		else
		{
			markMC.gotoAndStop(1);
		}
		
		var chk:String = itemName.substr(-4);	
		if(chk=="_ani"){
			imgPathWeapon="Weapon_Ani/"+itemName+".swf";
			imgPathCashItem="CashItem_Ani/"+itemName+".swf";
		}else{
			imgPathWeapon="img://Imgset_Weapon."+itemName;
			imgPathCashItem="img://Imgset_CashItem."+itemName;
		}		
		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,tgMC);			
		}else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,tgMC);
		}else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,tgMC);
		}else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,tgMC);
		}else if (n == "00"){
			mcLoader.loadClip(imgPathImageSet,RankTg);
		}
	}
	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "RankTg") {
			var lvNo:String = _Rank;
			var KD:String = lvNo.charAt(0);
			var LV:String = lvNo.charAt(1);
			var chkCl:String = lvNo.substr(2, 3);
			var CL:String;
			if (chkCl.charAt(0) == "0") {
				CL = chkCl.charAt(1);
			} else {
				CL = chkCl;
			}
			var rIndex1:Number;
			var rIndex2:Number;
			rIndex1 = Number(CL)+1;
			rIndex2 = Number(LV)+1;
			RankTg.lv0.gotoAndStop(rIndex1);
			RankTg.lv1.gotoAndStop(rIndex2);			
		}else if (mc._name == "tgMC") {
			if(data.Index=="0"){
				mc._x=-32;
				mc._y=-6;
			}else if(data.Index=="1"){
				mc._x=-24;
				mc._y=-9;
			}else if (data.Index=="2"){
				tgMC.gotoAndStop(_ImageURL);
				tgMC.img.gotoAndStop(3);
				mc._x=46;
				mc._y=8;
			}else if (data.Index=="3"){
				mc._x=39;
				mc._y=-2;
			}	
		}
	}

	private function updateAfterStateChange():Void {		
		if (!initialized) {
			return;
		}		
		RankTg._visible = false;		
		weaponMC._visible = false;
		armorMC._visible = false;				
		cashMC._visible = false;
		//인덱스 data.Index
		//이름 data.Label
		//설명 data.ItemInfo
		//럭키포인트 data.Special
		//방어포인트 data.Armor
		//계급 data.Rank
		//아이템실제이름 data.ImageURL
		weaponMC.txt2.text=""
		armorMC.txt2.text=""
		
		_ImageURL = data.ImageURL;
		//장비, 무기, 부대, 캐시
		if (data.Index == "0") {
			lvLoader("0");
			armorMC._visible = true;
			armorMC.txt1.text = data.Label;
			armorMC.txt2.text = data.ItemInfo;			
			
		}else if (data.Index == "1") {
			lvLoader("1");
			weaponMC._visible = true;
			weaponMC.txt1.text = data.Label;
			weaponMC.txt2.text = data.ItemInfo;
		}else if (data.Index == "2") {
			lvLoader("2");
			weaponMC._visible = true;
			weaponMC.txt1.text = data.Label;
			weaponMC.txt2.text = data.ItemInfo;
		}else if (data.Index == "3") {
			lvLoader("3");
			if(data.IconName!=""){
				cashMC._visible = true;
				cashMC.iconMC.gotoAndStop(data.IconName);
				cashMC.txt1.text = data.Label;				
			}else{
				cashMC._visible = false;
				weaponMC._visible = true;
				weaponMC.txt1.text = data.Label;
				weaponMC.txt2.text = data.ItemInfo;
			}
		}			
		if (data.Rank == "0000" || data.Rank == "" || data.Rank == undefined) {
			RankTg._visible = false;
			if(mcLoader.loadClip(imgPathImageSet,RankTg)){
				mcLoader.unloadClip(RankTg);
			}
		} else {
			_Rank = data.Rank;
			RankTg._visible = true;
			lvLoader("00");			
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
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}

	public function draw() {
		super.draw();
	}

}