/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import flash.geom.Rectangle;
import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorModeQuest extends Panel
{
	
	public var questCont:MovieClip;
	
	private var itemArr:Array;
	
    public function WarriorModeQuest()
    {         
        super();
        
        itemArr = [];
        
        var format:TextFormat = new TextFormat();
		format.italic = true;
		
		questCont.titleTxt.text = "_quest_title";
		questCont.titleTxt.setTextFormat(format);
		questCont.titleTxt.setNewTextFormat(format);
    }
	
	public function show(data:Array):Void
	{
		removeAllItem();
		
		for (var i:Number=0; i<data.length; i++)
		{
			var item:MovieClip = questCont.attachMovie("warriorModeQuestListItem", "warriorModeQuestListItem"+i, questCont.getNextHighestDepth());
			item.itemCont.textField.noTranslate = true;
			item.itemCont.textField.verticalAlign = "center";
			item.itemCont.textField.textAutoSize="shrink";
			item.itemCont.icon.gotoAndStop(data[i].index+1);
			item.itemCont.textField.text = data[i].title;
			item._x = 163;
			if (i == 0)
			{
				item._y = 26;
			}
			else
			{
				item._alpha = 70;
				item._xscale = 80;
				item._yscale = 80;
				item._y = itemArr[itemArr.length-1]._y + itemArr[itemArr.length-1]._height;
			}
			item.index = data[i].index;
			item.addEventListener("openEnd", this, "onItemOpenEnd");
			itemArr.push(item);
		}
		
		gotoAndPlay("show");
	}
	
	public function questComplete(index:Number):Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			if (index == itemArr[i].index)
			{
				itemArr[i]._alpha = 100;
				itemArr[i].itemCont.textField.textColor = 0x474747;
				itemArr[i].itemCont.bg.gotoAndStop(2);
				itemArr[i].itemCont.check.gotoAndStop(2);
				itemArr[i].gotoAndPlay("show");
				break;
			}
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function onItemOpenEnd(e:Object):Void
	{
		var order:Number;
		for (var i:Number=0; i<itemArr.length; i++)
		{
			if (e.target == itemArr[i])
			{
				itemArr.splice(i, 1);
				order = i;
				break;
			}
		}
		
		e.target.removeEventListener("openEnd", this, "onItemOpenEnd");
		e.target.removeMovieClip();
		
		if (order == 0)
		{
			TweenMax.to(
							itemArr[order],
							0.3,
							{
								_y:26,
								_alpha:100,
								_xscale:100,
								_yscale:100,
								ease:Cubic.easeOut,
								onUpdate:Delegate.create(this, onItemTweenUpdate),
								onUpdateParams:[order]
							}
						);
		}
		else if (order > 0 && order < itemArr.length)
		{
			TweenMax.to(
							itemArr[order],
							0.3,
							{
								_y:itemArr[order-1]._y + itemArr[order-1]._height,
								ease:Cubic.easeOut,
								onUpdate:Delegate.create(this, onItemTweenUpdate),
								onUpdateParams:[order]
							}
						);
		}
	}
	
	private function onItemTweenUpdate(order:Number):Void
	{
		for (var i:Number=order+1; i<itemArr.length; i++)
		{
			itemArr[i]._y = itemArr[i-1]._y + itemArr[i-1]._height;
		}
	}
	
	private function removeAllItem():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			itemArr[i].removeEventListener("openEnd", this, "onItemOpenEnd");
			itemArr[i].removeMovieClip();
		}
		itemArr = [];
	}
}