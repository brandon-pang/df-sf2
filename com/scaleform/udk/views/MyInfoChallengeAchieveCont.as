/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.MyInfoChallengeAchieveIconExplain;
import com.scaleform.udk.controls.MyInfoChallengeAchieveIconScroll;
import com.scaleform.udk.views.MyInfoChallengeAchieveIconNavi;
import gfx.controls.Button;
import gfx.data.SFGameDataProvider;
import gfx.controls.ScrollBar;
import gfx.controls.TileList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeAchieveCont extends UIComponent
{
	public var list_achieve:TileList;
	public var scrollBar:ScrollBar;
	
	public var nextBtn:Button;
	public var prevBtn:Button;
	public var iconNavi:MyInfoChallengeAchieveIconNavi;
	public var iconScroll:MyInfoChallengeAchieveIconScroll;
	public var iconExplain:MyInfoChallengeAchieveIconExplain;
	public var naviEffectBg:MovieClip;
	
	private var curListIndex:Number = -1;
	
    public function MyInfoChallengeAchieveCont()
    {         
        super();  
    }
	
	public function initAchievementContents():Void
	{
		curListIndex = -1;
		list_achieve.scrollPosition = 0;
		list_achieve.selectedIndex = -1;
		iconNavi.initAchieveIconNavi();
		naviEffectBg._visible = false;
		iconExplain.initAchieveIconExplain();
	}
	
	public function challengeAchieve_SetSelectedIndex(index:Number):Void
    {
    	if (_root.designMode)
		{
			list_achieve.dataProvider = [
											{imgSet:"Challenge_medal_oder", title:"저기 날아오는 것은 총알이라네, 병사", demand:"일병 진급!", date:"2012년 4월 25일 습득", medalType:1, medalNum:10},
											{imgSet:"Challenge_medal_clock", title:"전투를 시작하며", demand:"누적 10시간", date:"2012년 12월 25일 습득"},
											{imgSet:"Challenge_medal_skull", title:"총에 익숙해 지는 법", demand:"누적 100킬", date:"2012년 11월 25일 습득", medalType:2, medalNum:20},
											{imgSet:"Challenge_medal_assist", title:"양념밖에 모르는 바보", demand:"누적 100000 어시스트", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_death", title:"죽는 것도 지겨워", demand:"누적 1000죽음", date:"2012년 9월 25일 습득"},
											{imgSet:"Challenge_medal_head", title:"머리를 수집하기로 했습니다", demand:"누적 50헤드샷", date:"2012년 4월 25일 습득", medalType:3, medalNum:30},
											{imgSet:"Challenge_medal_ar", title:"AR 100 사살 : 브론즈", demand:"AR 100 KILL", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_sr", title:"SR 50 사살", demand:"SR 50 KILL", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_smg", title:"SMG 500 사살", demand:"SMG 500 KILL", date:"2012년 4월 25일 습득", medalType:1, medalNum:10},
											{imgSet:"Challenge_medal_mg", title:"MG 2500 도움 : 다이아몬드", demand:"MG 2500 ASSIST", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", date:"2012년 4월 5일 습득"},
											{imgSet:"Challenge_medal_oder", title:"저기 날아오는 것은 총알이라네, 병사", demand:"일병 진급!", date:"2012년 4월 25일 습득", medalType:1, medalNum:10},
											{imgSet:"Challenge_medal_clock", title:"전투를 시작하며", demand:"누적 10시간", date:"2012년 12월 25일 습득"},
											{imgSet:"Challenge_medal_skull", title:"총에 익숙해 지는 법", demand:"누적 100킬", date:"2012년 11월 25일 습득", medalType:2, medalNum:20},
											{imgSet:"Challenge_medal_assist", title:"양념밖에 모르는 바보", demand:"누적 100000 어시스트", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_death", title:"죽는 것도 지겨워", demand:"누적 1000죽음", date:"2012년 9월 25일 습득"},
											{imgSet:"Challenge_medal_head", title:"머리를 수집하기로 했습니다", demand:"누적 50헤드샷", date:"2012년 4월 25일 습득", medalType:3, medalNum:30},
											{imgSet:"Challenge_medal_ar", title:"AR 100 사살 : 브론즈", demand:"AR 100 KILL", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_sr", title:"SR 50 사살", demand:"SR 50 KILL", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_smg", title:"SMG 500 사살", demand:"SMG 500 KILL", date:"2012년 4월 25일 습득", medalType:1, medalNum:10},
											{imgSet:"Challenge_medal_mg", title:"MG 2500 도움 : 다이아몬드", demand:"MG 2500 ASSIST", date:"2012년 4월 25일 습득"},
											{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", date:"2012년 4월 5일 습득"}
										];
		}
		if (curListIndex < index)
		{
			curListIndex = index;
			list_achieve.selectedIndex = index;
			iconNavi.setPosIcon("next");
			iconNavi.setDataIcon(list_achieve, index);
			setNaviBtn(index);
		}
		else if (curListIndex > index)
		{
			curListIndex = index;
			list_achieve.selectedIndex = index;
			iconNavi.setPosIcon("prev");
			iconNavi.setDataIcon(list_achieve, index);
			setNaviBtn(index);
		}
	}

	private function setNaviBtn(index:Number):Void 
	{
		if (index == 0)
		{
			prevBtn.visible = false;
			nextBtn.visible = true;
		}
		else if (index == list_achieve.dataProvider.length-1)
		{
			prevBtn.visible = true;
			nextBtn.visible = false;
		}
		else
		{
			prevBtn.visible = true;
			nextBtn.visible = true;
		}
		if (list_achieve.dataProvider.length == 0)
		{
			naviEffectBg._visible = false;
			
			prevBtn.visible = false;
			nextBtn.visible = false;
		}
		else if (list_achieve.dataProvider.length == 1)
		{
			prevBtn.visible = false;
			nextBtn.visible = false;
		}
		else
		{
			naviEffectBg._visible = true;
		}
	}

	private function configUI():Void
	{
		super.configUI();
		
		list_achieve.dataProvider = new SFGameDataProvider("MyInfoChallenge:achievementList");
		
		nextBtn.addEventListener("click", this, "onNextBtnClick");
		prevBtn.addEventListener("click", this, "onPrevBtnClick");
		
		prevBtn.visible = false;
		nextBtn.visible = false;
		
		list_achieve.addEventListener("itemClick", this, "onListAchieveClick");
		
		iconScroll.addEventListener("scrollWheel", this, "onIconNaviScrollWhell");
		iconNavi.addEventListener("tweenStart", this, "onIconNaviTweenStart");
		iconNavi.addEventListener("tweenComplete", this, "onIconNaviTweenComplete");
	}

	private function onNextBtnClick():Void
	{
		iconNavi.setPosIcon("next");
		iconNavi.setDataIcon(list_achieve, list_achieve.selectedIndex+1);
		list_achieve.selectedIndex = list_achieve.selectedIndex+1;
		curListIndex = list_achieve.selectedIndex;
		setNaviBtn(list_achieve.selectedIndex);
	}
	
	private function onPrevBtnClick():Void
	{
		iconNavi.setPosIcon("prev");
		iconNavi.setDataIcon(list_achieve, list_achieve.selectedIndex-1);
		list_achieve.selectedIndex = list_achieve.selectedIndex-1;
		curListIndex = list_achieve.selectedIndex;
		setNaviBtn(list_achieve.selectedIndex);
	}
	
	private function onListAchieveClick(e:Object):Void
	{
		if (curListIndex < list_achieve.selectedIndex)
		{
			iconNavi.setPosIcon("next");
		}
		else if (curListIndex > list_achieve.selectedIndex)
		{
			iconNavi.setPosIcon("prev");
		}
		iconNavi.setDataIcon(list_achieve, list_achieve.selectedIndex);
		curListIndex = list_achieve.selectedIndex;
		setNaviBtn(list_achieve.selectedIndex);
	}
	
	private function onIconNaviScrollWhell(e:Object):Void
	{	
		if (list_achieve.dataProvider.length == 0) { return; }
		if (e.delta == 1)
		{
			if (list_achieve.selectedIndex == 0) { return; }
			onPrevBtnClick();
		}
		else if (e.delta == -1)
		{
			if (list_achieve.selectedIndex == list_achieve.dataProvider.length-1) { return; }
			onNextBtnClick();
		}
	}
	
	private function onIconNaviTweenStart(e:Object):Void
	{
		//iconExplain.visible = false;
	}
	
	private function onIconNaviTweenComplete(e:Object):Void
	{
		//iconExplain.visible = true;
		iconExplain.setIconExplain(e.data);
	}
	
}