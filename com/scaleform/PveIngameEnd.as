/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveIngameEnd extends Panel
{
	public var wave:MovieClip;
	public var time:MovieClip;
	public var score:MovieClip;
	public var clear:MovieClip;
	
	private var num0:Number = 0;
	private var num1:Number = 0;
	private var num2:Number = 0;
	private var num3:Number = 0;
	private var num4:Number = 0;
	private var num5:Number = 0;
	
	private var targetNum0:Number;
	private var targetNum1:Number;
	private var targetNum2:Number;
	private var targetNum3:Number;
	private var targetNum4:Number;
	private var targetNum5:Number;
	
	private var intervalId0:Number;
	private var intervalId1:Number;
	private var intervalId2:Number;
	private var intervalId3:Number;
	private var intervalId4:Number;
	private var intervalId5:Number;
	
	private var scorePosArr:Array = [342, 303, 264, 225, 186, 146];
	private var clearPosArr:Array = [{x:59, y:0}, {x:0, y:83}, {x:339, y:79}];
	
    public function PveIngameEnd()
    {         
        super();  
    }
	
	public function show(wave:Number, totalWave:Number, time:String, score:Number, clear:Boolean):Void
	{
		init();
		this.wave.waveTxt.text = wave.toString();
		this.wave.totalWaveTxt.text = totalWave.toString();
		this.time.timeTxt.text = time.toString();
		
		setScore(score);
		if (clear)
		{
			var point:Object = clearPosArr[Tool.randRange(0, 2)];
			this.clear.clearMC._x = point.x;
			this.clear.clearMC._y = point.y;
			this.clear.clearMC.gotoAndPlay("show");
		}
		gotoAndPlay("show");
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		init();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	public function init():Void
	{
		this.wave.waveTxt.text = "";
		this.wave.totalWaveTxt.text = "";
		this.time.timeTxt.text = "";
		
		clear.clearMC.gotoAndPlay(1);
		
		for (var i:Number=0; i<scorePosArr.length; i++)
		{
			score.scoreMC["scoreTxt"+i].text = "";
			score.scoreMC["scoreTxt"+i]._x = scorePosArr[5];
			clearInterval(this["intervalId"+i]);
		}
	}
	
	private function onCloseEnd():Void
	{
		init();
	}
	
	private function setScore(value:Number):Void
	{
		var numStr:String = value.toString();
		var numArr:Array = numStr.split("");
		numArr.reverse();
		
		for (var i:Number=0; i<scorePosArr.length; i++)
		{
			score.scoreMC["scoreTxt"+i]._x = scorePosArr[i+(scorePosArr.length-numArr.length)];
		}
		
		score.scoreMC._x = (score.bg._width - score.scoreMC._width >> 1) - 14;
		for (var j:Number=0; j<numArr.length; j++)
		{
			this["num"+j] = 0;
			this["targetNum"+j] = Number(numArr[j]) + ((j*10)+10);
			this["intervalId"+j] = setInterval(this, "setScoreInterval", 40, [j]);
		}
	}
	
	private function setScoreInterval(index:Number):Void
	{
		score.scoreMC["scoreTxt"+index].text = (this["num"+index]%10).toString();
		if (this["num"+index] == this["targetNum"+index]) { clearInterval(this["intervalId"+index]); }
		this["num"+index]++;
	}
}