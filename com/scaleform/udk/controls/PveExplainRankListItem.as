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
class com.scaleform.udk.controls.PveExplainRankListItem extends ListItemRenderer
{
	public var bg:MovieClip;
	public var imgIcon0:MovieClip;
	public var imgIcon1:MovieClip;
	public var imgIcon2:MovieClip;
	public var imgIcon3:MovieClip;
	public var codeNameTxt0:TextField;
	public var codeNameTxt1:TextField;
	public var codeNameTxt2:TextField;
	public var codeNameTxt3:TextField;
	public var divide:MovieClip;
	public var star:MovieClip;
	
	public var scoreTxt:TextField;
	public var scoreUnitTxt:TextField;
	public var difficultyTxt:TextField;
	
	private var mcLoader:MovieClipLoader;
	private var imgLoaded0:Boolean = false;
	private var imgLoaded1:Boolean = false;
	private var imgLoaded2:Boolean = false;
	private var imgLoaded3:Boolean = false;
	
	public function PveExplainRankListItem()
	{
		super();
		
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		var format:TextFormat = new TextFormat();
		format.italic = true;
		
		codeNameTxt0.setTextFormat(format);
		codeNameTxt0.setNewTextFormat(format);
		codeNameTxt1.setTextFormat(format);
		codeNameTxt1.setNewTextFormat(format);
		codeNameTxt2.setTextFormat(format);
		codeNameTxt2.setNewTextFormat(format);
		codeNameTxt3.setTextFormat(format);
		codeNameTxt3.setNewTextFormat(format);
		
		codeNameTxt0.noTranslate = true;
		codeNameTxt1.noTranslate = true;
		codeNameTxt2.noTranslate = true;
		codeNameTxt3.noTranslate = true;
		scoreTxt.noTranslate = true;
		difficultyTxt.noTranslate = true;
		codeNameTxt0.verticalAlign = "center";
		codeNameTxt1.verticalAlign = "center";
		codeNameTxt2.verticalAlign = "center";
		codeNameTxt3.verticalAlign = "center";
		scoreTxt.verticalAlign = "center";
		scoreUnitTxt.verticalAlign = "center";
		difficultyTxt.verticalAlign = "center";

		codeNameTxt0.textAutoSize = "shrink";
		codeNameTxt1.textAutoSize = "shrink";
		codeNameTxt2.textAutoSize = "shrink";
		codeNameTxt3.textAutoSize = "shrink";
		scoreTxt.textAutoSize = "shrink";
		scoreUnitTxt.textAutoSize = "shrink";
		difficultyTxt.textAutoSize = "shrink";
		
		scoreTxt.autoSize = true;
		scoreUnitTxt.autoSize = true;
		
		scoreUnitTxt.text = "_tutorialTxt_jum";
	}

	public function setData(data:Object):Void
	{
		
		if (data == null)
		{
			this.data = null;
			visible = false;
		}
		else
		{
			this.data = data;
			visible = true;
			imgSetLoader();
			setCodeName();
			scoreTxt.text = data.Score;
			difficultyTxt.text = data.Difficulty;
			if (data.Rank == 1)
			{
				bg.gotoAndStop(2);
				divide.gotoAndStop(2);
				scoreTxt.textColor = 0xfdb658;
				scoreUnitTxt.textColor = 0xfdb658;
			}
			else if (data.Rank == 2)
			{
				bg.gotoAndStop(2);
				divide.gotoAndStop(2);
				scoreTxt.textColor = 0xffffff;
				scoreUnitTxt.textColor = 0xffffff;
			}
			else if (data.Rank == 3)
			{
				bg.gotoAndStop(2);
				divide.gotoAndStop(2);
				scoreTxt.textColor = 0xffffff;
				scoreUnitTxt.textColor = 0xffffff;
			}
			else
			{
				bg.gotoAndStop(1);
				divide.gotoAndStop(1);
				scoreTxt.textColor = 0xffffff;
				scoreUnitTxt.textColor = 0xffffff;
			}
			star.gotoAndStop(data.Rank);
			scoreUnitTxt._x = scoreTxt._x + Math.round(scoreTxt._width) - 3;
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function draw():Void
	{
		super.draw();
	}

	private function imgSetLoader():Void
	{
		for (var i:Number=0; i<4; i++)
		{
			if (data.PlayerInfo[i].ClassIcon != null)
			{
				this["imgIcon"+i]._visible = true;
				if (this["imgLoaded"+i]) { onLoadInit(this["imgIcon"+i]); }
				else { mcLoader.loadClip("imgset_class.swf", this["imgIcon"+i]); }
			}
			else
			{
				this["imgIcon"+i]._visible = false;
			}
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		var iconNum:Number = Number(mc._name.substr(-1, 1));
		var lvNo:String = data.PlayerInfo[iconNum].ClassIcon;
		mc.set_level(lvNo)		
		this["imgLoaded"+iconNum] = true;
	}
	
	private function setCodeName():Void
	{
		for (var i:Number=0; i<4; i++)
		{
			if (data.PlayerInfo[i].CodeName != null)
			{
				this["codeNameTxt"+i].text = data.PlayerInfo[i].CodeName;
			}
			else
			{
				this["codeNameTxt"+i].text = "";
			}
		}
	}
	
	
}