/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.HudMainChallengeTaskBar extends UIComponent
{
	public var emblem:MovieClip;
	public var bg:MovieClip;
	public var glowEffect:MovieClip;
	public var demandTxt:MovieClip;
	public var starMC:MovieClip;
	
	public var isUse:Boolean = false;
	public var SHOW_POSX:Number = 0;
	public var HIDE_POSX:Number = 280;
	
	private var data:Object;
	private var time:Number;
	private var intervalId:Number;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathChallenge:String = "img://Imgset_Challenge_Emblem.64.";
	private var imgSet:MovieClip;
	private var demandTxtArr:Array;
	
	private var medalFontColor:Array = [0xB2B2B2, 0xdead8d, 0xbababa, 0xffe671];
	private var starFontColor:Array = [0xd48b56, 0xa4c5cb, 0xffd73f];
	
    public function HudMainChallengeTaskBar()
    {         
        super();
        mcLoader = new MovieClipLoader();
        demandTxtArr = [demandTxt.txt18, demandTxt.txt17, demandTxt.txt16, demandTxt.txt15, demandTxt.txt14, demandTxt.txt14_multi];
    }
	
	public function show(data:Object, time:Number):Void
	{
		this.data = data;
		this.time = time;
		imgSetLoad();
		setDemandTxt(true);
		setStarTxt(true);
		startTween();
	}
	
	public function hide():Void
	{
		hideTween();
	}

	private function configUI():Void
	{		
		super.configUI();	
	}
	
	private function imgSetLoad():Void
	{
		mcLoader.loadClip(_imgPathChallenge+data.imgSet, emblem.emblemMC.imgMC);
	}
	
	private function setDemandTxt(value:Boolean):Void
	{
		if (value)
		{
			resizeDemandTxt(data.demand);
			demandTxt._alpha = 0;
			TweenMax.killTweensOf(demandTxt, true);
			TweenMax.to(demandTxt, 0.5, {_alpha:100, ease:Cubic.easeIn});
		}
		else
		{
			for (var i:Number=0; i<demandTxtArr.length; i++)
			{
				demandTxtArr[i].text = "";
			}
		}
	}
	
	private function resizeDemandTxt(demand:String):Void
	{
		for (var i:Number=0; i<demandTxtArr.length; i++)
		{
			var tempTxt:TextField = demandTxtArr[i];
			tempTxt.text = demand;
			trace(tempTxt.textWidth);
			if (tempTxt.textWidth <= 148)
			{
				if (data.medalType != null)
				{
					tempTxt.textColor = medalFontColor[data.medalType];
					tempTxt.textColor = medalFontColor[data.medalType];
				}
				else
				{
					tempTxt.textColor = medalFontColor[0];
					tempTxt.textColor = medalFontColor[0];
				}
				return;
			}
			tempTxt.text = "";
		}
		
		
	}
	
	private function setStarTxt(value:Boolean):Void
	{
		if (value && data.medalType != null)
		{
			starMC.gotoAndStop(data.medalType+1);
			starMC.numTxt.text = data.medalNum;
			//var format:TextFormat = new TextFormat();
			//format.letterSpacing = -2;
			//format.color = MyInfoChallengeTask.starFontColor[data.medalType-1];
			//starMC.numTxt.setTextFormat(format);
			starMC.numTxt.textColor = starFontColor[data.medalType-1];
		}
		else
		{
			starMC.gotoAndStop(1);
			starMC.numTxt.text = "";
		}
	}
	
	private function startTween():Void 
	{
		bg.gotoAndStop(2);
		TweenMax.to(this, 0.2, {_x:SHOW_POSX, ease:Cubic.easeIn, onComplete:Delegate.create(this, onShowTweenComplete)});
		clearInterval(intervalId);
		intervalId = setInterval(Delegate.create(this, hideTween), time);
	}
	
	private function onShowTweenComplete():Void
	{
		bg.gotoAndStop(1);
		emblem.gotoAndPlay(1);
		glowEffect.gotoAndPlay(1);
	}
	
	private function hideTween():Void 
	{
		clearInterval(intervalId);
		bg.gotoAndStop(2);
		TweenMax.to(this, 0.2, {_x:HIDE_POSX, ease:Cubic.easeOut, onComplete:Delegate.create(this, onHideTweenComplete)});
	}
	
	private function onHideTweenComplete():Void
	{
		data = null;
		time = null;
		bg.gotoAndStop(1);
		emblem.gotoAndStop(1);
		glowEffect.gotoAndStop(1);
		setDemandTxt(false);
		setStarTxt(false);
		emblem.emblemMC.imgMC.gotoAndStop(1);
		this.isUse = false;
	}
	
}