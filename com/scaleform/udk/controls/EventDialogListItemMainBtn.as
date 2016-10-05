/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import gfx.utils.Delegate;
import com.greensock.easing.*; 
import com.greensock.TweenMax;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
class com.scaleform.udk.controls.EventDialogListItemMainBtn extends Button
{
	public var titleMC:MovieClip;
	public var perTxt:TextField;
	public var dateTxt:TextField;
	public var bg:MovieClip;
	public var check:MovieClip;
	public var icon:MovieClip;
	public var arrow:MovieClip;
	public var subBg:MovieClip;
	public var back:MovieClip;
	
	public var firstSelect:Boolean = false;
	public var index:Number;
	public var opened:Boolean = false;
	public var targetHeight:Number;
	
	private var txtColor:Number = 0x000000;

	public function EventDialogListItemMainBtn()
	{
		super();
		
		//titleTxt.verticalAlign = "center";
		titleMC.titleTxt.autoSize = true;
		titleMC.titleTxt.noTranslate = true;
		perTxt.verticalAlign = "center";
		perTxt.noTranslate = true;
		dateTxt.noTranslate = true;
		//check._visible = false;
		
		var format:TextFormat = new TextFormat();
		format.italic = true;
		dateTxt.setTextFormat(format);
		dateTxt.setNewTextFormat(format);
		
		arrow._visible = false;
		arrow.hitTestDisable = true;
		
		targetHeight = this._height;
	}
	
	[Inspectable(defaultValue="false")]
	public function get selected():Boolean { return _selected; }
	public function set selected(value:Boolean):Void
	{        
		super.selected = value;
		arrow._visible = value;
		if (value) { titleMC.titleTxt.textColor=txtColor; }
		else { titleMC.titleTxt.textColor=0x000000; }
		
	}
	
	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			visible = false;
			TweenMax.killTweensOf(titleMC.titleTxt);
		}
		else
		{
			this.data = data;
			visible = true;
			TweenMax.killTweensOf(titleMC.titleTxt);
			titleMC.titleTxt.text = data.title;
			perTxt.htmlText = data.percent.toString()+ "<font size='11'>%</font>";
			dateTxt.text = data.date;
			//0:none //1:Clear //2:Waiting //3:Progress
			check.gotoAndStop(Number(data.ChkStat)+1);
			var num:Number;
			if (data.percent >= 0 && data.percent < 20) { num = 1; txtColor = 0xa64000; }
			else if (data.percent >= 20 && data.percent < 60) { num = 2; txtColor = 0x2da601; }
			else if (data.percent >= 60 && data.percent < 100) { num = 3; txtColor = 0x0066a6; }
			else if (data.percent == 100) { num = 4; txtColor = 0x2c2c2c; }
			else if (data.percent == -1) { num = 5; txtColor = 0x000000; perTxt.htmlText = ""; }
			icon.gotoAndStop(num);
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		enableInitCallback = false;
		
		if (data) { setData(data); }
		if (firstSelect) { selected = true; }
	}
	
	private function tweenTitle(value:Boolean):Void
	{
		if (titleMC.mask._width >= titleMC.titleTxt._width) { return; }
		if (value)
		{
			var targetX:Number = -titleMC.titleTxt._width;
			var duration:Number = (titleMC.titleTxt._width+titleMC.titleTxt._x)*0.014;
			TweenMax.killTweensOf(titleMC.titleTxt);
			TweenMax.to(titleMC.titleTxt, duration, {
												_x:targetX,
												ease:Linear.easeNone,
												onComplete:	Delegate.create(this, onTxtTweenComplete)
												}
						);
		}
		else
		{
			TweenMax.killTweensOf(titleMC.titleTxt);
			titleMC.titleTxt._x = 0;
		}
	}
	
	private function onTxtTweenComplete():Void
	{
		titleMC.titleTxt._x = titleMC.mask._width;
		tweenTitle(true);
	}
	
	private function handleMouseRollOver(controllerIdx:Number):Void
	{
		super.handleMouseRollOver(controllerIdx);
		tweenTitle(true);
	}
	
	private function handleMouseRollOut(controllerIdx:Number):Void
	{
		super.handleMouseRollOut(controllerIdx);
		tweenTitle(false);
	}
	
	private function handleDragOut(controllerIdx:Number, button:Number):Void
	{
		super.handleDragOut(controllerIdx, button);
		tweenTitle(false);
	}	
	
	private function handleReleaseOutside(controllerIdx:Number, button:Number):Void
	{	
		super.handleReleaseOutside(controllerIdx, button);
		tweenTitle(false);
	}
}