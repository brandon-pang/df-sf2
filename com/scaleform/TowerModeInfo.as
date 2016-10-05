/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.TowerModeInfo extends Panel
{
	
	public var modeInfoCont:MovieClip;
	
	private var _captured:Boolean = false;
	
    public function TowerModeInfo()
    {         
        super();
        
        modeInfoCont.codenameTxt.noTranslate = true;
        modeInfoCont.waitTime.waitTimeTxt.noTranslate = true;
        
        modeInfoCont.waitTime.waitTimeTitle.autoSize = true;
        
        modeInfoCont.codenameTxt.verticalAlign = "center";
        modeInfoCont.waitTime.waitTimeTxt.verticalAlign = "center";
        modeInfoCont.waitTime.waitTimeTitle.verticalAlign = "center";
        modeInfoCont.captureStart.startMC.startTxt.verticalAlign = "center";
        
        modeInfoCont.codenameTxt.textAutoSize = "shrink";
        modeInfoCont.waitTime.waitTimeTxt.textAutoSize = "shrink";
        modeInfoCont.waitTime.waitTimeTitle.textAutoSize = "shrink";
        modeInfoCont.captureStart.startMC.startTxt.textAutoSize = "shrink";
        
        modeInfoCont.waitTime.waitTimeTitle.text = "_tower_wait_time";
        modeInfoCont.captureStart.startMC.startTxt.text = "_tower_capture_start";
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
		
		modeInfoCont.waitTime.waitTimeTitle._x = 96 - Math.round(modeInfoCont.waitTime.waitTimeTitle._width) >> 1;
		modeInfoCont.waitTime.waitTimeTxt._x = modeInfoCont.waitTime.waitTimeTitle._x +  Math.round(modeInfoCont.waitTime.waitTimeTitle._width) + 4;
		
		modeInfoCont.waitTime._visible = false;
		
		modeInfoCont.teamCaptureDummy._visible = true;
		modeInfoCont.teamCaptureRed._visible = false;
		modeInfoCont.teamCaptureBlue._visible = false;
		modeInfoCont.bg.gotoAndStop(1);
	}
	
	public function setWaitTime(teamColor:Number, time:Number, total:Number):Void
	{
		if (time < 0 || time > total) { return; }
		
		_captured = false;
		modeInfoCont.teamCaptureDummy._visible = false;
		modeInfoCont.codenameTxt.text = "";
		modeInfoCont.waitTime._visible = true;
		modeInfoCont.captureStart.gotoAndStop(1);
		
		if (teamColor == 0)
		{
			modeInfoCont.teamCaptureRed._visible = true;
			modeInfoCont.teamCaptureBlue._visible = false;
			modeInfoCont.teamCaptureRed.gotoAndStop(1);
		}
		else if (teamColor == 1)
		{
			modeInfoCont.teamCaptureRed._visible = false;
			modeInfoCont.teamCaptureBlue._visible = true;
			modeInfoCont.teamCaptureBlue.gotoAndStop(1);
		}
		modeInfoCont.enemyCapture.gotoAndStop(1);
		
		if (time > 10) { modeInfoCont.waitTime.waitTimeTxt.textColor = 0xffffff; }
		else { modeInfoCont.waitTime.waitTimeTxt.textColor = 0xc50909; }
		
		var per:Number = time / total * 100;
		if (per >= 70) { modeInfoCont.waitTime.barMC.gotoAndStop(1); }
		else if (per < 70 && per >= 30) { modeInfoCont.waitTime.barMC.gotoAndStop(2); }
		else if (per < 30) { modeInfoCont.waitTime.barMC.gotoAndStop(3); }
		modeInfoCont.waitTime.barMC._xscale = per;
		
		var min:String = Math.floor(time / 60).toString();
		var sec:Number = time % 60;
		var secStr:String = sec.toString();
		if (sec < 10) { secStr = "0" + sec; }
		var t:String = min + " : " + secStr;
		modeInfoCont.waitTime.waitTimeTxt.text = t;
		
		if (time == 0)
		{
			modeInfoCont.waitTime._visible = false;
			modeInfoCont.captureStart.gotoAndPlay("show");
		}
	}
	
	public function setCapture(teamColor:Number, captured:Boolean, codename:String):Void
	{
		modeInfoCont.teamCaptureDummy._visible = false;
		modeInfoCont.waitTime._visible = false;
		modeInfoCont.captureStart.gotoAndStop(1);
		if (captured)
		{
			if (teamColor == 0)
			{
				modeInfoCont.teamCaptureRed._visible = true;
				modeInfoCont.teamCaptureBlue._visible = false;
				modeInfoCont.teamCaptureRed.gotoAndPlay("captured");
				modeInfoCont.bg.gotoAndStop(2);
			}
			else if (teamColor == 1)
			{
				modeInfoCont.teamCaptureRed._visible = false;
				modeInfoCont.teamCaptureBlue._visible = true;
				modeInfoCont.teamCaptureBlue.gotoAndPlay("captured");
				modeInfoCont.bg.gotoAndStop(3);
			}
			
			if (_captured) { modeInfoCont.enemyCapture.gotoAndPlay("uncaptured"); }
			else { modeInfoCont.enemyCapture.gotoAndStop(1); }
		}
		else
		{
			modeInfoCont.enemyCapture.gotoAndPlay("captured");
			modeInfoCont.bg.gotoAndStop(1);
			if (teamColor == 0)
			{
				modeInfoCont.teamCaptureRed._visible = true;
				modeInfoCont.teamCaptureBlue._visible = false;
				if (_captured) { modeInfoCont.teamCaptureRed.gotoAndPlay("uncaptured"); }
				else { modeInfoCont.teamCaptureRed.gotoAndStop(1); }
			}
			else if (teamColor == 1)
			{
				modeInfoCont.teamCaptureRed._visible = false;
				modeInfoCont.teamCaptureBlue._visible = true;
				if (_captured) { modeInfoCont.teamCaptureBlue.gotoAndPlay("uncaptured"); }
				else { modeInfoCont.teamCaptureBlue.gotoAndStop(1); }
			}
		}
		
		modeInfoCont.codenameTxt.text = codename;
		
		_captured = true;
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
		_captured = false;
		
		modeInfoCont.teamCaptureDummy._visible = true;
		modeInfoCont.teamCaptureRed._visible = false;
		modeInfoCont.teamCaptureBlue._visible = false;
		
		modeInfoCont.waitTime._visible = false;
		modeInfoCont.codenameTxt.text = "";
		
		modeInfoCont.captureStart.gotoAndStop(1);
	}
}