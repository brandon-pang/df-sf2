/**
 * ...
 * @author 
 */

import com.scaleform.PveBuffInfoSlot;
import com.greensock.easing.*; 
import com.greensock.TweenMax;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveBuffInfo extends Panel
{
	public var pveBuffInfoCont:MovieClip;
	
	private var SLOT_UNIT:Number = 64;
	private var slotArr:Array = [];
	
	
    public function PveBuffInfo()
    {         
        super();
    }
	
	public function show(index:Number, imgIndex:String, imgName:String, itemName:String):Void
	{
		var slot:PveBuffInfoSlot = PveBuffInfoSlot(
														pveBuffInfoCont.attachMovie(
																						"pveBuffInfoSlot",
																						"pveBuffInfoSlot"+index,
																						pveBuffInfoCont.getNextHighestDepth(),
																						{_x:slotArr.length*SLOT_UNIT, index:index}
																					)
													);
		
		slot.addEventListener("closeEnd", this, "onSlotCloseEnd");
		slot.lvLoader(imgIndex, imgName);
		slot.slotCont.nameTxt.textAutoSize="shrink";
		if (itemName) { slot.slotCont.nameTxt.text = itemName; }
		slotArr.push(slot);
		slot.gotoAndPlay("show");
		pveBuffInfoCont.bg._width = slotArr.length*SLOT_UNIT;
		arrangeCont();
	}
	
	public function setTime(index:Number, time:Number, total:Number):Void
	{
		for (var i:Number=0; i<slotArr.length; i++)
		{
			if (slotArr[i].index == index)
			{
				slotArr[i].setTime(time, total);
				break;
			}
		}
		
		if (time >= total)
		{
			hide(index);
		}
	}
	
	public function hide(index):Void
	{
		for (var i:Number=0; i<slotArr.length; i++)
		{
			if (slotArr[i].index == index)
			{
				slotArr[i].gotoAndPlay("hide");
				break;
			}
		}
		slotArr.splice(i, 1);
		pveBuffInfoCont.bg._width = (slotArr.length==0)?SLOT_UNIT:slotArr.length*SLOT_UNIT;
		arrangeSlot(i);
		arrangeCont();
	}
	
	public function hideAll():Void
	{
		for (var i:Number=0; i<slotArr.length; i++)
		{
			hide(slotArr[i].index);
		}
		slotArr = [];
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function onSlotCloseEnd(e:Object):Void
	{
		e.target.removeEventListener("closeEnd", this, "onSlotCloseEnd");
		e.target.removeMovieClip();
	}
	
	private function arrangeCont():Void
	{
		TweenMax.killTweensOf(pveBuffInfoCont, true);
		var targetX:Number = (this._width - pveBuffInfoCont.bg._width) >> 1;
		TweenMax.to(
						pveBuffInfoCont,
						0.4,
						{
							_x:			targetX,
							ease:		Cubic.easeOut
						}
					);
	}
	
	private function arrangeSlot(index:Number):Void
	{
		for (var i:Number=index; i<slotArr.length; i++)
		{
			TweenMax.killTweensOf(slotArr[i], true);
		}
		for (var j:Number=index; j<slotArr.length; j++)
		{
			
			TweenMax.to(
							slotArr[j],
							0.3,
							{
								_x:			j*SLOT_UNIT,
								ease:		Cubic.easeOut
							}
						);
		}
	}
	
}