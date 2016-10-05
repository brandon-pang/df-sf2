/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogListContentsAttendance extends UIComponent
{
	public var attendanceBtn:Button;
	public var attendanceTxt:TextField;
	
	public function EventDialogListContentsAttendance()
	{         
		super();
	}
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	attendanceTxt.text = "_eventSystem_attendance";
    	
    	attendanceBtn.addEventListener("click", this, "onAttendanceBtnClick");
	}
	
	private function onAttendanceBtnClick():Void
	{
		ExternalInterface.call("eventDialog_OnAttendanceBtnClick");
	}
	
	
}