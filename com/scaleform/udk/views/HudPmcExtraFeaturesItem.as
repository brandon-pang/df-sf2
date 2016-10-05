/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMaskPerFrame;
import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.views.HudPmcExtraFeaturesItem extends UIComponent
{
	public var codenameTxt:TextField;
	public var damageTxt:TextField;
	public var line:MovieClip;
	public var classicon:MovieClip;
	public var numbericon:MovieClip;
	public var killMesaage:MovieClip;
	
	private var _classicon:String;
	private var _manner:String;
	
	private var mcLoader:MovieClipLoader;
	
	private var _imgPathClass:String = "imgset_class.swf";
	
    public function HudPmcExtraFeaturesItem()
    {         
        super();
        
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
    }
	
	public function setItem(data:Object):Void
	{
		_manner = data.manner;
		_classicon = data.classicon;
		loadClassIcon();
		
		if (data.killed)
		{
			codenameTxt.textColor = 0xff0000;
			damageTxt.textColor = 0xff0000;
		}
		else
		{
			codenameTxt.textColor = 0xaeaeae;
			damageTxt.textColor = 0xffffff;
		}
		codenameTxt.text = data.codename;
		killMesaage.gotoAndStop(data.killMessage);
		damageTxt.text = data.damage.toString();
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function loadClassIcon():Void
	{
		if (_classicon.charAt(0) == "R")
		{
			numbericon._visible = true;
			numbericon.gotoAndStop(1);
			numbericon["txtNo"].text = _classicon.substring(1);
			mcLoader.unloadClip(classicon);

		}
		else if (_classicon.charAt(0) == "B")
		{
			numbericon._visible = true;
			numbericon.gotoAndStop(2);
			numbericon["txtNo"].text = _classicon.substring(1);
			mcLoader.unloadClip(classicon);

		}
		else
		{
			numbericon._visible = false;
			mcLoader.loadClip(_imgPathClass, classicon);
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classicon")
		{
			mc.set_level(_classicon);
			var manner:String = _manner;
//			var lvNo:String = _classicon;
//			var KD:String = lvNo.charAt(0);
//			var LV:String = lvNo.charAt(1);
//			var chkCl:String = lvNo.substr(2, 3);
//			var CL:String;
//			if (chkCl.charAt(0) == "0")
//			{
//				CL = chkCl.charAt(1);
//			}
//			else
//			{
//				CL = chkCl;
//			}
//			mc.lv0.gotoAndStop(Number(CL) + 1);
//			mc.lv1.gotoAndStop(Number(LV) + 1);
//			mc.lv2.gotoAndStop(Number(KD) + 1);

			if (manner == "4")
			{
				mc.manner.gotoAndStop(2);
			}
			else
			{
				mc.manner.gotoAndStop(1);
			}
			mc._xscale = 80;
			mc._yscale = 80;
		}
	}
}