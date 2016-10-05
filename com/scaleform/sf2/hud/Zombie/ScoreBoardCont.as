/**
 * ...
 * @author 
 */

import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.sf2.hud.Zombie.ScoreBoardCont extends UIComponent
{
	public var txtRoomNo:TextField;
	public var txtMapName:TextField;
	public var txtTitle1:TextField;
	public var txtTitle2:TextField;
	public var txtTitle3:TextField;
	public var txtTitle4:TextField;
	public var txtTitle5:TextField;
	public var lockIcon:MovieClip;
	public var txt_kill:TextField;
	public var list:ScrollingList;
	
    public function ScoreBoardCont()
    {         
        super();  
    }
	
	public function initCont():Void
	{
		
	}
	
	public function setTitle(_info:String, 
							_map:String, 
							_lock:Boolean, 
							_t1:Boolean, 
							_t2:Boolean, 
							_t3:Boolean, 
							_t4:Boolean, 
							_t5:Boolean,
							_shooterMode):Void
	{
		txtRoomNo.text = _info;
		txtMapName.text = _map;
	
		if (_lock) {
			lockIcon._visible = true;
		} else {
			lockIcon._visible = false;
		}
	
		if (_t1) {
			txtTitle1.textColor = 0x989191;
		} else {
			txtTitle1.textColor = 0x404040;
		}
		if (_t2) {
			txtTitle2.textColor = 0x989191;
		} else {
			txtTitle2.textColor = 0x404040;
		}
		if (_t3) {
			txtTitle3.textColor = 0x989191;
		} else {
			txtTitle3.textColor = 0x404040;
		}
		if (_t4) {
			txtTitle4.textColor = 0x989191;
		} else {
			txtTitle4.textColor = 0x404040;
		}
		if (_t5) {
			txtTitle5.textColor = 0x989191;
		} else {
			txtTitle5.textColor = 0x404040;
		}
		txt_kill.text = "_zombie_result_killset";
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		txtRoomNo.noTranslate = true;
		
		txtTitle1.text = "_hudScoreBoarding";
		txtTitle2.text = "_hudScore3Watching";
		txtTitle3.text = "_hudScoreConversion";
		txtTitle4.text = "_hudScoreFlashBack";
		txtTitle5.text = "_hudScoreTeamBalance";
	}	
}