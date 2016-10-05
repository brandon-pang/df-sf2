/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import gfx.utils.Delegate;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.PveResultItemReward extends UIComponent
{
	public var loader:MovieClip;
	public var stopBtn:Button;
	
	private var itemData:Array;
	private var selIndex:Number;
	
	private var yPosUnit:Number = 128;
	private var intervalId:Number;
	private var stopFlag:Boolean = false;
	
    public function PveResultItemReward()
    {         
        super();  
    }
	
	public function resetReward():Void
	{
		TweenMax.killTweensOf(loader);
		loader._y = 0;
		stopFlag = false;
		for (var prop in loader) { 
			loader[prop].removeMovieClip(); 
		}
		stopBtn.visible = true;
	}
	
	public function setReward(data:Array, index:Number, t:Number):Void
	{
		resetReward();
		
		itemData = data;
		selIndex = index;
		for (var i:Number=0; i<data.length; i++)
		{
			var item:MovieClip = loader.attachMovie("result_item_pve_rewardItem", "item"+i, loader.getNextHighestDepth(), {_y:-(i+1)*yPosUnit});
			item.setData(data[i]);
			if (i == 0)
			{
				var firstItem:MovieClip = loader.attachMovie("result_item_pve_rewardItem", "itemF"+i, loader.getNextHighestDepth(), {_y:-(data.length+1)*yPosUnit});
				firstItem.setData(data[i]);
			}
			if (i == data.length-1)
			{
				var lastItem1:MovieClip = loader.attachMovie("result_item_pve_rewardItem", "itemL1"+i, loader.getNextHighestDepth(), {_y:0});
				lastItem1.setData(data[i]);
				var lastItem2:MovieClip = loader.attachMovie("result_item_pve_rewardItem", "itemL2"+i, loader.getNextHighestDepth(), {_y:-(data.length+2)*yPosUnit});
				lastItem2.setData(data[i]);
			}
		}
		
		startTween();
		
		clearInterval(intervalId);
		var duration:Number;
		if (t != null && t != 0) { duration = t * 1000; }
		else { duration = 10000; }
		intervalId = setInterval(this, "onLoadInterval", duration);
		
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		stopBtn.addEventListener("click",this,"onStopBtnClick");
	}
	
	private function onStopBtnClick(e:Object):Void
	{
		clearInterval(intervalId);
		stopFlag = true;
		e.target.visible = false;
	}
	
	private function startTween():Void
	{
		var targetPos:Number = (itemData.length-1)*yPosUnit;
		var duration:Number = 0.1*itemData.length;
		TweenMax.to(
						loader,
						duration,
						{
							_y:			targetPos,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onStartTweenComplete)
						}
					);
	}
	
	private function onStartTweenComplete():Void
	{
		loader._y = -yPosUnit;
		if (stopFlag)
		{
			if (selIndex == 0)
			{
				endTween((itemData.length-2)*yPosUnit);
			}
			else if (selIndex == 1)
			{
				onEndTweenComplete(-yPosUnit);
			}
			else
			{
				endTween((selIndex-2)*yPosUnit);
			}
		}
		else
		{
			startTween();
		}
	}
	
	private function onLoadInterval():Void
	{
		clearInterval(intervalId);
		stopFlag = true;
		stopBtn.visible = false;
	}
	
	private function endTween(targetPos:Number):Void
	{
		var duration:Number = 0.1*itemData.length;
		TweenMax.to(
						loader,
						duration,
						{
							_y:			targetPos,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onEndTweenComplete),
							onCompleteParams: [targetPos]
						}
					);
	}
	
	private function onEndTweenComplete(targetPos:Number):Void
	{
		TweenMax.to(loader, 1.5, {_y:targetPos+(yPosUnit*2), ease:Back.easeOut});
	}
	
	
}