/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.*; 
import com.greensock.TweenMax;
import gfx.controls.UILoader;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.MyInfoAchievementListItem extends ListItemRenderer
{
	public var imgIcon:MovieClip;
	public var starMC:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathChallenge:String = "img://Imgset_Challenge_Emblem.64.";
	
	private var starFontColor:Array = [0xd48b56, 0xa4c5cb, 0xffd73f];
	
	public function MyInfoAchievementListItem()
	{
		super();
	}

	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			mcLoader.unloadClip(imgIcon);
			_parent["itemBg"+((index%14)+1)]._visible = true;
			visible = false;
		}
		else
		{
			this.data = data;
			_parent["itemBg"+((index%14)+1)]._visible = false;
			visible = true;
			imgSetLoader();
			if (data.medalType != null)
			{
				starMC.gotoAndStop(data.medalType+1);
				starMC.numTxt.text = (data.medalType == 0)?"":data.medalNum;
				//var format:TextFormat = new TextFormat();
				//format.letterSpacing = -2;
				//format.color = starFontColor[data.medalType-1];
				//starMC.numTxt.setTextFormat(format);
				starMC.numTxt.textColor = starFontColor[data.medalType-1];
			}
			else
			{
				starMC.gotoAndStop(1);
				starMC.numTxt.text = "";
			}
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		mcLoader = new MovieClipLoader();
	}
	
	private function imgSetLoader():Void
	{
		mcLoader.loadClip(_imgPathChallenge+data.imgSet, imgIcon);
	}
	
}