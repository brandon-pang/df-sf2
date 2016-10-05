/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.scaleform.udk.views.PveWaitRoomMapExplainRankList;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.views.PveWaitRoomMapExplainRank extends UIComponent
{
	public var listCont:PveWaitRoomMapExplainRankList;
	public var opened:Boolean = false;
	
	private var POSY_CLOSE:Number = -341;
	private var POSY_OPEN:Number = 0;
	
	private var firstOpen:Boolean = false;
	private var isMoving:Boolean = false;
	
    public function PveWaitRoomMapExplainRank()
    {         
        super();  
    }
	
	public function initRank():Void
	{
		listCont._y = POSY_CLOSE;
		opened = false;
		isMoving = false;
		firstOpen = false;
		listCont.arrowBtn.visible = true;
		listCont.initList();
	}
	
	public function setRankTitle(imgSet:String, title:String, date:String):Void
	{
		listCont.setRankTitle(imgSet, title, date);
	}
	
	public function setRankList(arr:Array):Void
	{
		if (arr == null || arr.length == 0)
		{
			initRank();
			return;
		}
		listCont.setRankList(arr);
		if (!firstOpen) { startListOpen(); }
	}
	
	private function configUI():Void
	{
		super.configUI();
		listCont.addEventListener("arrowBtnClicked", this, "onArrowBtnClicked");
	}
	
	private function startListOpen():Void
	{
		listCont.arrowBtn.visible = true;
		firstOpen = true;
		TweenMax.to(
						listCont,
						0.4,
						{
							delay:		0.3,
							_y:			POSY_OPEN,
							ease:		Cubic.easeOut,
							onComplete:	Delegate.create(this, onListOpenComplete)
						}
					);
	}
	
	private function onArrowBtnClicked(e:Object):Void
	{
		if (isMoving) { return; }
		rankListOpen(opened);
		isMoving = true;
	}
	
	private function rankListOpen(value:Boolean):Void
	{
		if (value)
		{
			TweenMax.to(
						listCont,
						0.4,
						{
							_y:			POSY_CLOSE,
							ease:		Cubic.easeOut,
							onComplete:	Delegate.create(this, onListCloseComplete)
						}
					);
		}
		else
		{
			TweenMax.to(
						listCont,
						0.4,
						{
							_y:			POSY_OPEN,
							ease:		Cubic.easeOut,
							onComplete:	Delegate.create(this, onListOpenComplete)
						}
					);
		}
	}
	
	private function onListOpenComplete():Void
	{
		isMoving = false;
		opened = true;
		listCont.arrowBtn.selected = true;
	}
	
	private function onListCloseComplete():Void
	{
		isMoving = false;
		opened = false;
		listCont.arrowBtn.selected = false;
	}
}