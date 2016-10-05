/**
 * ...
 * @author 
 */
import gfx.core.UIComponent;

class com.scaleform.udk.views.TapPcRoomTop extends UIComponent {
	public var txt_title:TextField;
	public var txt_id:TextField;

	public function TapPcRoomTop() {         
		super();         
	} 

	public function SetTapPcRoomTopTitle($title:String,$id:String) {
		var t : String = $title;
		var id : String = $id;
		txt_title.htmlText = t;
		txt_id.htmlText = id;
	}

	private function configUI() : Void {
		super.configUI();
		txt_title.verticalAlign = "center";
		txt_title.textAutoSize  = "shrink";
		txt_id.verticalAlign = "bottom";
		txt_id.textAutoSize  = "shrink";		
	}
}