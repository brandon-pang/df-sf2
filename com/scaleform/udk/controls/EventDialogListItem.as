/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import com.greensock.easing.*; 
import com.greensock.TweenMax;
import gfx.utils.Delegate;
import com.scaleform.udk.controls.EventDialogListItemMainBtn;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.EventDialogListItem extends UIComponent
{
	public var mainBtn:EventDialogListItemMainBtn;
	public var selectedBtn:Button;
	
	public var index:Number;
	public var opened:Boolean = false;
	public var targetHeight:Number;
	public var data:Object;
	
	private var isSub:Boolean = false;
	private var subFrame:MovieClip;
	private var subFrameOffset:Number = 10;
	private var subFrameHeight:Number;
	private var subArr:Array = [];
	private var basePos:Number;
	private var baseHeight:Number;
	
	private var _selected:Boolean = false;
	
	
	public function EventDialogListItem()
	{
		super();
		
		targetHeight = this._height;
	}
	
	public function get selected():Boolean { return _selected; }
	public function set selected(value:Boolean):Void
	{
		if (selectedBtn != null)
		{
			selectedBtn.selected = value;
			selectedBtn = null;
		}
		else
		{
			if (mainBtn.initialized) { mainBtn.selected = value; }
			else { mainBtn.firstSelect = true; }
			selectedBtn = mainBtn;
		}
	}
	
	public function removeList():Void
	{
		if (subFrame != null) { subFrame.removeMovieClip(); }
		subFrame = null;
		mainBtn.removeEventListener("click", this, "onMainBtnClick");
		for (var i:Number=0; i<subArr.length; i++)
		{
			subArr[i].removeEventListener("click", this, "onSubBtnClick");
    		subArr[i].removeMovieClip();
		}
		subFrameHeight = 0;
		subArr = [];
	}
	
	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			visible = false;
		}
		else
		{
			this.data = data;
			mainBtn.index = index;
			mainBtn.data = data;
			//mainBtn.setData(data);
			setSubBtn();
			visible = true;
		}
	}
	
	public function subOpen():Void
	{
		if (isSub == false) { return; }
		if (opened)
		{
			targetHeight = mainBtn._height;
			var changeHeight:Number = -((subArr.length*baseHeight) + subFrameOffset);
			TweenMax.to(
							subFrame,
							0.3,
							{
								_height:subFrameHeight,
								ease:Cubic.easeOut
							}
						);
			TweenMax.to(
							subArr[subArr.length-1],
							0.3,
							{
								_y:basePos,
								ease:Cubic.easeOut,
								onUpdate:Delegate.create(this, subOpenUpdate)
							}
						);
			opened = false;
		}
		else
		{
			targetHeight = mainBtn._height + (subArr.length*baseHeight) + subFrameOffset;
			var changeHeight:Number = subArr.length*baseHeight + subFrameOffset;
			TweenMax.to(
							subFrame,
							0.3,
							{
								_height:subArr.length*baseHeight + subFrameHeight + subFrameOffset,
								ease:Cubic.easeOut
							}
						);
			TweenMax.to(
							subArr[subArr.length-1],
							0.3,
							{
								_y:mainBtn._height+(subArr.length-1)*baseHeight,
								ease:Cubic.easeOut,
								onUpdate:Delegate.create(this, subOpenUpdate)
							}
						);
			opened = true;
		}
		dispatchEvent({type:"changeHeight", gap:changeHeight});
	}
	
	private function configUI():Void
	{
		super.configUI();
		enableInitCallback = false;
		mainBtn.addEventListener("click", this, "onMainBtnClick");
	}
	
	private function onMainBtnClick(e:Object):Void
	{
		//if (isSub && (selectedBtn == null || selectedBtn == mainBtn))
		subOpen();
		var isMine:Boolean = false;
		if (selectedBtn != null && selectedBtn != e.target) { selectedBtn.selected = false; isMine = true; }
		e.target.selected = true;
		selectedBtn = e.target;
		dispatchEvent({type:"itemClick", isMain:true, isMine:isMine});
	}
	
	private function subOpenUpdate(value:Boolean):Void
	{
		for (var i:Number=subArr.length-2; i>=0; i--)
		{
			if (subArr[i+1]._y - subArr[i]._height >= basePos)
			{
				subArr[i]._y = subArr[i+1]._y - subArr[i]._height; 
			}
			else
			{
				subArr[i]._y = basePos;
			}
		}
		dispatchEvent({type:"resizeItem", index:index});
	}
	
	private function setSubBtn():Void
	{
		if (data.sub == null || data.sub.length < 1) { return; }
		isSub = true;
		subArr = [];
		
		var subBg:MovieClip = this.attachMovie("eventDialogListItemSubBtnFrame", "subBg", getNextHighestDepth(), {_x:12, _width:216});
		subFrameHeight = subBg._height;
		subBg._y = mainBtn._height - subBg._height;
		subFrame = subBg;
		
		for (var i:Number=0; i<data.sub.length; i++)
		{
			var sub:MovieClip = this.attachMovie("eventDialogListItemSubBtn", "subBtn"+i, getNextHighestDepth(), {_x:18});
			sub._y = mainBtn._height - sub._height - subFrameOffset;
			sub.index = i;
			sub.data = data.sub[i];
			sub.addEventListener("click", this, "onSubBtnClick");
			sub.disableFocus = true;
			subArr.push(sub);
		}
		basePos = subArr[0]._y;
		baseHeight = subArr[0]._height;
		mainBtn.swapDepths(getNextHighestDepth());
	}
	
	private function onSubBtnClick(e:Object):Void
	{
		var isMine:Boolean = false; 
		if (selectedBtn != null && selectedBtn != e.target) { selectedBtn.selected = false; isMine = true; }
		e.target.selected = true;
		selectedBtn = e.target;
		dispatchEvent({type:"itemClick", isMain:false, isMine:isMine, subIndex:e.target.index});
	}
	
	
}