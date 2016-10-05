/**
 * ...
 * @author 
 */

import com.scaleform.udk.controls.MyInfoChallengeAchieveIconNaviItem;
import gfx.controls.TileList;
import flash.filters.BlurFilter;
import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeAchieveIconNavi extends UIComponent
{
	public var icon0:MyInfoChallengeAchieveIconNaviItem;
	public var icon1:MyInfoChallengeAchieveIconNaviItem;
	public var icon2:MyInfoChallengeAchieveIconNaviItem;
	public var icon3:MyInfoChallengeAchieveIconNaviItem;
	public var icon4:MyInfoChallengeAchieveIconNaviItem;
	public var icon5:MyInfoChallengeAchieveIconNaviItem;
	public var icon6:MyInfoChallengeAchieveIconNaviItem;
	public var icon7:MyInfoChallengeAchieveIconNaviItem;
	public var icon8:MyInfoChallengeAchieveIconNaviItem;
	public var icon9:MyInfoChallengeAchieveIconNaviItem;
	public var icon10:MyInfoChallengeAchieveIconNaviItem;
	
	private var iconPosArr:Array = [120, 120, 152, 184, 216, 324, 439, 471, 503, 535, 535];
	private var iconArr:Array = [];
	private var iconAlphaArr:Array = [0, 50, 75, 82, 90, 100, 90, 82, 75, 50, 0];
	private var iconScaleArr:Array = [50, 55, 59, 63, 67, 100, 67, 63, 59, 55, 50];
	//private var iconOldXArr:Array = [36, 120, 152, 184, 216, 324, 439, 471, 503, 535, 617];
	private var iconIndexArr:Array = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
	
    public function MyInfoChallengeAchieveIconNavi()
    {         
        super();  
    }
	
	public function initAchieveIconNavi():Void
	{
		iconIndexArr = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];
		for (var i:Number=0; i<iconArr.length; i++)
		{
			iconArr[i].setUnLoadIcon();
		}
	}
	
	public function setDataIcon(list:TileList, index:Number):Void
	{
		for (var i:Number=0; i<iconArr.length; i++)
		{
			iconIndexArr[i] = index + (i - 5);
		}
		
		for (var j:Number=0; j<iconArr.length; j++)
		{
			if (iconIndexArr[j] > -1 && iconIndexArr[j] < list.dataProvider.length)
			{
				iconArr[j].setLoadIcon(list, iconIndexArr[j], j);
			}
			else
			{
				iconArr[j].setUnLoadIcon();
			}
		}
	}
	
	public function setPosIcon(direction:String):Void
	{
		setArrangeArr(direction);
		setTweenIcon(direction);
	}

	private function configUI():Void
	{
		super.configUI();
		
		iconArr = [icon0, icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, icon9, icon10];
		
		for (var i:Number=0; i<iconArr.length; i++)
		{
			iconArr[i]._x = iconPosArr[i];
			iconArr[i]._alpha = iconAlphaArr[i];
			iconArr[i]._xscale = iconScaleArr[i];
			iconArr[i]._yscale = iconScaleArr[i];
			if (i != 5)
			{
				iconArr[i].gotoAndStop(2);
			}
		}
	}
	
	private function setArrangeArr(direction:String):Void
	{
		if (direction == "prev")
		{
			var tempArr:Array = [iconArr.pop()];
			iconArr = tempArr.concat(iconArr);
		}
		else if (direction == "next")
		{
			var tempArr:Array = [iconArr.shift()];
			iconArr = iconArr.concat(tempArr);
		}
	}
	
	private function setTweenIcon(direction:String):Void
	{
		dispatchEvent({type:"tweenStart"});
		
		for (var i:Number=0; i<iconArr.length; i++)
		{
			TweenMax.killTweensOf(iconArr[i], true);
		}
		if (direction == "prev")
		{
			for (var i:Number=1; i<iconArr.length; i++)
			{
				if (i < 5)
				{
					if (iconArr[i].getDepth() > iconArr[i+1].getDepth()) { iconArr[i].swapDepths(iconArr[i+1]); }
				}
				else if (i == 5) { iconArr[i].gotoAndStop(1); }
				else if (i > 5)
				{
					if (i == 6) { iconArr[i].gotoAndStop(2); }
					if (iconArr[i-1].getDepth() < iconArr[i].getDepth()) { iconArr[i].swapDepths(iconArr[i-1]); }
				}
				
				TweenMax.to(
								iconArr[i],
								0.3,
								{
									_x:iconPosArr[i],
									_alpha:iconAlphaArr[i],
									_xscale:iconScaleArr[i],
									_yscale:iconScaleArr[i],
									ease:Cubic.easeOut,
									//ease:Linear.easeNone,
									//onUpdate:Delegate.create(this, onIconTweenUpdate),
									//onUpdateParams:[i],
									onComplete:Delegate.create(this, onIconTweenComplete),
									onCompleteParams:[i]
								}
							);
			}
			iconArr[0]._x = iconPosArr[0];
			iconArr[0]._alpha = iconAlphaArr[0];
			iconArr[0]._xscale = iconScaleArr[0];
			iconArr[0]._yscale = iconScaleArr[0];
			//var filter:BlurFilter = new BlurFilter(0, 0, 3);
       		//iconArr[0].filters = [filter];
		}
		else if (direction == "next")
		{
			for (var i:Number=iconArr.length-2; i>=0; i--)
			{
				if (i > 5)
				{
					if (iconArr[i-1].getDepth() < iconArr[i].getDepth()) { iconArr[i].swapDepths(iconArr[i-1]); }
				}
				else if (i == 5) { iconArr[i].gotoAndStop(1); }
				else if (i < 5)
				{
					if (i == 4) { iconArr[i].gotoAndStop(2); }
					if (iconArr[i].getDepth() > iconArr[i+1].getDepth()) { iconArr[i].swapDepths(iconArr[i+1]); }
				}
				
				TweenMax.to(
								iconArr[i],
								0.3,
								{
									_x:iconPosArr[i],
									_alpha:iconAlphaArr[i],
									_xscale:iconScaleArr[i],
									_yscale:iconScaleArr[i],
									ease:Cubic.easeOut,
									//ease:Linear.easeNone,
									//onUpdate:Delegate.create(this, onIconTweenUpdate),
									//onUpdateParams:[i],
									onComplete:Delegate.create(this, onIconTweenComplete),
									onCompleteParams:[i]
								}
							);
			}
			iconArr[iconArr.length-1]._x = iconPosArr[iconArr.length-1];
			iconArr[iconArr.length-1]._alpha = iconAlphaArr[iconArr.length-1];
			iconArr[iconArr.length-1]._xscale = iconScaleArr[iconArr.length-1];
			iconArr[iconArr.length-1]._yscale = iconScaleArr[iconArr.length-1];
			//var filter:BlurFilter = new BlurFilter(0, 0, 3);
       		//iconArr[iconArr.length-1].filters = [filter];
		}
	}
	
	private function onIconTweenUpdate(index:Number):Void 
	{
		var amountX:Number = Math.abs((iconArr[index]._x - iconPosArr[index]));
        var filter:BlurFilter = new BlurFilter(amountX, 0, 3);
        iconArr[index].filters = [filter];
        iconPosArr[index] = iconArr[index]._x;
	}

	private function onIconTweenComplete(index:Number):Void 
	{
		if (index == 5) { dispatchEvent({type:"tweenComplete", data:iconArr[5].data}); }
	}
	
	
}