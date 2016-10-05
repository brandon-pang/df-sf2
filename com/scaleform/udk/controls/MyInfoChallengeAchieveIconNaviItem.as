/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import gfx.controls.TileList;
import gfx.core.UIComponent;
 
class com.scaleform.udk.controls.MyInfoChallengeAchieveIconNaviItem extends UIComponent
{
			
	public var imgIcon:MovieClip;
	public var imgIconMC:MovieClip;		
	public var data:Object;
	private var mcLoader128:MovieClipLoader;
	private var _imgPathChallenge128:String = "img://Imgset_Challenge_Emblem.128.";
	private var mcLoader64:MovieClipLoader;
	private var _imgPathChallenge64:String = "img://Imgset_Challenge_Emblem.64.";
	private var posIndex:Number;
	private var index:Number;
	
    public function MyInfoChallengeAchieveIconNaviItem()
    {         
        super();  
    }
	
	public function setLoadIcon(list:TileList, index:Number, posIndex:Number):Void
	{
		this.index = index;
		this.posIndex = posIndex;
		list.dataProvider.requestItemAt(index, this, "onSetLoadIcon");
	}
	
	public function setUnLoadIcon():Void
	{
		mcLoader128.unloadClip(imgIcon);
		mcLoader64.unloadClip(imgIconMC.imgIconSmall.imgIcon);
		imgIconMC._visible = false;
		index = null;
		posIndex = null;
		data = null;
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		mcLoader128 = new MovieClipLoader();
		mcLoader64 = new MovieClipLoader();
		
		imgIconMC._visible = false;
	}
	
	private function onSetLoadIcon(data:Object):Void
	{
		this.data = data;
		if (posIndex == 5)
		{
			mcLoader64.unloadClip(imgIconMC.imgIconSmall.imgIcon);
			mcLoader128.loadClip(_imgPathChallenge128+data.imgSet, imgIcon);
			imgIconMC._visible = false;
		}
		else
		{
			mcLoader128.unloadClip(imgIcon);
			mcLoader64.loadClip(_imgPathChallenge64+data.imgSet, imgIconMC.imgIconSmall.imgIcon);
			imgIconMC._visible = true;
		}
	}
	
	
}