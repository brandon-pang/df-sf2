/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMaskPerFrame;
import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.PveBuffInfoSlot extends UIComponent
{
	public var slotCont:MovieClip;
	public var index:Number;
	
	private var _imgIndex:String;
	private var _imgName:String;
	private var mcLoader:MovieClipLoader;
	private var coolDownMask:CoolDownMaskPerFrame;
	
	private var imgPathArmor:String = "img://Imgset_Armor.";
	private var imgPathWeapon:String = "img://Imgset_Weapon.";
	private var imgPathUnit:String = "gfx_imgset_unitbox.swf";
	private var imgPathCashItem:String = "img://Imgset_CashItem.";
	private var imgPathBuffIcon:String = "img://Imgset_BuffIcon.";
	
    public function PveBuffInfoSlot()
    {         
        super();
        
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        
        slotCont.slotTxt.timeTxt.autoSize = true;
        slotCont.slotTxt.secTxt.autoSize = true;
        
        slotCont.slotTxt.timeTxt.noTranslate = true;
		slotCont.slotTxt.timeTxt.verticalAlign = "center";
		slotCont.slotTxt.secTxt.verticalAlign = "center";
    }
	
	public function setTime(time:Number, total:Number):Void
	{
		coolDownMask.start(time, total);
		/*
		var gap:Number = total - time;
		slotCont.slotTxt.timeTxt.text = Math.ceil(gap/1000).toString();
		slotCont.slotTxt.secTxt._x = Math.round(slotCont.slotTxt.timeTxt._width)-3;
		slotCont.slotTxt._x = (slotCont.bg._width - slotCont.slotTxt._width >> 1)+2;
		*/
	}
	
	public function lvLoader(imgIndex:String, imgName:String):Void
	{
		_imgIndex = imgIndex;
		_imgName = imgName;
		switch (imgIndex)
		{
			case "0" :
				mcLoader.loadClip(imgPathArmor+imgName, slotCont.loader);
				break;
				
			case "1" :
				var chk:String = imgName.substr(-4);
				if (chk == "_ani") { mcLoader.loadClip("Weapon_Ani/"+imgName+".swf", slotCont.loader); }
				else { mcLoader.loadClip(imgPathWeapon+imgName, slotCont.loader); }	
				break;
			
			case "2" :
				mcLoader.loadClip(imgPathUnit, slotCont.loader);
				break;
				
			case "3" :
				var chk:String = imgName.substr(-4);
				if (chk == "_ani") { mcLoader.loadClip("CashItem_Ani/"+imgName+".swf", slotCont.loader); }
				else { mcLoader.loadClip(imgPathCashItem+imgName, slotCont.loader); }
				break;
				
			case "7" :
				mcLoader.loadClip(imgPathBuffIcon+imgName, slotCont.loader);
				break;
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (_imgIndex == "0")
		{
			mc._x = -13;
			mc._y = 9;
			slotCont.loader._xscale = 35;
			slotCont.loader._yscale = 35;
		}
		else if (_imgIndex == "1")
		{
			mc._x = 0;
			mc._y = 17;
			slotCont.loader._xscale = 25;
			slotCont.loader._yscale = 25;
		}
		else if (_imgIndex == "2")
		{
			slotCont.loader.gotoAndStop(_imgName);
			slotCont.loader.img.gotoAndStop(2);
			mc._x = -1;
			mc._y = 4;
			slotCont.loader._xscale = 50;
			slotCont.loader._yscale = 50;
		}
		else if (_imgIndex == "3")
		{
			mc._x = 6;
			mc._y = 7;
			slotCont.loader._xscale = 40;
			slotCont.loader._yscale = 40;
		}
		else if (_imgIndex == "7")
		{
			mc._x = 7;
			mc._y = 7;
			slotCont.loader._xscale = 40;
			slotCont.loader._yscale = 40;
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		coolDownMask = new CoolDownMaskPerFrame(slotCont.coolDown, 41, 42, true);
		coolDownMask.setMaskColor(0x00000050, 0x00000050, 0);
		coolDownMask.addEventListener("coolDownEnd", this, "onCoolDownEnd");
		coolDownMask.addEventListener("coolDownProgress", this, "onCoolDownProgress");
	}
	
	private function onCoolDownEnd():Void
	{
		
	}
	
	private function onCoolDownProgress(e:Object):Void
	{
		var time:Number = Math.round(e.remainTime/1000);
		slotCont.slotTxt.timeTxt.text = time.toString();
		slotCont.slotTxt.secTxt._x = Math.round(slotCont.slotTxt.timeTxt._width)-3;
		slotCont.slotTxt._x = (slotCont.bg._width - slotCont.slotTxt._width >> 1)+2;
	}
	
	
}