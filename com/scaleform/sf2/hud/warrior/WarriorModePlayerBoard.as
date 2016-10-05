/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorModePlayerBoard extends Panel
{
	
	public var playerBoardCont:MovieClip;
	
	private var _offense:Number;
	private var _defence:Number;
	private var _movement:Number;
	private var _level:Number;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	
    public function WarriorModePlayerBoard()
    {         
        super();
        mcLoader = new MovieClipLoader();
		playerBoardCont.expTxt.verticalAlign = "center";
		playerBoardCont.expTxt.text = "_exp_text";
		
		playerBoardCont.levelTxt.noTranslate = true;
		playerBoardCont.levelTxt.verticalAlign = "center";
		playerBoardCont.levelTxt.textAutoSize = "shrink";
		playerBoardCont.offenseTxt.noTranslate = true;
		playerBoardCont.offenseTxt.verticalAlign = "center";
		playerBoardCont.offenseTxt.textAutoSize = "shrink";
		playerBoardCont.defenceTxt.noTranslate = true;
		playerBoardCont.defenceTxt.verticalAlign = "center";
		playerBoardCont.defenceTxt.textAutoSize = "shrink";
		playerBoardCont.movementTxt.noTranslate = true;
		playerBoardCont.movementTxt.verticalAlign = "center";
		playerBoardCont.movementTxt.textAutoSize = "shrink";
		
		playerBoardCont.expBar._xscale = 0;
		//playerBoardCont.offenseBar._xscale = 0;
		//playerBoardCont.defenceBar._xscale = 0;
		//playerBoardCont.movementBar._xscale = 0;
		
		playerBoardCont.shortcut.textField.noTranslate = true;
        
        playerBoardCont.returnTxt.autoSize = "right";
        playerBoardCont.returnTxt.text = "_hero_return";
       
        playerBoardCont.returnBg._x = playerBoardCont.returnTxt._x - 4;
        playerBoardCont.returnBg._width = playerBoardCont.returnTxt._width + 8;
        playerBoardCont.shortcut._x = playerBoardCont.returnTxt._x - 25;
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setTeamColor(teamColor:Number):Void
	{
		if (teamColor == 0)
		{
			playerBoardCont.bg.gotoAndStop(1);
			playerBoardCont.levelBg.gotoAndStop(1);
		}
		else if (teamColor == 1)
		{
			playerBoardCont.bg.gotoAndStop(2);
			playerBoardCont.levelBg.gotoAndStop(2);
		}
	}
	
	public function setPlayer(imgSet:String, level:String,
								exp:Number, totalExp:Number,
								offense:Number, totalOffense:Number,
								defence:Number, totalDefence:Number,
								movement:Number, totalMovement:Number):Void
	{
		mcLoader.loadClip(_imgPathPersonal+imgSet, playerBoardCont.imgIcon);
		
		playerBoardCont.levelTxt.text =level;
		
		var newLevel:Number = Number(level.substr(3));
		if (newLevel != _level) { playerBoardCont.expBar._xscale = 0; }
		_level = newLevel;
		
		var expPer:Number = exp / totalExp * 100;
		TweenMax.to(playerBoardCont.expBar, 0.4, {_xscale:expPer, ease:Cubic.easeOut});
		
		var maxStat:Number = 0;
		if (offense > maxStat) { maxStat = offense; }
		if (defence > maxStat) { maxStat = defence; }
		if (movement > maxStat) { maxStat = movement; }
		if (offense < maxStat) { playerBoardCont.offense.txt.textField.textColor = 0xc0c0c0; }
		else { playerBoardCont.offense.txt.textField.textColor = 0xc01e1e; }
		if (defence < maxStat) { playerBoardCont.defence.txt.textField.textColor = 0xc0c0c0; }
		else { playerBoardCont.defence.txt.textField.textColor = 0x007fd4; }
		if (movement < maxStat) { playerBoardCont.movement.txt.textField.textColor = 0xc0c0c0; }
		else { playerBoardCont.movement.txt.textField.textColor = 0x4c9911; }
		
		if (_offense != offense)
		{
			playerBoardCont.offense.txt.textField.text = offense.toString();
			playerBoardCont.offense.gotoAndPlay("show");
			playerBoardCont.offenseLight.gotoAndPlay("show");
			//var offensePer:Number = offense / totalOffense * 100;
			//playerBoardCont.offenseBar._xscale = offensePer;
			_offense = offense;
		}
		
		if (_defence != defence)
		{
			playerBoardCont.defence.txt.textField.text = defence.toString();
			playerBoardCont.defence.gotoAndPlay("show");
			playerBoardCont.defenceLight.gotoAndPlay("show");
			//var defencePer:Number = defence / totalDefence * 100;
			//playerBoardCont.defenceBar._xscale = defencePer;
			_defence = defence;
		}
		
		if (_movement != movement)
		{
			playerBoardCont.movement.txt.textField.text = movement.toString();
			playerBoardCont.movement.gotoAndPlay("show");
			playerBoardCont.movementLight.gotoAndPlay("show");
			//var movementPer:Number = movement / totalMovement * 100;
			//playerBoardCont.movementBar._xscale = movementPer;
			_movement = movement;
		}
	}
	
	public function setReturnShortcut(shortcut:String):Void
	{
		playerBoardCont.shortcut.textField.text = shortcut;
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		playerBoardCont.offense.txt.textField.verticalAlign="center";
		playerBoardCont.offense.txt.textField.textAutoSize="shrink";
		playerBoardCont.defence.txt.textField.verticalAlign="center";
		playerBoardCont.defence.txt.textField.textAutoSize="shrink";
		playerBoardCont.movement.txt.textField.verticalAlign="center";
		playerBoardCont.movement.txt.textField.textAutoSize="shrink";

		
	}
	
	
}