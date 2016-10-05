/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.motion.Tween;
import mx.transitions.easing.*;
import com.scaleform.udk.utils.UDKUtils;
 
class scaleform.sf2.lobby.shop.ShopTabBuysHotNNew extends UIComponent 
{
	private var _itemimg:String;
	private var _id:String;
	private var imgPathArmor:String;
	private	var imgPathWeapon:String;
	private	var imgPathCashItem:String;
	private	var imgPathUnit:String;
	private var mcLoader:MovieClipLoader;
	private var itemImg:MovieClip;
	private var hitBtn:Button;

	public function ShopTabBuysHotNNew()
	{         
		super();
	}	
	//데이타 가져오기
	public function setInit(arr)
	{
		var tArr = arr
		_itemimg = tArr.IconImg;
		_id=tArr.IconIndex	

		loaderImg(_itemimg,_id)
	}

	private function loaderImg(_imgName,_itemId)
	{			
		var imgName = _imgName;
		var len = imgName.length;
		var chk = imgName.substr(-4, len);
		var n=_itemId
		
		if (_global.gfxPlayer) {
			imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
			imgPathArmor = "gfxImgSet/Armor/"+imgName+".png";
			imgPathCashItem = "gfxImgSet/CashItem/"+imgName+".png";
			imgPathWeapon = "gfxImgSet/Weapon/"+imgName+".png";
		} else {
			imgPathUnit = "gfx_imgset_unitbox.swf";			
			imgPathArmor = UDKUtils.ArmorImgPath+imgName;
			if (chk == "_ani") {
				imgPathCashItem = UDKUtils.CashImgAniPath+imgName
				imgPathWeapon = UDKUtils.WeaponImgAniPath+imgName
			} else {
				imgPathCashItem = UDKUtils.CashImgPath+imgName
				imgPathWeapon = UDKUtils.WeaponImgPath+imgName
			}
		}
		
		itemImg._alpha=0
		itemImg._y=-12

		if (n == "0")lvLoader(imgPathArmor,itemImg)
		else if (n == "1")lvLoader(imgPathWeapon,itemImg)
		else if (n == "2")lvLoader(imgPathUnit,itemImg)
		else if (n == "3")lvLoader(imgPathCashItem,itemImg)	
	}

	private function onLoadInit(mc:MovieClip)
    {
        var imgName:String = _itemimg;
		
		Tween.init();		
		mc.tweenTo(0.5,{_alpha:100,_y:-8},Strong.easeIn);
		mc.onTweenComplete = function() {
			mc.tweenEnd();
			delete mc.onTweenComplete
		};
		
		//장비 무기 부대 캐쉬
		if (_id == "0") {
			itemImg._x = 286;			
		} else if (_id == "1") {			
			itemImg._x = 286;		
		} else if (_id == "2") {
			itemImg.gotoAndStop(imgName);
			itemImg._x = 357;			
		} else if (_id == "3") {		
			itemImg._x = 357;
		}
    }

    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(path,mc);
    }

    private function OnHitBtnHandler(){
		_global.HotNewBestItemClick()
	}
 
    private function configUI():Void
    {
    	super.configUI();
    	hitBtn.onRelease=OnHitBtnHandler;
    }
}