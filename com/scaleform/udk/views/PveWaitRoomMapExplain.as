/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.PveWaitRoomMapExplainRank;
import com.scaleform.udk.controls.PveWaitRoomMapExplainScroll;
import com.scaleform.udk.views.PveWaitRoomMapExplainCont;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.views.PveWaitRoomMapExplain extends UIComponent
{
	public var mapTitleTxt:TextField;
	public var explainCont:PveWaitRoomMapExplainCont;
	public var scrollBg:PveWaitRoomMapExplainScroll;
	public var frame:MovieClip;
	public var ranking:PveWaitRoomMapExplainRank;

	public function PveWaitRoomMapExplain()
	{
		super();
	}

	public function initExplain():Void
	{
		explainCont.resetCont();
		ranking.initRank();
	}

	public function setMapTitle(title:String):Void
	{
		mapTitleTxt.text = title;
	}

	public function setMapExplain(arr:Array):Void
	{
		explainCont.setMapExplain(arr);
	}

	public function prevExplain():Void
	{
		explainCont.prevExplain();
	}

	public function nextExplain():Void
	{
		explainCont.nextExplain();
	}

	public function setRankTitle(imgSet:String, title:String, date:String):Void
	{
		ranking.setRankTitle(imgSet,title,date);
	}

	public function setRankList(arr:Array):Void
	{
		ranking.setRankList(arr);
	}

	private function configUI():Void
	{
		super.configUI();
		frame.hitTestDisable = true;
		scrollBg.addEventListener("scrollWheel",this,"onIconNaviScrollWheel");
		mapTitleTxt.noTranslate = true;
	}

	private function onIconNaviScrollWheel(e:Object):Void
	{
		if (ranking.opened)
		{
			return;
		}
		
		if (e.delta == 1)
		{
			prevExplain();
		}
		else if (e.delta == -1)
		{
			nextExplain();
		}
	}
}