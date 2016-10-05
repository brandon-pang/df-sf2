/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import com.scaleform.PveCreepHpBarCont;
import gfx.layout.Panel;
import com.scaleform.udk.utils.CoolDownMask

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterDashBoard extends Panel
{
	public var dashBoardCont:MovieClip;
	
	private var curMoney:Number = 0;
	private var targetMoney:Number = 0;
	private var intervalId:Number;
	private var positiveNum:Number;
	private var unitNum:Number;
	private var isChanging:Boolean = false;
	private var _offense:Number = 0;
	private var _defence:Number = 0;
	private var _movement:Number = 0;
	private var _showUse:Boolean;
	private var coolDownSpeedMask:CoolDownMask;
	private var coolDownDefenceMask:CoolDownMask;
	private var coolDownOffenseMask:CoolDownMask;
	private var txt_second:TextField;
	
    public function ShooterDashBoard()
    {         
        super();        
        dashBoardCont.money.moneyMC.textField.noTranslate = true;
        dashBoardCont.money.moneyMC.textField.text = "0";
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
		for(var i:Number=0;i<3;i++){
			var buffIconMc:MovieClip=this.attachMovie("buffIconMc","buffIconMc"+i,1+i);
			buffIconMc._y=0
			buffIconMc._x=(50*i)+12
			buffIconMc.buffDown.gotoAndStop(i+1)
		}
		setCoolDown()
	}
	
	public function initCont():Void
	{
		//curMoney = 0;
		//dashBoardCont.money.moneyMC.textField.text = "0";
		isChanging = false;
		targetMoney = 0;
		clearInterval(intervalId);
	}
	
	public function setMoney(value:Number):Void
	{
		if (value != null) { curMoney = value; }
		setMoneyTxt();
	}
	
	public function changeMoney(value:Number):Void
	{
		if (value == null || value == 0) { return; }
		if (isChanging)
		{
			clearInterval(intervalId);
			curMoney = targetMoney;
			setMoneyTxt();
		}
		targetMoney = curMoney + value;
		unitNum = Math.ceil(Math.abs(value)/12);
		positiveNum = (value > 0)?1:-1;
		if (positiveNum == 1) { 
			dashBoardCont.money.gotoAndPlay("show"); 
		}
		else { dashBoardCont.moneyIcon.gotoAndPlay("show"); }
		makeInterval();
	}
	public function setPlayerBuffSpeed($value:Number):Void{
		var v=$value;
		var rv=$value*1000;
		this["buffIconMc"+0].textField.text=String(v)+dashBoardCont.txt_second.text;
		this["buffIconMc"+0].buffOver.gotoAndStop(2);	
		coolDownSpeedMask.start(1, rv);
	}
	public function setPlayerBuffDefence($value:Number):Void{
		var v=$value;
		var rv=$value*1000;
		this["buffIconMc"+1].textField.text=v+dashBoardCont.txt_second.text
		this["buffIconMc"+1].buffOver.gotoAndStop(3);	
		coolDownDefenceMask.start(1, rv);
	}
	
	public function setPlayerBuffOffense($value:Number):Void{
		var v=$value;
		var rv=$value*1000;
		this["buffIconMc"+2].textField.text=v+dashBoardCont.txt_second.text
		this["buffIconMc"+2].buffOver.gotoAndStop(4);	
		coolDownOffenseMask.start(1, rv)
	}
	public function setCoolDown():Void
	{
		coolDownSpeedMask = new CoolDownMask(this["buffIconMc"+0].coolDown, 42, 42, true);
		coolDownSpeedMask.setMaskColor(0x00000050, 0x00000050, 0);
		coolDownSpeedMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownSpeedMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");

		coolDownDefenceMask = new CoolDownMask(this["buffIconMc"+1].coolDown, 42, 42, true);
		coolDownDefenceMask.setMaskColor(0x00000050, 0x00000050, 0);
		coolDownDefenceMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownDefenceMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");

		coolDownOffenseMask = new CoolDownMask(this["buffIconMc"+2].coolDown, 42, 42, true);
		coolDownOffenseMask.setMaskColor(0x00000050, 0x00000050, 0);
		coolDownOffenseMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownOffenseMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");
	}
	
	
	private function onCoolDownEnd(e:Object):Void
	{		
		var t=e.target._parent._parent
		t.textField.text=""
		t.buffOver.gotoAndStop(1);	
	}
	
	private function onCoolDownProgress(e:Object):Void
	{

		var time:Number = Math.round(e.remainTime/1000);
		var tMc:MovieClip=e.target._parent._parent
		tMc.textField.text=time+dashBoardCont.txt_second.text
		//trace ([e.target._name,time])
	}

	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		initCont();
	}
	
	private function setMoneyTxt():Void
	{
		if (curMoney >= 0)
		{
			dashBoardCont.money.moneyMC.textField.text = Tool.comma(curMoney);
		}
		else 
		{
			var comma:String = Tool.comma(Math.abs(curMoney));
			dashBoardCont.money.moneyMC.textField.text = "-"+comma;
		}
	}
	
	private function makeInterval():Void
	{
		isChanging = true;
		intervalId = setInterval(this, "makeIntervalCallBack", 40, targetMoney);
	}
	
	private function makeIntervalCallBack(target:Number):Void
	{
		var unit:Number = positiveNum * unitNum;
		curMoney = curMoney + unit;
		if (positiveNum == 1) { curMoney = Math.min(curMoney, target); }
		else if (positiveNum == -1) { curMoney = Math.max(curMoney, target); }
		setMoneyTxt();
		if (curMoney == target)
		{
			isChanging = false;
			clearInterval(intervalId);
		}
	}
}