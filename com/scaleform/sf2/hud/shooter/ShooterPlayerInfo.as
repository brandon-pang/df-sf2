/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterPlayerInfo extends Panel
{
	
	public var playerInfoCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	
	private var _hp:Number;
	private var _showUse:Boolean;
	private var _offense:Number = 0;
	private var _defence:Number = 0;
	private var _movement:Number = 0;
	private var HP_BAR_WIDTH:Number = 207;
	private var EXP_BAR_WIDTH:Number = 207;
	
    public function ShooterPlayerInfo()
    {         
        super();
        mcLoader = new MovieClipLoader();
        playerInfoCont.levelTxt.noTranslate = true;
		playerInfoCont.codeNameTxt.noTranslate = true;
		playerInfoCont.codeNameTxt.html = true;
		
		playerInfoCont.offenseStat.mc.textField.text = _offense;
		playerInfoCont.defenceStat.mc.textField.text = _defence;
		playerInfoCont.movementStat.mc.textField.text = _movement;
		
		playerInfoCont.hpBar._width = 0;
		playerInfoCont.expBar._width = 0;
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setPlayerInfo(imgSet:String, level:Number, codeName:String):Void
	{
		mcLoader.loadClip(_imgPathPersonal+imgSet, playerInfoCont.slot.imgIcon);
		playerInfoCont.levelTxt.text = level.toString();
		playerInfoCont.codeNameTxt.htmlText = codeName;
	}
	
	public function setPlayerHp(hp:Number, totalHp:Number):Void
	{
		var hpPer:Number = hp / totalHp * 100;
		var hpWidth:Number = hp / totalHp * HP_BAR_WIDTH;
		//playerInfoCont.hpBar._width = hpWidth;
		TweenMax.to(playerInfoCont.hpBar, 0.4, {_width:hpWidth, ease:Cubic.easeOut});
		if (hpPer <= 10 && hpPer > 0)
		{
			if (_hp > 10) { playerInfoCont.slot.danger.gotoAndPlay("show"); }
		}
		else
		{
			playerInfoCont.slot.danger.gotoAndStop(2);
		}
		_hp = hpPer;
	}
	
	public function setPlayerExp(exp:Number, totalExp:Number):Void
	{
		var expWidth:Number = exp / totalExp * EXP_BAR_WIDTH;
		TweenMax.to(playerInfoCont.expBar, 0.4, {_width:expWidth, ease:Cubic.easeOut});
	}
	
	public function setPlayerStat(offense:Number, defence:Number, movement:Number):Void
	{
		if (_offense != offense)
		{
			_offense = offense;
			playerInfoCont.offenseStat.mc.textField.text = _offense;
			playerInfoCont.offenseStat.gotoAndPlay("show");
			playerInfoCont.offenseStatEffect.gotoAndPlay("show");
		}
		if (_defence != defence)
		{
			_defence = defence;
			playerInfoCont.defenceStat.mc.textField.text = _defence;
			playerInfoCont.defenceStat.gotoAndPlay("show");
			playerInfoCont.defenceStatEffect.gotoAndPlay("show");
		}
		if (_movement != movement)
		{
			_movement = movement;
			playerInfoCont.movementStat.mc.textField.text = _movement;
			playerInfoCont.movementStat.gotoAndPlay("show");
			playerInfoCont.movementStatEffect.gotoAndPlay("show");
		}
	}
	
	public function showUseStat(showUse:Boolean, comment:String):Void
	{
		if (showUse)
		{
			if (!_showUse) { playerInfoCont.useStat.gotoAndPlay("show"); }
			playerInfoCont.useStat.textField.text = comment;
			playerInfoCont.statShort1.gotoAndStop(2);
			playerInfoCont.statShort2.gotoAndStop(2);
			playerInfoCont.statShort3.gotoAndStop(2);
		}
		else
		{
			playerInfoCont.useStat.gotoAndStop(2);
			playerInfoCont.useStat.textField.text = "";
			playerInfoCont.statShort1.gotoAndStop(1);
			playerInfoCont.statShort2.gotoAndStop(1);
			playerInfoCont.statShort3.gotoAndStop(1);
		}
		_showUse = showUse;
	}
	
	public function setPlayerRespawn(time:Number, total:Number):Void
	{
		playerInfoCont.slot.danger.gotoAndStop(2);
		if (!playerInfoCont.slot._dead)
		{
			playerInfoCont.slot._dead = true;
			playerInfoCont.slot.imgIcon._alpha = 50;
			playerInfoCont.levelTxt._alpha = 50;
			playerInfoCont.codeNameTxt._alpha = 50;
			playerInfoCont.slot.frame._alpha = 50;
		}
		
		playerInfoCont.slot.setCoolDown(time, total);
		
		if (time == total)
		{
			playerInfoCont.slot._dead = false;
			playerInfoCont.slot.imgIcon._alpha = 100;
			playerInfoCont.levelTxt._alpha = 100;
			playerInfoCont.codeNameTxt._alpha = 100;
			playerInfoCont.slot.frame._alpha = 100;
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
}