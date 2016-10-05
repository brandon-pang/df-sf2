/**
 * ...
 * @author 
 */

import com.scaleform.sf2.hud.Zombie.ScoreBoardCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.Zombie.ScoreBoard extends Panel
{
	public var scoreBoardCont:ScoreBoardCont;

	public function ScoreBoard()
	{
		super();
	}

	public function show():Void
	{
		gotoAndPlay("show");
	}

	public function hide():Void
	{
		gotoAndPlay("hide");
	}

	public function setTitle(_info:String, _map:String, _lock:Boolean, 
							 _t1:Boolean, _t2:Boolean, _t3:Boolean, 
							 _t4:Boolean, _t5:Boolean, _shooterMode):Void
	{
		scoreBoardCont.setTitle(_info,_map,_lock,_t1,_t2,_t3,_t4,_t5,_shooterMode);
	}

	private function configUI():Void
	{
		super.configUI();

		this.addEventListener("closeEnd",this,"onCloseEnd");
	}

	private function onCloseEnd():Void
	{

	}
}