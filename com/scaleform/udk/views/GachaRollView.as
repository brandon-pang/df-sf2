/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.udk.views.GachaRollContainer;

class com.scaleform.udk.views.GachaRollView extends View
{
	public static var viewName:String = "GachaRollView";
	public var container:GachaRollContainer;
	
	public function GachaRollView()
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
		if (_root.designMode)
    	{
			rollTxtInit();
		}
    }    
    
	public function rollTxtInit()
	{
		container.rollTxtInit();
	}
	public function setRollTxt(value:String):Void
    {
    	if (value == null || value=="") { return; }
    	container.setRollTxt(value);
    }
	
    private function configUI():Void {
    	super.configUI();
    	
    	this._visible = false
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_gacha_roll");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_gacha_roll");
	}
	
}