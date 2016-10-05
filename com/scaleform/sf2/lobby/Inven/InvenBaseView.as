/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.Inven.InvenBaseCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.sf2.lobby.Inven.InvenBaseView extends View
{
	public static var viewName:String = "InvenBaseView";
	public var container:InvenBaseCont;
	
	public function InvenBaseView()
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
        container.invenWnd.SetMainTab($data)
    }
//==============
//End
//==============

//================================================
// 아이템 구매탭 세팅
//================================================
    public function setWeaponClickItemProvider(obj:Object) {
       container.invenWnd.setWeaponClickItemProvider(obj)
    }
    public function setChrItemProvider(obj:Object) {
       container.invenWnd.setChrItemProvider(obj)
    }
    public function setCashClickItemProvider(obj:Object) {
       container.invenWnd.setCashClickItemProvider(obj)
    }
    public function setModeClickItemProvider(obj:Object) {
       container.invenWnd.setModeClickItemProvider(obj)
    }
    public function setHotNewItemProvider(obj:Object) {
       container.invenWnd.setHotNewItemProvider(obj)
    }
//===============================================
// END
//===============================================
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_clanRank_base");
		//ScrollWheelManager.registerList(container.invenWnd.maskMc, "invenWnd");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_clanRank_base");
		//ScrollWheelManager.unregisterNameTag("invenWnd");
	}

	 private function configUI():Void {
    	super.configUI();  
    	//this._visible = false;
    	//container.addEventListener("openEnd", this, "onOpenEndContainer");
    	//container.addEventListener("closeEnd", this, "onCloseEndContainer");   

        openInit()
	}
	
}