/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.udk.views.HudMainImmeRespawnPanel extends Panel
{
	public var immeRespawnCont:MovieClip;
	
    public function HudMainImmeRespawnPanel()
    {         
        super();
        
        immeRespawnCont.top.shortcut.textField.autoSize = true;
        immeRespawnCont.top.titleTxt.autoSize = true;
		initImmeRespawn();
    }
	
	public function showImmeRespawn(title:String, key:String):Void
	{
		initImmeRespawn();
		immeRespawnCont.top.titleTxt.text = title;
		
		if (key != null && key != "")
		{
			immeRespawnCont.top.shortcut._visible = true;
			immeRespawnCont.top.shortcut.textField.text = key;
			immeRespawnCont.top.shortcut.bg._width = Math.round(immeRespawnCont.top.shortcut.textField._width) + 17;
			immeRespawnCont.top.titleTxt._x = immeRespawnCont.top.shortcut._x + immeRespawnCont.top.shortcut._width + 2;
		}
		else
		{
			immeRespawnCont.top.shortcut._visible = false;
			immeRespawnCont.top.titleTxt._x = 0;
		}
		
		immeRespawnCont.top._x = immeRespawnCont.bg._width - immeRespawnCont.top._width >> 1;
		
		gotoAndPlay("show");
	}
	
	public function setImmeRespawnBar(time:Number, total:Number):Void
	{
		var targetAlpha:Number = 100 - (time/total*100);
		immeRespawnCont.top._alpha = targetAlpha;
		immeRespawnCont.bar._alpha = targetAlpha;
		immeRespawnCont.barBg._alpha = targetAlpha;
		immeRespawnCont.mask._width = (time / total) * immeRespawnCont.bar._width;
	}
	
	public function hideImmeRespawn():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{		
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}

	private function initImmeRespawn():Void
	{
		immeRespawnCont.mask._width = 0;
		immeRespawnCont.top.shortcut.textField.text = "";
		immeRespawnCont.top.titleTxt.text = "";
	}
	
	private function onCloseEnd():Void
	{
		initImmeRespawn();
	}
	
	
	
}