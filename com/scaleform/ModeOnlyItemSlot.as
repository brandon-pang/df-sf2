/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ModeOnlyItemSlot extends Panel
{
	public var itemSlotCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	
    public function ModeOnlyItemSlot()
    {         
		super();
		itemSlotCont.shortCut0._visible = false;
		itemSlotCont.shortCut1._visible = false;
		
		mcLoader = new MovieClipLoader();
    }
	
	public function show(actImgSet0:String, actImgSet1:String, pasImgSet0:String, pasImgSet1:String):Void
	{
		loadImgSet(actImgSet0, actImgSet1, pasImgSet0, pasImgSet1);
		gotoAndPlay("show");
	}
	
	public function setShortCut(index:Number):Void
	{
		if (index == 0)
		{
			itemSlotCont.shortCut0._visible = true;
			itemSlotCont.shortCut1._visible = false;
		}
		else if (index == 1)
		{
			itemSlotCont.shortCut0._visible = false;
			itemSlotCont.shortCut1._visible = true;
		}
		else if (index == -1)
		{
			itemSlotCont.shortCut0._visible = false;
			itemSlotCont.shortCut1._visible = false;
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		itemSlotCont.shortCut0._visible = false;
		itemSlotCont.shortCut1._visible = false;
		
		mcLoader.unloadClip(itemSlotCont.actImgIcon0);
		mcLoader.unloadClip(itemSlotCont.actImgIcon1);
		mcLoader.unloadClip(itemSlotCont.pasImgIcon0);
		mcLoader.unloadClip(itemSlotCont.pasImgIcon1);
	}
	
	private function loadImgSet(actImgSet0:String, actImgSet1:String, pasImgSet0:String, pasImgSet1:String):Void
	{
		if (actImgSet0 != null && actImgSet0 != "")
		{
			var chk = actImgSet0.substr(-4);
			var imgPath:String;
			if(chk == "_ani") { imgPath = "CashItem_Ani/" + actImgSet0 + ".swf"; }
			else { imgPath = "img://Imgset_CashItem."+actImgSet0; }
			mcLoader.loadClip(imgPath, itemSlotCont.actImgIcon0);
		}
		else
		{
			mcLoader.unloadClip(itemSlotCont.actImgIcon0);
		}
		
		if (actImgSet1 != null && actImgSet1 != "")
		{
			var chk = actImgSet1.substr(-4);
			var imgPath:String;
			if(chk == "_ani") { imgPath = "CashItem_Ani/" + actImgSet1 + ".swf"; }
			else { imgPath = "img://Imgset_CashItem."+actImgSet1; }
			mcLoader.loadClip(imgPath, itemSlotCont.actImgIcon1);
		}
		else
		{
			mcLoader.unloadClip(itemSlotCont.actImgIcon1);
		}
		
		if (pasImgSet0 != null && pasImgSet0 != "")
		{
			var chk = pasImgSet0.substr(-4);
			var imgPath:String;
			if(chk == "_ani") { imgPath = "CashItem_Ani/" + pasImgSet0 + ".swf"; }
			else { imgPath = "img://Imgset_CashItem."+pasImgSet0; }
			mcLoader.loadClip(imgPath, itemSlotCont.pasImgIcon0);
		}
		else
		{
			mcLoader.unloadClip(itemSlotCont.pasImgIcon0);
		}
		
		if (pasImgSet1 != null && pasImgSet1 != "")
		{
			var chk = pasImgSet1.substr(-4);
			var imgPath:String;
			if(chk == "_ani") { imgPath = "CashItem_Ani/" + pasImgSet1 + ".swf"; }
			else { imgPath = "img://Imgset_CashItem."+pasImgSet1; }
			mcLoader.loadClip(imgPath, itemSlotCont.pasImgIcon1);
		}
		else
		{
			mcLoader.unloadClip(itemSlotCont.pasImgIcon1);
		}
	}
	
}