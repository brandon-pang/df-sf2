/**
 * ...
 * @author 
 */

import com.scaleform.MaskedList;
import flash.external.ExternalInterface;
import com.scaleform.udk.controls.MyInfoChallengeListItem;
import gfx.data.SFGameDataProvider;
import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import com.scaleform.udk.views.MyInfoChallengeProgTabSett;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeProgCont extends UIComponent
{
	public var tabSett:MyInfoChallengeProgTabSett;
	
	public var list_challenge:MaskedList;
	
	public var item1:MyInfoChallengeListItem;
	public var item2:MyInfoChallengeListItem;
	public var item3:MyInfoChallengeListItem;
	public var item4:MyInfoChallengeListItem;
	
	public var itemBg1:MovieClip;
	public var itemBg2:MovieClip;
	public var itemBg3:MovieClip;
	public var itemBg4:MovieClip;
	
	private var itemPosYArr:Array = [27, 115, 203, 291];
	private var ITEM_BASE_POSY:Number = 379;
	private var ITEM_BASE_TARGETX:Number = 75;
	private var ITEM_BASE_POSX:Number = 322;
	
    public function MyInfoChallengeProgCont()
    {         
        super();  
    }
	
	public function callengeProgress_SetTypeTab(arr:Array):Void
	{
		tabSett.setTypeTab(arr);
	}
	
	public function initChallengeList():Void
	{
		list_challenge.scrollPosition = 0;
		tabSett.initChallengeTab();
		if (_global.gfxPlayer)
		{
			list_challenge.dataProvider = [
												{imgSet:"Challenge_medal_oder", title:"저기 날아오는 것은 총알이라네, 병사", demand:"일병 진급!", curNum:80, totalNum:100, medalType:1, medalNum:10},
												{imgSet:"Challenge_medal_clock", title:"전투를 시작하며", demand:"누적 10시간", curNum:5, totalNum:10},
												{imgSet:"Challenge_medal_skull", title:"총에 익숙해 지는 법", demand:"누적 100킬", curNum:23, totalNum:100, medalType:2, medalNum:20},
												{imgSet:"Challenge_medal_assist", title:"양념밖에 모르는 바보", demand:"누적 10어시스트", curNum:9, totalNum:10},
												{imgSet:"Challenge_medal_death", title:"죽는 것도 지겨워", demand:"누적 1000죽음", curNum:860, totalNum:1000},
												{imgSet:"Challenge_medal_head", title:"머리를 수집하기로 했습니다", demand:"누적 50헤드샷", curNum:40, totalNum:50, medalType:3, medalNum:30},
												{imgSet:"Challenge_medal_ar", title:"AR 100 사살 : 브론즈", demand:"AR 100 KILL", curNum:51, totalNum:100},
												{imgSet:"Challenge_medal_sr", title:"SR 50 사살", demand:"SR 50 KILL", curNum:22, totalNum:50},
												{imgSet:"Challenge_medal_smg", title:"SMG 500 사살", demand:"SMG 500 KILL", curNum:490, totalNum:500, medalType:1, medalNum:10},
												{imgSet:"Challenge_medal_mg", title:"MG 2500 도움 : 다이아몬드", demand:"MG 2500 ASSIST", curNum:1200, totalNum:2500},
												{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", curNum:0, totalNum:1}
											];						
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		tabSett.addEventListener("tweenStart", this, "onTabTweenStart");
		
		list_challenge.dataProvider = new SFGameDataProvider("MyInfoChallenge:progressList");
	}
	
	private function onTabTweenStart(e:Object):Void
	{
		changeTypeTab(e.index);
	}

	private function changeTypeTab(index:Number):Void 
	{
		list_challenge.scrollPosition = 0;
		listTweenStart();
		
		ExternalInterface.call("challenge_OnProgressTypeTabClick", index);
		if (_global.gfxPlayer) {
			if (index == 0)
			{
				list_challenge.dataProvider = [
												{imgSet:"Challenge_medal_oder", title:"저기 날아오는 것은 총알이라네, 병사", demand:"일병 진급!", curNum:80, totalNum:100, medalType:1, medalNum:10},
												{imgSet:"Challenge_medal_clock", title:"전투를 시작하며", demand:"누적 10시간", curNum:5, totalNum:10},
												{imgSet:"Challenge_medal_skull", title:"총에 익숙해 지는 법", demand:"누적 100킬", curNum:23, totalNum:100, medalType:2, medalNum:20},
												{imgSet:"Challenge_medal_assist", title:"양념밖에 모르는 바보", demand:"누적 10어시스트", curNum:9, totalNum:10},
												{imgSet:"Challenge_medal_death", title:"죽는 것도 지겨워", demand:"누적 1000죽음", curNum:860, totalNum:1000},
												{imgSet:"Challenge_medal_head", title:"머리를 수집하기로 했습니다", demand:"누적 50헤드샷", curNum:40, totalNum:50, medalType:3, medalNum:30},
												{imgSet:"Challenge_medal_ar", title:"AR 100 사살 : 브론즈", demand:"AR 100 KILL", curNum:51, totalNum:100},
												{imgSet:"Challenge_medal_sr", title:"SR 50 사살", demand:"SR 50 KILL", curNum:22, totalNum:50},
												{imgSet:"Challenge_medal_smg", title:"SMG 500 사살", demand:"SMG 500 KILL", curNum:490, totalNum:500, medalType:1, medalNum:10},
												{imgSet:"Challenge_medal_mg", title:"MG 2500 도움 : 다이아몬드", demand:"MG 2500 ASSIST", curNum:1200, totalNum:2500},
												{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", curNum:0, totalNum:1}
											];
			}
			else if (index == 1)
			{
				list_challenge.dataProvider = [
												{imgSet:"Challenge_medal_skull", title:"총에 익숙해 지는 법", demand:"누적 100킬", curNum:23, totalNum:100, medalType:2, medalNum:20},
												{imgSet:"Challenge_medal_death", title:"죽는 것도 지겨워", demand:"누적 1000죽음", curNum:860, totalNum:1000},
												{imgSet:"Challenge_medal_head", title:"머리를 수집하기로 했습니다", demand:"누적 50헤드샷", curNum:40, totalNum:50, medalType:3, medalNum:30}
											];
			}
			else if (index == 2)
			{
				list_challenge.dataProvider = [
												{imgSet:"Challenge_medal_ar", title:"AR 100 사살 : 브론즈", demand:"AR 100 KILL", curNum:51, totalNum:100},
												{imgSet:"Challenge_medal_sr", title:"SR 50 사살", demand:"SR 50 KILL", curNum:22, totalNum:50},
												{imgSet:"Challenge_medal_smg", title:"SMG 500 사살", demand:"SMG 500 KILL", curNum:490, totalNum:500, medalType:1, medalNum:10},
												{imgSet:"Challenge_medal_mg", title:"MG 2500 도움 : 다이아몬드", demand:"MG 2500 ASSIST", curNum:1200, totalNum:2500},
												{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", curNum:0, totalNum:1}
											];
			}
			else if (index == 3)
			{
				list_challenge.dataProvider = [];
			}
			else
			{
				list_challenge.dataProvider = [
												{imgSet:"Challenge_medal_sg", title:"SG 1 어시스트", demand:"SG 1 ASSIST", curNum:0, totalNum:1}
											];
			}
		}
	}
	
	private function listTweenStart():Void
	{
		TweenMax.killTweensOf(list_challenge, true);
		list_challenge._alpha = 0;
		TweenMax.to(list_challenge, 0.4, {delay:0.2, _alpha:100, ease:Cubic.easeOut});
	}
	
}