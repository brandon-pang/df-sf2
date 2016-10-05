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
class com.scaleform.udk.controls.MyInfoChallengeListItem extends ListItemRenderer
{
	public var bg:MovieClip;
	
	public var titleTxt:TextField;
	public var demandTxt:TextField;
	public var mask:MovieClip;
	public var graphBar:MovieClip;
	public var graphBg:MovieClip;
	public var graphTxt:TextField;
	public var imgIcon:MovieClip;
	public var medalMC:MovieClip;
	
	private var ITEM_BASE_TARGETX:Number = 75;
	private var ITEM_BASE_POSX:Number = 322;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathChallenge:String = "img://Imgset_Challenge_Emblem.256.";
	
	private var medalFontColor:Array = [0xB2B2B2, 0xdead8d, 0xbababa, 0xffe671];
	
	public function MyInfoChallengeListItem()
	{
		super();
		
		bg.hitTestDisable = true;
	}

	public function setData(data:Object):Void
	{
		
		if (data == null)
		{
			this.data = null;
			//visible = false;
			mcLoader.unloadClip(imgIcon);
			graphTxt.text = "";
			mask._width = 0;
			titleTxt.text = "";
			demandTxt.text = "";
			medalMC.gotoAndStop(1);
			medalMC.numTxt.text = "";
			bg.gotoAndStop(2);
			graphBg._visible = false;
		}
		else
		{
			this.data = data;
			visible = true;
			bg.gotoAndStop(1);
			graphBg._visible = true;
			titleTxt.text = data.title;
			demandTxt.text = data.demand;
			graphTxt.text = "" + data.curNum + " / " + data.totalNum;
			if (data.medalType != null)
			{
				medalMC.gotoAndStop(data.medalType+1);
				medalMC.numTxt.textColor = medalFontColor[data.medalType];
				medalMC.numTxt.text = data.medalNum;
			}
			else
			{
				medalMC.gotoAndStop(1);
				medalMC.numTxt.text = "";
			}
			var targetW = data.curNum*graphBar._width/data.totalNum;
			mask._width = targetW;
			imgSetLoader();
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		mcLoader = new MovieClipLoader();
		titleTxt.verticalAlign = "center";
		titleTxt.textAutoSize = "shrink";
		demandTxt.verticalAlign = "center";
		demandTxt.textAutoSize = "shrink";
	}
	
	private function draw():Void
	{
		super.draw();
		imgIcon._xscale = 110;
		imgIcon._yscale = 110;
	}

	private function imgSetLoader():Void
	{
		mcLoader.loadClip(_imgPathChallenge+data.imgSet, imgIcon);
	}
	
	
}