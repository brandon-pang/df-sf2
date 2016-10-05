/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeProgTabSett extends UIComponent
{
	
	public var tab0:Button;
	public var tab1:Button;
	public var tab2:Button;
	public var tab3:Button;
	public var tab4:Button;
	public var tab5:Button;
	public var tab6:Button;
	public var tab7:Button;
	
	private var tabPosYArr:Array = [0, 48, 96, 144, 192, 240, 288, 336];
	private var tabTotalArr:Array;
	private var tabArr:Array;
	private var isTween:Boolean = false;
	private var selectedTab:Button;
	
	private var TAB_BASE_HEIGHT:Number = 386;
	
    public function MyInfoChallengeProgTabSett()
    {         
        super();  
    }
	
	public function setTypeTab(arr:Array):Void
	{
		for (var i:Number=0; i<tabTotalArr.length; i++)
		{
			tabTotalArr[i].visible = false;
			tabTotalArr[i].removeEventListener("click", this, "onTabClick");
		}
		
		tabArr = tabTotalArr.slice(0, arr.length);
		
		for (var i:Number=0; i<tabArr.length; i++)
		{
			tabArr[i].visible = true;
			tabArr[i].tabUp.gotoAndStop(arr[i].Code+1);
			tabArr[i].tabSelect.gotoAndStop(arr[i].Code+1);
			tabArr[i].data = arr[i].Code.toString();
			tabArr[i].addEventListener("click", this, "onTabClick");
			tabArr[i]._y = tabPosYArr[i];
		}
		tabArr[0].swapDepths(getNextHighestDepth());
		tabArr[0].selected = true;
		tabArr[0]._height = TAB_BASE_HEIGHT;
		selectedTab = tabArr[0];
	}
	
	public function initChallengeTab():Void
	{
		if (tabArr.length == 0) { return; }
		isTween = false;
		var len:Number = tabArr.length;
		tabArr = tabTotalArr.slice(0, len);
		for (var i:Number=0; i<tabArr.length; i++)
		{
			TweenMax.killTweensOf(tabArr[i], true);
			tabArr[i]._y = tabPosYArr[i];
		}
		
		if (selectedTab) { selectedTab.selected = false; }
		tabArr[0].swapDepths(getNextHighestDepth());
		tabArr[0].selected = true;
		tabArr[0]._height = TAB_BASE_HEIGHT;
		selectedTab = tabArr[0];
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		// 임시 3,4번 탭 숨김
		//tabArr = [tab0, tab1, tab2, tab3, tab4];
//		tab3.visible = false;
//		tab4.visible = false;
//		tabArr = [tab0, tab1, tab2];
//		
//		for (var i:Number=0; i<tabArr.length; i++)
//		{
//			tabArr[i].data = i.toString();
//			tabArr[i].addEventListener("click", this, "onTabClick");
//		}
//		
//		tab0.selected = true;
//		selectedTab = tab0;
		
		tabTotalArr = [tab0, tab1, tab2, tab3, tab4, tab5, tab6, tab7];
		
		for (var i:Number=0; i<tabTotalArr.length; i++)
		{
			tabTotalArr[i].visible = false;
		}
		
		setTypeTab([{Code:0}, {Code:1}, {Code:2}, {Code:5}]);
	}
	
	private function onTabClick(e:Object):Void
	{
		if (isTween) { return; }
		
		for (var i:Number=0; i<tabArr.length; i++)
		{
			if (e.target == tabArr[i])
			{
				if (i == 0) { return; }
				isTween = true;
				setTabSelect(e.target, i);
				setArrangeArr(i);
				tabTweenStart(i);
				listTweenDispatch(Number(e.target.data));
				return;
			}
		}
	}

	private function listTweenDispatch(index:Number):Void 
	{
		dispatchEvent({type:"tweenStart", index:index});
	}

	
	private function setTabSelect(tab:Button, index:Number):Void
	{
		if (selectedTab) { selectedTab.selected = false; }
		tab.swapDepths(getNextHighestDepth());
		tab.selected = true;
		tab._height = TAB_BASE_HEIGHT - tabPosYArr[index];
		selectedTab = tab;
	}
	
	private function setArrangeArr(index:Number):Void
	{
		//var tempArr:Array = tabArr.splice(0, index);
		//tabArr = tabArr.concat(tempArr);
		var tempArr:Array = tabArr.splice(index, 1);
		tabArr.unshift(tempArr[0]);
	}
	
	private function tabTweenStart(index:Number):Void
	{
		for (var i:Number=0; i<tabArr.length; i++)
		{
			if (selectedTab == tabArr[i])
			{
				TweenMax.to(
								tabArr[i],
								0.5,
								{
									_y:tabPosYArr[i],
									_height:TAB_BASE_HEIGHT,
									ease:Back.easeOut,
									onComplete:Delegate.create(this, onSelectedTabTweenComp)
								}
							);
			}
			else
			{
				//tabArr[i]._alpha = 50;
				TweenMax.to(
								tabArr[i],
								0.3,
								{
									//delay:0.08*i,
									delay:0.15/i,
									_y:tabPosYArr[i],
									//_alpha:100,
									ease:Cubic.easeOut
								}
							);
			}
		}
	}

	private function onSelectedTabTweenComp():Void 
	{
		isTween = false;
	}
	
	
	
	
}