/**
 * ...
 * @author 
 */

import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.CreepInfoItem extends UIComponent
{
	public var nameTxt:TextField;
	public var imgIcon:MovieClip;
	public var graph:MovieClip;
	public var help:MovieClip;
	
	private var data:Object;
	private var _imgPathPve:String = "gamedir://\\FlashMovie\\Image\\imgset\\gfx_imgset_personal_small.swf";
	private var graphWUnit:Number = 95;
	
    public function CreepInfoItem()
    {         
        super();  
    }
	
	public function initItem():Void
	{
		nameTxt.text = "";
		TweenMax.killTweensOf(graph.bar);
		graph.bar._x = 0;
	}
	
	public function setData(data:Object):Void
	{
		this.data = data;
		
		nameTxt.text = data.Name;
		setHP();
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		imgIcon._xscale = 40;
		imgIcon._yscale = 40;
		
		if (_root.designMode)
		{
			_imgPathPve = "gfxImgSet/gfx_imgset_personal_small.swf";
		}
	}
	
	private function setHP():Void
	{
		TweenMax.killTweensOf(graph.bar);
		var targetX:Number = data.Hp/100*graphWUnit-graphWUnit;
		TweenMax.to(graph.bar, 0.2, {_x:targetX, ease:Cubic.easeOut});
	}
}