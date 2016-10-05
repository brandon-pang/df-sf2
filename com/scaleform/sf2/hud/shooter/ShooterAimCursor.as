/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterAimCursor extends Panel
{
	
	public var aimCursorCont:MovieClip;
	
    public function ShooterAimCursor()
    {         
        super();
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function requestAimCursor():Void
	{
		ExternalInterface.call("shooter_OnAimCursor", aimCursorCont.cursor);
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
	
}