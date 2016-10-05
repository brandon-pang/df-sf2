/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.TowerCountDown extends Panel
{
	
	public var countDownCont:MovieClip;
	
	private var progressed:Boolean = false;
	private var _changeGauge:Number = 0;
	private var _level:Number = 0;
	private var _opened:Boolean = false;
	
    public function TowerCountDown()
    {         
        super();
        
        countDownCont.countTxt0.html = true;
        countDownCont.countTxt0.noTranslate = true;
		countDownCont.countTxt0.verticalAlign = "center";
		countDownCont.countTxt0_d.html = true;
        countDownCont.countTxt0_d.noTranslate = true;
		countDownCont.countTxt0_d.verticalAlign = "center";
		countDownCont.countTxt1.html = true;
        countDownCont.countTxt1.noTranslate = true;
		countDownCont.countTxt1.verticalAlign = "center";
		countDownCont.countTxt1_d.html = true;
        countDownCont.countTxt1_d.noTranslate = true;
		countDownCont.countTxt1_d.verticalAlign = "center";

		countDownCont.countTxt0.textAutoSize = "shrink";
		countDownCont.countTxt0_d.textAutoSize = "shrink";
		countDownCont.countTxt1.textAutoSize = "shrink";
		countDownCont.countTxt1_d.textAutoSize = "shrink";
    }
	
	public function show():Void
	{
		_opened = false;
		gotoAndPlay("show");
	}
	
	public function setCount(teamColor:Number, count:Number, total:Number, level:Number):Void
	{
		if (!progressed)
		{
			countDownCont.radar._visible = true;
			progressed = true;
		}
		var rotation:Number = (count%1000)*360/1000;
		countDownCont.radar._rotation = rotation;
		
		countDownCont.countTxt0.text = "";
		countDownCont.countTxt1.text = "";
		countDownCont.countTxt0_d.text = "";
		countDownCont.countTxt1_d.text = "";
		
		countDownCont.bg.gotoAndStop(teamColor+1);
		
		var gap:Number = total - count;
		if (gap >= 10000)
		{
			countDownCont["countTxt"+teamColor].htmlText = "<font size='30'>" + Math.floor(gap/1000) + "</font>";
		}
		else if (gap <= 10000 && gap > 0)
		{
			var t:String = (Math.floor(gap/10)/100).toString();
			if (t.length == 3) { t = t + "0"; }
			else if (t.length == 1) { t = t + ".00"; }
			countDownCont["countTxt"+teamColor+"_d"].htmlText = "<font size='30'>" + t.substr(0, 1) + ".</font>" + "<font size='12'>" + t.substr(-2); + "</font>";
		}
		else if (gap <= 0)
		{
			countDownCont["countTxt"+teamColor+"_d"].htmlText = "<font size='30'>0.</font>" + "<font size='12'>00</font>";
			countDownCont.radar._visible = false;
			progressed = false;
		}
		var changeGauge:Number = 13 - Math.ceil(gap/5000);
		if (changeGauge != _changeGauge)
		{
			countDownCont.gauge.gaugeMC.gotoAndStop(changeGauge);
			countDownCont.gauge.gotoAndPlay("show");
			_changeGauge = changeGauge;
		}
		
		if(level == 0) 
		{
			if (_opened && level != _level) { gotoAndStop("level0"); }
			_level = level;
		}
		else if (level == 1)
		{
			if (_opened && level != _level) { gotoAndPlay("level1"); }
			_level = level;
		}
		else if (level == 2)
		{
			if (_opened && level != _level) { gotoAndPlay("level2"); }
			_level = level;
		}
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
		
		countDownCont.radar._visible = false;
	}
	
	private function onOpenEnd():Void
	{
		_opened = true;
		if (_level == 0) { gotoAndStop("level0"); }
		else if (_level == 1) { gotoAndPlay("level1"); }
		else if (_level == 2) { gotoAndPlay("level2"); }
	}
	
	private function onCloseEnd():Void
	{
		countDownCont.countTxt0.text = "";
		countDownCont.countTxt0_D.text = "";
		countDownCont.countTxt1.text = "";
		countDownCont.countTxt1_d.text = "";
		countDownCont.radar._rotation = 0;
		countDownCont.radar._visible = false;
		progressed = false;
		_changeGauge = 0;
		countDownCont.gauge.gotoAndStop(2);
		_level = 0;
	}
}