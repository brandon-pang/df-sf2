/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorModeInfo extends Panel
{
	
	public var modeInfoCont:MovieClip;
	
	private var _teamColor:String = "";
	private var _enemyColor:String = "";
	
	private var _opened:Boolean = false;
	private var leftBarStatus:Boolean = false;
	private var leftCreepStatus_red:Boolean = false;
	private var leftCreepStatus_blue:Boolean = false;
	
	private var rightBarStatus:Boolean = false;
	private var rightCreepStatus_gray:Boolean = false;
	
	private var leftMaskScale:Number = 100;
	private var rightMaskScale:Number = 100;
	
	
	
    public function WarriorModeInfo()
    {         
        super();
        
        modeInfoCont.leftTxt.noTranslate = true;
        modeInfoCont.rightTxt.noTranslate = true;
		modeInfoCont.leftTxt.verticalAlign = "center";
		modeInfoCont.rightTxt.verticalAlign = "center";
    }
	
	public function show():Void
	{
		modeInfoCont.leftMask._xscale = 0;
		modeInfoCont.rightMask._xscale = 0;
		modeInfoCont.leftTxt._alpha = 0;
		modeInfoCont.rightTxt._alpha = 0;
		gotoAndPlay("show");
	}
	
	public function setTeamColor(teamColor:Number):Void
	{
		if (teamColor == 0)
		{
			_teamColor = "red";
			_enemyColor = "blue";
			
			modeInfoCont.leftBar.red._visible = true;
			modeInfoCont.leftBar.blue._visible = false;
			modeInfoCont.rightBar.red._visible = false;
			modeInfoCont.rightBar.blue._visible = true;
			modeInfoCont.leftCreep.red._visible = true;
			modeInfoCont.leftCreep.blue._visible = false;
		}
		else if (teamColor == 1)
		{
			_teamColor = "blue";
			_enemyColor = "red";
			
			modeInfoCont.leftBar.red._visible = false;
			modeInfoCont.leftBar.blue._visible = true;
			modeInfoCont.rightBar.red._visible = true;
			modeInfoCont.rightBar.blue._visible = false;
			modeInfoCont.leftCreep.red._visible = false;
			modeInfoCont.leftCreep.blue._visible = true;
		}
	}
	
	public function setTime(time:String, status:Number):Void
	{
		if (status == 0)
		{
			modeInfoCont.timeTxt.textColor = 0xffffff;
		}
		else if (status == 1)
		{
			modeInfoCont.timeTxt.textColor = 0xde0000;
		}
		
		modeInfoCont.timeTxt.text = time;
	}
	
	public function setTeamCreepHp(hp:Number, total:Number):Void
	{
		var target:Number = hp / total * 100;
		if (target > 10)
		{
			modeInfoCont.leftBar[_teamColor].gotoAndStop(1);
			modeInfoCont.leftTxt.textColor = 0xffffff;
		}
		else
		{
			modeInfoCont.leftBar[_teamColor].gotoAndStop(2);
			modeInfoCont.leftTxt.textColor = 0xde0000;
		}
		if (!leftBarStatus)
		{
			modeInfoCont.leftBar.gotoAndPlay("show");
			leftBarStatus = true;
		}
		if (!this["leftCreepStatus_"+_teamColor])
		{
			modeInfoCont.leftCreep[_teamColor].gotoAndPlay("show");
			this["leftCreepStatus_"+_teamColor] = true;
		}
		//modeInfoCont.leftTxt.text = hp + "/" + total;
		leftMaskScale = target;
		if (_opened) { modeInfoCont.leftMask._xscale = target; }
	}
	
	public function setEnemyCreepHp(hp:Number, total:Number):Void
	{
		var target:Number = hp / total * 100;
		if (target > 10)
		{
			modeInfoCont.rightBar.gray.gotoAndStop(1);
			modeInfoCont.rightTxt.textColor = 0xffffff;
		}
		else
		{
			modeInfoCont.rightBar.gray.gotoAndStop(2);
			modeInfoCont.rightTxt.textColor = 0xde0000;
		}
		if (!rightBarStatus)
		{
			modeInfoCont.rightBar.gotoAndPlay("show");
			rightBarStatus = true;
		}
		if (!rightCreepStatus_gray)
		{
			modeInfoCont.rightCreep.gray.gotoAndPlay("show");
			rightCreepStatus_gray = true;
		}
		//modeInfoCont.rightTxt.text = hp + "/" + total;
		rightMaskScale = target;
		if (_opened) { modeInfoCont.rightMask._xscale = target; }
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("openEnd", this, "onOpenEnd");
		this.addEventListener("closeEnd", this, "onCloseEnd");
		
		modeInfoCont.leftBar.addEventListener("closeEnd", this, "onLeftBarCloseEnd");
		modeInfoCont.rightBar.addEventListener("closeEnd", this, "onRightBarCloseEnd");
		modeInfoCont.leftCreep.red.addEventListener("closeEnd", this, "onLeftCreepRedCloseEnd");
		modeInfoCont.leftCreep.blue.addEventListener("closeEnd", this, "onLeftCreepBlueCloseEnd");
		modeInfoCont.rightCreep.gray.addEventListener("closeEnd", this, "onRightCreepGrayCloseEnd");
	}
	
	private function onOpenEnd():Void
	{
		_opened = true;
		TweenMax.to(modeInfoCont.leftMask, 0.8, {_xscale:leftMaskScale, ease:Cubic.easeOut});
		TweenMax.to(modeInfoCont.rightMask, 0.8, {_xscale:rightMaskScale, ease:Cubic.easeOut});
		TweenMax.to(modeInfoCont.leftTxt, 0.6, {delay:0.6, _alpha:100, ease:Cubic.easeOut});
		TweenMax.to(modeInfoCont.rightTxt, 0.6, {delay:0.6, _alpha:100, ease:Cubic.easeOut});
	}
	
	private function onCloseEnd():Void
	{
		modeInfoCont.leftMask._xscale = 0;
		modeInfoCont.rightMask._xscale = 0;
        modeInfoCont.leftTxt._alpha = 0;
		modeInfoCont.rightTxt._alpha = 0;
        _teamColor = "";
        _enemyColor = "";
        _opened = false;
        leftBarStatus = false;
		leftCreepStatus_red = false;
		leftCreepStatus_blue = false;
		rightBarStatus = false;
		rightCreepStatus_gray = false;
        leftMaskScale = 100;
		rightMaskScale = 100;
        TweenMax.killTweensOf(modeInfoCont.leftMask);
        TweenMax.killTweensOf(modeInfoCont.rightMask);
	}
	
	private function onLeftBarCloseEnd():Void
	{
		leftBarStatus = false;
	}
	
	private function onRightBarCloseEnd():Void
	{
		rightBarStatus = false;
	}
	
	private function onLeftCreepRedCloseEnd():Void
	{
		leftCreepStatus_red = false;
	}
	
	private function onLeftCreepBlueCloseEnd():Void
	{
		leftCreepStatus_blue = false;
	}
	
	private function onRightCreepGrayCloseEnd():Void
	{
		rightCreepStatus_gray = false;
	}
	
	
}