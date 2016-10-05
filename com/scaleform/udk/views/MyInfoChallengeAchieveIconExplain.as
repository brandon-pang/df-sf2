/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.MyInfoChallengeAchieveIconExplainMedal;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeAchieveIconExplain extends UIComponent
{
	public var mainMedal:MyInfoChallengeAchieveIconExplainMedal;
	public var mainTxt:TextField;
	public var demandBg:MovieClip;
	public var demandTxt:TextField;
	public var dateBg:MovieClip;
	public var dateTxt:TextField;
	
	private var minMedalWidth:Number = 128;
	private var minDemandWidth:Number = 148;
	private var minDateWidth:Number = 112;
	
	private var medalFontColor:Array = [0xB2B2B2, 0xdead8d, 0xbababa, 0xffe671];
	
    public function MyInfoChallengeAchieveIconExplain()
    {         
        super();  
    }
	
	public function initAchieveIconExplain():Void
	{
		mainMedal._visible = false;
		mainTxt.text = "";
		//demandBg._visible = false;
		demandTxt.text = "";
		//dateBg._visible = false;
		dateTxt.text = "";
	}
	
	public function setIconExplain(data:Object):Void
	{
		if (data == null) { return; }
		var title:String = data.title;
		var medalType:Number = data.medalType;
		var medalNum:Number = data.medalNum;
		
		mainMedal._visible = true;
		mainTxt.text = title;
		if (mainTxt.textWidth + 55 > minMedalWidth)
		{
			mainMedal.width = mainTxt.textWidth + 55;
			mainMedal._x = (this.width - mainMedal.width >> 1) - 6;
		}
		else
		{
			mainMedal.width = minMedalWidth;
			mainMedal._x = (this.width - (mainTxt.textWidth + 55) >> 1) - 6 - (minMedalWidth - (mainTxt.textWidth + 55) >> 1);
		}
		if (medalType != null)
		{
			mainTxt.textColor = medalFontColor[medalType];
			mainMedal.gotoAndStop(medalType+1);
			mainMedal.textField.textColor = medalFontColor[medalType];;
			mainMedal.textField.text = medalNum.toString();
			//mainMedal.lightMC.gotoAndPlay(1);
		}
		else
		{
			mainTxt.textColor = medalFontColor[0];
			mainMedal.gotoAndStop(1);
			mainMedal.textField.text = "";
			//mainMedal.lightMC.gotoAndStop(1);
		}
		
		var demand:String = data.demand;
		//demandBg._visible = true;
		demandTxt.text = demand;
		/*
		if (demandTxt.textWidth + 20 > minDemandWidth)
		{
			demandBg._width = demandTxt.textWidth + 16;
		}
		else
		{
			demandBg._width = minDemandWidth;
		}
		demandBg._x = this.width - demandBg._width >> 1;
		*/
		
		var date:String = data.date;
		//dateBg._visible = true;
		dateTxt.text = date;
		/*
		if (dateTxt.textWidth + 20 > minDateWidth)
		{
			dateBg._width = dateTxt.textWidth + 16;
		}
		else
		{
			dateBg._width = minDateWidth;
		}
		dateBg._x = this.width - dateBg._width >> 1;
		*/
	}

	private function configUI():Void
	{
		super.configUI();
		
		mainMedal._visible = false;
		demandBg._visible = false;
		dateBg._visible = false;
	}
	
}