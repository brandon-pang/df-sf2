/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.controls.Button;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.views.PveWaitRoomMapExplainCont extends UIComponent
{
	public var loader:MovieClip;
	public var leftBtn:Button;
	public var rightBtn:Button;
	public var explainTxt:TextField;
	public var txtBg:MovieClip;
	public var bottomNavi:MovieClip;
	public var bg:MovieClip;
	//public var hitArea:MovieClip;
	private var curIndex:Number;
	private var explainArr:Array;
	private var xPosUnit:Number = 338;
	private var bottomBtnArr:Array;
	private var mapImgTween:TweenMax;
	
	

	public function PveWaitRoomMapExplainCont()
	{
		super();
	}

	public function resetCont():Void
	{
		TweenMax.killTweensOf(loader,true);
		loader._x = 0;
		explainArr = [];
		explainTxt.htmlText = "";

		for (var prop in loader)
		{
			if (typeof (loader[prop]) == "movieclip")
			{
				loader[prop].removeMovieClip();
			}
		}

		for (var i:Number = 0; i < bottomBtnArr.length; i++)
		{
			if (bottomBtnArr[i])
			{
				bottomBtnArr[i].removeMovieClip();
			}
		}
		bottomBtnArr = [];

		leftBtn.visible = false;
		rightBtn.visible = false;
		bottomNavi._visible = false;
		txtBg._visible = false;
	}

	public function setMapExplain(arr:Array):Void
	{
		resetCont();
		if (arr == null || arr.length == 0)
		{
			return;
		}

		if (arr.length != 1)
		{
			leftBtn.visible = true;
			rightBtn.visible = true;
		}
		bottomNavi._visible = true;
		txtBg._visible = true;

		for (var i:Number = 0; i < arr.length; i++)
		{
			var item:MovieClip = loader.attachMovie("pveExplainItem", "item" + i, loader.getNextHighestDepth(), {_x:i * xPosUnit});
			item.setData(arr[i].ImgSet);
			if (i == arr.length - 1)
			{
				var lastItem:MovieClip = loader.attachMovie("pveExplainItem", "item" + (i + 1), loader.getNextHighestDepth(), {_x:-xPosUnit});
				lastItem.setData(arr[i].ImgSet);
			}
			explainArr.push(arr[i].ExplainTxt);
			var bottomBtn:MovieClip = bottomNavi.attachMovie("pveExplainBottonNaviBtn", "btn" + i, bottomNavi.getNextHighestDepth(), {_x:i * 10 + 4, _y:1});
			bottomBtnArr.push(bottomBtn);
			
			
		}

		curIndex = 0;
		explainTxt.htmlText = explainArr[0];
		bottomNavi.bg._width = explainArr.length * 10 + 18;
		bottomNavi._x = bg._width - bottomNavi._width >> 1;
		bottomBtnArr[0].gotoAndStop(2);
	}

	public function prevExplain():Void
	{
		setNaviDirection("prev");
	}

	public function nextExplain():Void
	{
		setNaviDirection("next");
	}

	private function configUI():Void
	{
		super.configUI();

		leftBtn.addEventListener("click",this,"onLeftBtnClick");
		rightBtn.addEventListener("click",this,"onRightBtnClick");

		explainTxt.verticalAlign = "center";
		explainTxt.html = true;

		leftBtn.visible = false;
		rightBtn.visible = false;
		bottomNavi._visible = false;
		txtBg._visible = false;
	}

	private function onLeftBtnClick():Void
	{
		setNaviDirection("prev");
	}

	private function onRightBtnClick():Void
	{
		setNaviDirection("next");
	}

	private function setNaviDirection(direction:String):Void
	{
		if (explainArr.length == null || explainArr.length == 0 || explainArr.length == 1)
		{
			return;
		}
		
		//trace (TweenMax.isTweening(loader))

		if(TweenMax.isTweening(loader)){return;}

		TweenMax.killTweensOf(loader,true);

		var targetPos:Number;
		if (direction == "prev")
		{
			if (curIndex == 0)
			{
				curIndex = explainArr.length - 1;
			}
			else
			{
				curIndex--;
			}
			if (loader._x == xPosUnit)
			{
				loader._x = -xPosUnit * (explainArr.length - 1);

			}
			targetPos = loader._x + xPosUnit;
		}
		else if (direction == "next")
		{
			if (curIndex == explainArr.length - 1)
			{
				curIndex = 0;
			}
			else
			{
				curIndex++;
			}
			if (loader._x == -xPosUnit * (explainArr.length - 1))
			{
				loader._x = xPosUnit;
			}
			targetPos = loader._x - xPosUnit;

		}

		for (var i:Number = 0; i < bottomBtnArr.length; i++)
		{
			if (bottomBtnArr[i])
			{
				bottomBtnArr[i].gotoAndStop(1);
			}
		}
		bottomBtnArr[curIndex].gotoAndStop(2);

		//trace (targetPos)
		startTween(targetPos);
	}

	private function startTween(targetPos:Number):Void
	{
		mapImgTween=TweenMax.to(loader,
					0.3,
					{_x:targetPos, 
					ease:Cubic.easeOut, 
					onComplete:Delegate.create(this, onStartTweenComplete)});
	}

	private function onStartTweenComplete():Void
	{
		explainTxt.htmlText = explainArr[curIndex];
	}

}