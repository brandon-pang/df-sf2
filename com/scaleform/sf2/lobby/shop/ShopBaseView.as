/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.shop.ShopBaseCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.shop.ShopBaseView extends View
{
	public static var viewName:String = "ShopBaseView";
	public var container:ShopBaseCont;
	
	public function ShopBaseView()
	{
		super(); 

        trace(viewName + " initialized.");
	}

	public function openInit():Void
    {
    	this._visible = true;
    	container.gotoAndPlay("open");
    }
    
    public function closeInit():Void
    {
    	container.gotoAndPlay("close");		
    }   
//================================================
// 메인 버튼바 세팅
//================================================
    public function SetMainTab($data:Array):Void{
        container.shopWnd.SetMainTab($data)
    }
//==============
//End
//==============

//================================================
// 아이템 구매탭 세팅
//================================================
    public function setWeaponClickItemProvider(obj:Object) {
       container.shopWnd.setWeaponClickItemProvider(obj)
    }
    public function setChrItemProvider(obj:Object) {
       container.shopWnd.setChrItemProvider(obj)
    }
    public function setCashClickItemProvider(obj:Object) {
       container.shopWnd.setCashClickItemProvider(obj)
    }
    public function setModeClickItemProvider(obj:Object) {
       container.shopWnd.setModeClickItemProvider(obj)
    }
    public function setHotNewItemProvider(obj:Object) {
       container.shopWnd.setHotNewItemProvider(obj)
    }
//===============================================
// END
//===============================================
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_clanRank_base");
		//ScrollWheelManager.registerList(container.shopWnd.maskMc, "shopWnd");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_clanRank_base");
		//ScrollWheelManager.unregisterNameTag("shopWnd");
	}

	 private function configUI():Void {
    	super.configUI();  
    	//this._visible = false;
    	//container.addEventListener("openEnd", this, "onOpenEndContainer");
    	//container.addEventListener("closeEnd", this, "onCloseEndContainer");   

        openInit()
	}
	
}