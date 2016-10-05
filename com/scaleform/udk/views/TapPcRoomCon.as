/**
 * ...
 * @author 
 */
import gfx.core.UIComponent;
import com.scaleform.udk.views.TapPcRoomTop;
import com.scaleform.udk.views.TapPcRoomMid;
import com.scaleform.udk.views.TapPcRoomBt;

class com.scaleform.udk.views.TapPcRoomCon extends UIComponent {    
	public var pcRoomRankTop:TapPcRoomTop;
	public var pcRoomRankMid:TapPcRoomMid;
	public var pcRoomRankBt:TapPcRoomBt;

	public function TapPcRoomCon() { 
		super();  
	}    

	//top
	public function SetTapPcRoomTopTitle($title : String, $id : String):Void {
		pcRoomRankTop.SetTapPcRoomTopTitle($title, $id);
	}
	
	//
	public function SetUserNameNContent($class:String,
								        $name:String,
										$content:String){
		pcRoomRankMid.SetUserNameNContent($class,$name,$content);
	}

	private function configUI() : Void {
		super.configUI();

	
	}
}