/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorModeTeamBoard extends Panel
{
	
	public var teamBoardCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	
	private var _teamColor:Number;
	private var ITEM_BASE_Y:Number = 0;
	private var ITEM_ROW_UNIT:Number = 57;
	
	private var itemArr:Array = [];
	private var _opened:Boolean = false;
	
    public function WarriorModeTeamBoard()
    {         
        super();
        mcLoader = new MovieClipLoader();
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setTeamColor(teamColor:Number):Void
	{
		_teamColor = teamColor;
	}
	
	public function addTeamItem(imgSet:String, level:String, codeName:String, hp:Number, totalHp:Number):Void
	{
		var item:MovieClip = teamBoardCont.attachMovie(
													"teamBoardItem",
													"teamBoardItem"+itemArr.length,
													teamBoardCont.getNextHighestDepth(),
													{_x:158, _y:ITEM_BASE_Y+(itemArr.length*ITEM_ROW_UNIT)}
												);
		if (_teamColor != null)
		{
			item.bg.gotoAndStop(_teamColor+2);
			item.levelBg.gotoAndStop(_teamColor+2);
		}
		mcLoader.loadClip(_imgPathPersonal+imgSet, item.slot.imgIcon);
		item.slot.index = itemArr.length;
		item.levelTxt.noTranslate = true;
		item.codeNameTxt.noTranslate = true;
		item.levelTxt.verticalAlign = "center";
		item.codeNameTxt.verticalAlign = "center";
		item.levelTxt.textAutoSize = "shrink";
		item.codeNameTxt.textAutoSize = "shrink";
		item.codeNameTxt.html = true;
		item.levelTxt.text = level;
		item.codeNameTxt.htmlText = codeName;
		
		var hpPer:Number = hp / totalHp * 100;
		item.hpBar._xscale = hpPer;
		
		if (_opened) { TweenMax.to(item, 0.5, {delay:itemArr.length/2*0.3, _x:0, ease:Cubic.easeOut}); }
		
		itemArr.push(item);
	}
	
	public function setTeamItem(index:Number, level:String, hp:Number, totalHp:Number):Void
	{
		if (itemArr[index] == null) { return; }
		itemArr[index].levelTxt.text = level;
		var hpPer:Number = hp / totalHp * 100;
		itemArr[index].hpBar._xscale = hpPer;
	}
	
	public function removeTeamItem(index:Number):Void
	{
		if (itemArr[index] == null) { return; }
		mcLoader.unloadClip(itemArr[index].slot.imgIcon);
		itemArr[index].removeMovieClip();
		itemArr.splice(index, 1);
		itemRange();
	}
	
	public function removeAllTeamItem():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			mcLoader.unloadClip(itemArr[i].slot.imgIcon);
			itemArr[i].removeMovieClip();
		}
		itemArr = [];
	}
	
	public function setTeamRespawn(index:Number, time:Number, total:Number):Void
	{
		if (itemArr[index] == null) { return; }
		
		if (!itemArr[index].slot._dead)
		{
			itemArr[index].slot._dead = true;
			itemArr[index].slot.imgIcon._alpha = 50;
			itemArr[index].levelTxt.textColor = 0x8c8c8c;
			itemArr[index].codeNameTxt.textColor = 0x8c8c8c;
			itemArr[index].bg.gotoAndStop(1);
			itemArr[index].levelBg.gotoAndStop(1);
		}
		
		itemArr[index].slot.setCoolDown(time, total);
		
		if (time == total)
		{
			itemArr[index].slot._dead = false;
			itemArr[index].slot.imgIcon._alpha = 100;
			itemArr[index].levelTxt.textColor = 0xffffff;
			itemArr[index].codeNameTxt.textColor = 0xffffff;
			itemArr[index].bg.gotoAndStop(_teamColor+2);
			itemArr[index].levelBg.gotoAndStop(_teamColor+2);
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		this.addEventListener("openEnd", this, "onOpenEnd");
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onOpenEnd():Void
	{
		_opened = true;
		
		for (var i:Number=0; i<itemArr.length; i++)
		{
			TweenMax.to(itemArr[i], 0.5, {delay:i/2*0.3, _x:0, ease:Cubic.easeOut});
		}
	}
	
	private function onCloseEnd():Void
	{
		_opened = false;
		_teamColor = null;
		removeAllTeamItem();
	}
	
	private function itemRange():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			itemArr[i]._y = ITEM_BASE_Y + (ITEM_ROW_UNIT*i);
		}
	}
}