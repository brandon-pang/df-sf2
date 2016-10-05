/**
 * ...
 * @author 
 */
import com.scaleform.udk.views.View;
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.sf2.lobby.RecomItem.RecomItemPopCont;


class com.scaleform.sf2.lobby.RecomItem.RecomItemPopView extends View
{
	public static var viewName:String = "RecomItemPopView";
	public var container:RecomItemPopCont;
	
	public function RecomItemPopView()
	{
		super(); 
        trace(viewName + " initialized.");
	}
	
	public function RecomPopUp_Open() {
		container.RecomPopUp_Open();
	}
	public function RecomPopUp_Close() {
		container.RecomPopUp_Close();
	}
	public function RecomPopUp_SetCase(caseBy:String, context:String) {
		container.RecomPopUp_SetCase(caseBy, context);
	}
	
    private function configUI():Void {
    	super.configUI(); 
	}	
}