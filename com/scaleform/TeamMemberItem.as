/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMask;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.TeamMemberItem extends UIComponent
{
	public var nameTxt:TextField;
	public var imgIcon:MovieClip;
	public var graph:MovieClip;
	public var help:MovieClip;
	public var bg:MovieClip;
	public var coolDown:MovieClip;
	public var coolTxt:TextField;
	
	private var data:Object;
	private var _imgPathPve:String = "img://Imgset_Personal.";
	private var mcLoader:MovieClipLoader;
	private var graphWUnit:Number = 106;
	
	private var coolDownMask:CoolDownMask;
	
    public function TeamMemberItem()
    {         
        super();
        
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
    }
	
	public function initItem():Void
	{
		mcLoader.unloadClip(imgIcon.loader);
		nameTxt.text = "";
		TweenMax.killTweensOf(graph);
		graph._width = graphWUnit;
		help.gotoAndStop(1);
		setAlpha(100);
		coolRemove();
	}
	
	public function setData(data:Object):Void
	{
		this.data = data;
		
		mcLoader.loadClip(_imgPathPve+data.ImgSet, imgIcon.loader);
		
		nameTxt.text = data.Name;
		
		setHP();
		
		if (data.Help == -1 && data.Respawn == -1)
		{
			setAlpha(100);
			help.gotoAndStop(1);
			if (coolDownMask._progressed)
			{
				coolRemove();
			}
		}
		else if (data.Help != -1 && data.Respawn == -1)
		{
			setAlpha(50);
			help.gotoAndPlay("show");
			coolStart(0, data.Help);
		}
		else if (data.Help == -1 && data.Respawn != -1)
		{
			setAlpha(50);
			help.gotoAndStop(1);
			coolStart(0, data.Respawn);
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		nameTxt.noTranslate = true;
		coolTxt.noTranslate = true;
		
		//imgIcon._xscale = 58;
		//imgIcon._yscale = 59;
		
		coolDownMask = new CoolDownMask(coolDown, 30, 30, false);
		coolDownMask.setMaskColor(0x00000050, 0x00000050, 0);
		coolDownMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		mc._width = 33;
		mc._height = 32;
	}
	
	private function setHP():Void
	{
		TweenMax.killTweensOf(graph);
		var targetW:Number = data.Hp/100*graphWUnit;
		TweenMax.to(graph, 0.2, {_width:targetW, ease:Cubic.easeOut});
	}
	
	private function setAlpha(value:Number):Void
	{
		bg._alpha = value;
		graph._alpha = value;
		nameTxt._alpha = value;
	}
	
	private function coolStart(deltaTime:Number, coolTime:Number):Void
	{
		coolDownMask.start(deltaTime, coolTime);
	}
	
	private function coolRemove():Void
	{
		coolTxt.text = "";
		if (coolDownMask) {
			coolDownMask.reset();
			imgIcon.gotoAndPlay("show");
		}
	}
	
	private function onCoolDownEnd():Void
	{
		coolTxt.text = "";
		help.gotoAndStop(1);
		imgIcon.gotoAndPlay("show");
	}
	
	private function onCoolDownProgress(e:Object):Void
	{
		var time:Number = Math.round(e.remainTime/1000);
		coolTxt.text = time.toString();
	}
	
}