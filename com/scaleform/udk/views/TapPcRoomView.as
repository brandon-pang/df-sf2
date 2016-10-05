/**
 * ...
 * @author 
 */
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.udk.views.TapPcRoomCon;
import com.scaleform.udk.views.View;

class com.scaleform.udk.views.TapPcRoomView extends View {
	public static var viewName : String = "TapPcRoomView";
	public var container : TapPcRoomCon;

	public function TapPcRoomView() {
		super(); 
		
		trace (viewName + " initialized.");
	} 

	//top
	public function SetTapPcRoomTopTitle($title:String, $id:String):Void{
		container.SetTapPcRoomTopTitle($title, $id);
	}
	//mid
	public function SetUserNameNContent($class:String,
								        $name:String,
										$content:String){
		container.SetUserNameNContent($class,$name,$content);
	}
	//bottom

	private function configUI() : Void {
		super.configUI();  
	}    	
}