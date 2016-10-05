/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.HudMainChallengeTaskBar;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.udk.views.HudMainChallengeTaskPanel extends Panel
{
	public var noticeBar:HudMainChallengeTaskBar;
	
	private var BASE_TIME:Number = 5000;
	private var UNIT_POSY:Number = -80;
	
	private var noticeBarArr:Array;
	
    public function HudMainChallengeTaskPanel()
    {         
        super();  
    }
	
	public function showChallengeTaskBar(data:Object, time:Number):Void
	{
		var noticeBar:HudMainChallengeTaskBar = getNoticeBar();
		if (time == null) { time = BASE_TIME; }
		else { time = time*1000; }
		noticeBar.show(data, time);
	}
	
	public function hideChallengeTaskBar():Void
	{
		for (var i:Number=0; i<noticeBarArr.length; i++)
		{
			noticeBarArr[i].hide();
		}
	}
	
	private function configUI():Void
	{		
		super.configUI();
		
		noticeBarArr = [noticeBar];
		
	}

	private function getNoticeBar():HudMainChallengeTaskBar
	{
		for (var i:Number=0; i<noticeBarArr.length; i++)
		{
			if (noticeBarArr[i].isUse == false)
			{ 
				noticeBarArr[i].isUse = true;
				return noticeBarArr[i];
			}
		}
		
		var noticeBar:HudMainChallengeTaskBar = HudMainChallengeTaskBar(
																			this.attachMovie(
																								"challengeNoticeBar",
																								"noticeBar"+noticeBarArr.length,
																								this.getNextHighestDepth()
																							)
																		);
		noticeBarArr.push(noticeBar);
		noticeBar._x = noticeBar.HIDE_POSX;
		noticeBar._y = UNIT_POSY * noticeBarArr.length;
		noticeBar.isUse = true;
		
		return noticeBar;
	}
	
	
	
	
	
}