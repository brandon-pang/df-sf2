/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ManHuntModeInfo extends Panel
{
	public var score:MovieClip;
	public var enemyScore:MovieClip;
	public var typeBg:MovieClip;
	
    public function ManHuntModeInfo()
    {         
        super();
		score.scoreTxt.textField.verticalAlign = "center";
		enemyScore.enemyScoreTxt.textField.verticalAlign = "center";
		score.scoreTxt.textField.textAutoSize = "shrink";
		enemyScore.enemyScoreTxt.textField.textAutoSize = "shrink";
		score.scoreTxt.textField.noTranslate = true;
		enemyScore.enemyScoreTxt.textField.noTranslate = true;
    }
	
	public function show(type:Number):Void
	{
		if (type == 0) { typeBg.gotoAndStop(1); }
		else if (type == 1) { typeBg.gotoAndStop(2); }
		else { typeBg.gotoAndStop(1); }
		gotoAndPlay("show");
		_parent.hunt_Linetop.gotoAndPlay("open");
	}
	
	public function setScore(value:Number):Void
	{
		score.scoreTxt.textField.text = value.toString();
		score.gotoAndPlay("show");
	}
	
	public function setEnemyScore(value:Number):Void
	{
		enemyScore.enemyScoreTxt.textField.text = value.toString();
		enemyScore.gotoAndPlay("show");
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
		_parent.hunt_Linetop.gotoAndPlay(1);
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		score.scoreTxt.textField.text = "";
		enemyScore.enemyScoreTxt.textField.text = "";
	}
}