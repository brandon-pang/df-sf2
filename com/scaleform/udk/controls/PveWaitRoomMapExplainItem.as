/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import flash.external.ExternalInterface;
[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.PveWaitRoomMapExplainItem extends UIComponent
{
	public var imgIcon:MovieClip;
	
	private var imgSet:String;
	private var imgPathExplain:String = "img://Imgset_Pve_MapExplain.";
	private var mcLoader:MovieClipLoader;
	
    public function PveWaitRoomMapExplainItem()
    {         
        super();  
        mcLoader = new MovieClipLoader();
    }
	
	public function setData(imgSet:String):Void
	{
		if (imgSet == null)
		{
			this._visible = false;
			return;
		}
		
		this.imgSet = imgSet;
		this._visible = true;
		
		lvLoader();
	}
	
	private function configUI():Void
	{
		super.configUI();		
		imgIcon._xscale = 110;
		hitArea.onRelease = function() {
			var n = this._parent._name.substr( -1);
			ExternalInterface.call("PveMapExplainClick", n);
		}
	}
	
	private function lvLoader():Void
	{
		if (_global.gfxPlayer) {
			imgPathExplain = "D:/UI_DESIGN_SVN/이미지셋/PVE/"+imgSet+".png";
		}else {
			imgPathExplain = "img://Imgset_Pve_MapExplain."+imgSet;
		}
		
		mcLoader.loadClip(imgPathExplain, imgIcon);			
	}
	
	
	
}