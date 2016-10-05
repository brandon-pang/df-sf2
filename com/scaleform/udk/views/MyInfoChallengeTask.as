/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.MyInfoChallengeTotalPoint;
import flash.external.ExternalInterface;
import com.scaleform.udk.views.MyInfoChallengeAchieveCont;
import gfx.controls.Button;
import com.scaleform.udk.views.MyInfoChallengeProgCont;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeTask extends UIComponent
{
	public var tab0:Button;
	public var tab1:Button;
	
	public var totalPoint:MyInfoChallengeTotalPoint;
	public var progressContents:MyInfoChallengeProgCont;
	public var achievementContents:MyInfoChallengeAchieveCont;
	    
	public function MyInfoChallengeTask()
	{         
		super();  
	}
	
	public function callengeProgress_SetTypeTab(arr:Array):Void
	{
		progressContents.callengeProgress_SetTypeTab(arr);
	}
	
	public function challengeAchieve_SetSelectedIndex(index:Number):Void
    {
    	achievementContents.challengeAchieve_SetSelectedIndex(index);
    }
	
	public function challenge_ShowTotalPoint(str:String):Void
    {
    	totalPoint.challenge_ShowTotalPoint(str);
    }
    
    public function challenge_HideTotalPoint():Void
    {
    	totalPoint.challenge_HideTotalPoint();
    }
	
	public function initChallengeTask():Void
	{
		tab0.selected = true;
		tab1.selected = false;
		
		progressContents._visible = true;
		progressContents.initChallengeList();
		achievementContents._visible = false;
		achievementContents.initAchievementContents();
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		progressContents._visible = true;
		achievementContents._visible = false;
		
		var labelArr:Array = ["_Challenge_progress", "_Challenge_achievement"];
    	if (_global.gfxPlayer)
    	{
    		labelArr = ["진행 중", "완 료"];
    	}
    	
    	tab0.label = labelArr[0];
    	tab1.label = labelArr[1];
		
		tab0.selected = true;
		tab0.addEventListener("click", this, "onChallengeTab0Click");
		tab1.addEventListener("click", this, "onChallengeTab1Click");
	}
	
	private function onChallengeTab0Click():Void
	{
		tab0.selected = true;
		tab1.selected = false;
		progressContents._visible = true;
		achievementContents.initAchievementContents();
		achievementContents._visible = false;
		ExternalInterface.call("challenge_OnSubTabClick", 0);
	}
	
	private function onChallengeTab1Click():Void
	{
		tab0.selected = false;
		tab1.selected = true;
		progressContents.initChallengeList();
		progressContents._visible = false;
		achievementContents._visible = true;
		ExternalInterface.call("challenge_OnSubTabClick", 1);
		if (_root.designMode) { achievementContents.challengeAchieve_SetSelectedIndex(0); }
	}
}