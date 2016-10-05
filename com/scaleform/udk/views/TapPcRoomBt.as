/**
 * ...
 * @author 
 */
import gfx.core.UIComponent;
import com.scaleform.udk.utils.ScrollWheelManager;
import gfx.controls.ScrollingList;

class com.scaleform.udk.views.TapPcRoomBt extends UIComponent 
{
	public var txt_no : TextField;
	public var txt_codename : TextField;
	public var txt_clanname : TextField;
	public var txt_point : TextField;
	public var List_TapPcRoom : ScrollingList;

	public function TapPcRoomBt() {         
		super();  
	}
	
	private function configUI() : Void {
		super.configUI();

		txt_no.verticalAlign       = "center";
		txt_no.textAutoSize        = "shrink";
		txt_codename.verticalAlign = "center";
		txt_codename.textAutoSize  = "shrink";		
		txt_clanname.verticalAlign = "center";
		txt_clanname.textAutoSize  = "shrink";
		txt_point.verticalAlign    = "center";
		txt_point.textAutoSize     = "shrink";
		
		txt_no.text       = "_tapPcRoom_no";
		txt_codename.text = "_tapPcRoom_codename";
		txt_clanname.text = "_tapPcRoom_clanname";
		txt_point.text    = "_tapPcRoom_clanpoint";

        
	}
}