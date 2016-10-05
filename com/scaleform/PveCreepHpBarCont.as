/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.PveCreepHpBarCont extends UIComponent
{
	public var nameTxt:TextField;
	public var graph:MovieClip;
	
	public var high:Number = 30;
	public var middle:Number = 40;
	public var low:Number = 30;
	
	private var ORIG_WiDTH:Number = 223;
	
    public function PveCreepHpBarCont()
    {         
        super();  
    }
	
	public function initCont():Void
	{
		nameTxt.text = "";
		high = 30;
		middle = 40;
		low = 30;
		TweenMax.killTweensOf(graph);
	}
	
	public function setName(value:String):Void
	{
		nameTxt.text = value;
	}
	
	public function setHp(hp:Number, totalHp:Number):Void
	{
		TweenMax.killTweensOf(graph);
		var targetW:Number = hp/totalHp*ORIG_WiDTH;
		TweenMax.to(
						graph,
						0.2,
						{
							_width:targetW,
							ease:Cubic.easeOut,
							onUpdate:Delegate.create(this, onGraphTweenUpdate),
							//onUpdateParams:[i],
							onComplete:Delegate.create(this, onGraphTweenComplete)
							//onCompleteParams:[i]
						}
					);
		graph.mc0.gotoAndPlay("show");
		graph.mc1.gotoAndPlay("show");
		graph.mc2.gotoAndPlay("show");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		nameTxt.noTranslate = true;
	}
	
	private function onGraphTweenUpdate():Void
	{
		var targetH:Number = ORIG_WiDTH * (100-high) / 100;
		var targetM:Number = ORIG_WiDTH * low / 100;
		
		if (graph._width >= targetH)
		{
			//graph.gotoAndStop(1);
			graph.mc0._visible = true;
			graph.mc1._visible = false;
			graph.mc2._visible = false;
		}
		else if (graph._width < targetH && graph._width >= targetM)
		{
			//graph.gotoAndStop(2);
			graph.mc0._visible = false;
			graph.mc1._visible = true;
			graph.mc2._visible = false;
		}
		else if (graph._width < targetM && graph._width >= 0)
		{
			//graph.gotoAndStop(3);
			graph.mc0._visible = false;
			graph.mc1._visible = false;
			graph.mc2._visible = true;
		}
	}
	
	private function onGraphTweenComplete():Void
	{
		graph.mc0.gotoAndPlay(1);
		graph.mc1.gotoAndPlay(1);
		graph.mc2.gotoAndPlay(1);
	}
	
	
	
	
	
}