/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.controls.RadioButton;
import gfx.utils.Delegate;
import com.greensock.easing.Linear;
import com.greensock.TweenMax;
import gfx.controls.CheckBox;
import gfx.controls.TextInput;
import gfx.managers.FocusHandler;
import gfx.controls.TextArea;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.SpectatorDecoDialogContents extends UIComponent
{
	public var titleTxt:TextField;
	public var imgIcon:MovieClip;
	public var itemNameTxt:TextField;
	public var explainTxt:TextField;
	
	public var styleTxt:TextField;
	public var styleRadio0:RadioButton;
	public var styleRadio1:RadioButton;
	public var styleRadio2:RadioButton;
	public var styleRadio3:RadioButton;
	public var styleRadio4:RadioButton;
	public var styleRadio5:RadioButton;
	
	public var type0:MovieClip;
	public var type1:MovieClip;
	
	public var effectTxt:TextField;
	public var effectRadio0:RadioButton;
	public var effectRadio1:RadioButton;
	
	public var inputComment:TextInput;
	public var inputCharTxt:TextField;
	public var commentCheckMC:MovieClip;
	
	public var colorTxt:TextField;
	public var colorRadio0:RadioButton;
	public var colorRadio1:RadioButton;
	public var colorRadio2:RadioButton;
	public var colorRadio3:RadioButton;
	public var colorRadio4:RadioButton;
	public var colorRadio5:RadioButton;
	public var colorRadio6:RadioButton;
	
	public var effectFlickerTxt:TextField;
	public var flickerCheck:CheckBox;
	public var previewMC:MovieClip;
	public var previewBtn:Button;
	
	public var btnOk:Button;
	public var btnCancel:Button;
	
	private var mcLoader:MovieClipLoader;
	private var imgPathCashItem:String = "img://Imgset_CashItem.";
	
	private var typeStyleArr:Array = [{name:"CashItem_spec_text_00", num:1}, {name:"CashItem_spec_text_01", num:1}];
	
	private var typeIndex:Number;
	private var styleCount:Number;
	private var _styleNum:Number = 0;
	
	private var effectRadioWidth:Number;
	private var tmpColor:Number = 0;
	private var _colorNum:Number = 0;
	private var _fontColor:Array = [];
	private var isPreview:Boolean = false;
	private var previewOpen:Boolean = false;
	
	private var initState:Boolean = false;
	
	public function SpectatorDecoDialogContents()
	{         
		super();
		
		titleTxt.verticalAlign = "center";
		titleTxt.text = "_cashItemDialogTitle";
		
		itemNameTxt.noTranslate = true;
    	explainTxt.noTranslate = true;
		
		styleTxt.textAutoSize="shrink";
		styleTxt.text = "_spectator_style";
		
		type0._visible = false;
		type0.textMC.normalTxt.noTranslate = true;
		type0.textMC.normalTxt.verticalAlign = "center";
		
		type0.textMC.aniMC.aniTxt.autoSize = true;
		type0.textMC.aniMC.aniTxt.verticalAlign = "center";
		
		type1._visible = false;
		type1.textMC.normalTxt.noTranslate = true;
		type1.textMC.normalTxt.verticalAlign = "center";
		//type1.textMC.normalTxt.textAutoSize="shrink";
		
		effectTxt.textAutoSize="shrink";
		effectTxt.text = "_spectator_effect_color";
		
		inputComment.textField.noTranslate = true;
		inputCharTxt.noTranslate = true;
		
		colorTxt.textAutoSize="shrink";
		colorTxt.text = "_spectator_color";
		
		effectFlickerTxt.textAutoSize="shrink";
		effectFlickerTxt.text = "_spectator_effect_apply";
		
		previewMC.type0.textMC.normalTxt.noTranslate = true;
		previewMC.type0.textMC.normalTxt.verticalAlign = "center";
		
		previewMC.type0.textMC.aniMC.aniTxt.autoSize = true;
		previewMC.type0.textMC.aniMC.aniTxt.noTranslate = true;
		previewMC.type0.textMC.aniMC.aniTxt.verticalAlign = "center";
		
		previewMC.type1.textMC.normalTxt.noTranslate = true;
		previewMC.type1.textMC.normalTxt.verticalAlign = "center";
		//previewMC.type1.textMC.normalTxt.textAutoSize = "shrink";
		
		
		
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
	}
    
    public function initCont():Void
    {
    	mcLoader.unloadClip(imgIcon);
    	itemNameTxt.text = "";
    	explainTxt.text = "";
    	
    	setStyle(1);
    	styleRadio0.group.setSelectedButton(styleRadio0);
    	_styleNum = 0;
    	
    	type0._visible = false;
    	TweenMax.killTweensOf(type0.textMC.aniMC.aniTxt);
    	type0.textMC.normalTxt.htmlText = "";
    	type0.textMC.aniMC.aniTxt.htmlText = "";
    	type0.textMC.aniMC.aniTxt._x = 0;
    	type0.bgMC.gotoAndStop(1);
    	
    	type1._visible = false;
    	type1.textMC.normalTxt.htmlText = "";
    	type1.bgMC.gotoAndStop(1);
    	
    	typeIndex = null;
    	styleCount = null;
    	
    	tmpColor = 0;
    	effectRadio0.group.setSelectedButton(effectRadio0);
    	_colorNum = 0;
    	_fontColor = [];
    	
    	inputComment.text = "";
    	inputCharTxt.text = "";
    	commentCheckMC.textField.text = "";
    	commentCheckMC.gotoAndStop(1);
    	
    	setColorRadio(0);
    	colorRadio0.group.setSelectedButton(colorRadio0);
    	
    	flickerCheck.selected = false;
    	
    	initPreview();
    	isPreview = false;
    	previewOpen = false;
    	btnOk.disabled = true;
    	
    	initState = true;
    }
    
    public function setContents(imgset:String, itemName:String, explain:String, comment:String,
    								styleNum:Number, colorNum:Number, fontColor:Array, flicker:Boolean, preview:Boolean):Void
    {
    	if (!initState) { initCont(); }
    	
    	lvLoader(imgset);
    	itemNameTxt.text = itemName;
    	explainTxt.htmlText = explain;
    	
    	for (var i:Number=0; i<typeStyleArr.length; i++)
    	{
    		if (typeStyleArr[i].name == imgset)
    		{
    			typeIndex = i;
    			styleCount = typeStyleArr[i].num;
    			this["type"+i]._visible = true;
    			break;
    		}
    	}
    	
    	setStyle(styleCount);
    	_styleNum = styleNum;
    	styleRadio0.group.setSelectedButton(this["styleRadio"+_styleNum]);
    	
    	previewOpen = preview;
    	inputComment.text = comment;
    	inputCharTxt.text = comment.length + " / " + inputComment.maxChars;
    	
    	_colorNum = colorNum;
    	_fontColor = fontColor;
    	
    	effectRadio0.group.setSelectedButton(this["effectRadio"+((_colorNum==-1)?1:0)]);
    	
    	for (var j:Number=0; j<_fontColor.length; j++)
    	{
    		drawRect(this["colorRadio"+j].colorRect, 4, 3, 22, 22, 4, _fontColor[j]);
    	}
    	
    	setColorRadio(_colorNum);
    	setCommentText(comment, _colorNum);
//    	if (previewOpen)
//    	{
//    		btnOk.disabled = true;
//    	}
//    	else
//    	{
//    		if (comment == "") { btnOk.disabled = true; }
//    		else { btnOk.disabled = false; }
//    	}
    	
    	flickerCheck.selected = flicker;
    	if (flicker)
		{
			this["type"+typeIndex].gotoAndPlay("show");
		}
		else
		{
			this["type"+typeIndex].gotoAndPlay(1);
		}
    	
    	initState = false;
	}
    
    public function commentCheck(type:Number, typeWord:String):Void
    {
    	if (type == -1)
    	{
    		commentCheckMC.textField.text = "";
    		commentCheckMC.gotoAndStop(1);
	    	btnOk.disabled = true;
    	}
    	else if (type == 0)
    	{
    		commentCheckMC.textField.textColor = "0xffffff";
    		commentCheckMC.textField.text = typeWord;
    		commentCheckMC.gotoAndStop(2);
    		btnOk.disabled = true;
    	}
    	else if (type == 1)
    	{
    		commentCheckMC.textField.textColor = "0xE68231";
    		commentCheckMC.textField.text = typeWord;
    		commentCheckMC.gotoAndStop(3);
    		btnOk.disabled = true;
    	}
    	else if (type == 2)
    	{
    		commentCheckMC.textField.textColor = "0x26951f";
    		commentCheckMC.textField.text = typeWord;
    		commentCheckMC.gotoAndStop(4);
    		if (previewOpen) { btnOk.disabled = true; }
	    	else { btnOk.disabled = false; }
    	}
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	styleRadio0.label = "_spectator_style1";
    	styleRadio1.label = "_spectator_style2";
    	styleRadio2.label = "_spectator_style3";
    	styleRadio3.label = "_spectator_style4";
    	styleRadio4.label = "_spectator_style5";
    	styleRadio5.label = "_spectator_style6";
    	setStyle(1);
    	styleRadio0.group.addEventListener("itemClick", this, "onStyleRadioClick");
    	
    	effectRadioWidth = effectRadio0._width;
    	effectRadio0.addEventListener("stateChange", this, "onEffectRadio0Change");
    	effectRadio0.label = "_spectator_solid";
    	effectRadio1.label = "_spectator_rainbow";
    	effectRadio0.group.addEventListener("itemClick", this, "onEffectRadioClick");
    	
		inputComment.addEventListener("textChange", this, "onInputCommentTextChange");
    	
    	colorRadio0.group.addEventListener("itemClick", this, "onColorRadioClick");
    	
    	flickerCheck.disableFocus = true;
    	flickerCheck.label = "_spectator_effect_flicker";
    	flickerCheck.addEventListener("click", this, "onFlickerCheckClick");
    	previewBtn.label = "_spectator_preview";
    	previewBtn.addEventListener("click", this, "onPreviewBtnClick");
    	previewMC.closeBtn.addEventListener("click", this, "onPreviewCloseBtnClick");
    	initPreview();
    	
    	btnOk.label = "_cashItemUsebtn"; //사용하기
		btnOk.disabled = true;
		btnCancel.label = "_cancel"; //취소
		
		btnOk.addEventListener("click", this, "onBtnOkClick");
		
	}
	
	private function setStyle(num:Number):Void
	{
		if (num == 1)
		{
			styleTxt._visible = false;
			styleRadio0._visible = false;
			styleRadio1._visible = false;
			styleRadio2._visible = false;
			styleRadio3._visible = false;
			styleRadio4._visible = false;
			styleRadio5._visible = false;
		}
		else
		{
			styleTxt._visible = true;
			
			for (var i:Number=0; i<num; i++)
			{
				this["styleRadio"+i]._visible = true;
			}
		}
		
	}
	
	private function onStyleRadioClick(e:Object):Void
	{
		switch (typeIndex)
		{
			case 0 :
				_styleNum = Number(e.item.data);
				type0.bgMC.gotoAndStop(_styleNum+1);
				break;
			
			case 1 :
				_styleNum = Number(e.item.data);
				type1.bgMC.gotoAndStop(_styleNum+1);
				break;
		}
	}
	
	private function onEffectRadio0Change(e:Object):Void
	{
		if (effectRadioWidth != e.target.width)
		{
			effectRadio1._x = e.target._x + e.target.width + 20;
			effectRadioWidth = e.target.width;
		}
		
	}
	
	private function onEffectRadioClick(e:Object):Void
	{
		if (e.item.data == "0")
		{
			if (_colorNum != -1) { return; }
			_colorNum = tmpColor;
		}
		else
		{
			if (_colorNum == -1) { return; }
			tmpColor = _colorNum;
			_colorNum = -1;
		}
		setColorRadio(_colorNum);
		setCommentText(inputComment.text, _colorNum);
	}
	
	private function setColorRadio(index:Number):Void
	{
		if (index == -1)
		{
			colorRadio0.disabled = true;
			colorRadio1.disabled = true;
			colorRadio2.disabled = true;
			colorRadio3.disabled = true;
			colorRadio4.disabled = true;
			colorRadio5.disabled = true;
			colorRadio6.disabled = true;
		}
		else
		{
			colorRadio0.disabled = false;
			colorRadio1.disabled = false;
			colorRadio2.disabled = false;
			colorRadio3.disabled = false;
			colorRadio4.disabled = false;
			colorRadio5.disabled = false;
			colorRadio6.disabled = false;
			
			colorRadio0.group.setSelectedButton(this["colorRadio"+index]);
		}
	}
	
	private function onInputCommentTextChange(e:Object):Void
	{
		inputCharTxt.text = e.target.text.length + " / " + inputComment.maxChars;
		setCommentText(e.target.text, _colorNum);
	}
	
	private function onColorRadioClick(e:Object):Void
	{
		if (_colorNum == Number(e.item.data)) { return; }
		_colorNum = Number(e.item.data);
		setCommentText(inputComment.text, _colorNum);
	}
	
	private function setCommentText(cmt:String, color:Number):Void
	{
		cmt = parseHtmlText(cmt, color);
		
		switch (typeIndex)
		{
			case 0 :
				if (type0.textMC.normalTxt.htmlText == cmt) { return; }
				var maxWid:Number = type0.textMC.normalTxt._width - 1;
				type0.textMC.normalTxt.htmlText = cmt;
				if (maxWid > type0.textMC.normalTxt.textWidth)
				{
					type0.textMC.normalTxt._visible = true;
					TweenMax.killTweensOf(type0.textMC.aniMC.aniTxt);
					type0.textMC.aniMC._visible = false;
					type0.textMC.aniMC.aniTxt._x = 0;
				}
				else
				{
					type0.textMC.normalTxt._visible = false;
					type0.textMC.aniMC.aniTxt.htmlText = cmt;
					type0.textMC.aniMC._visible = true;
					
					var duration:Number = Math.abs(-type0.textMC.aniMC.aniTxt._width - type0.textMC.aniMC.aniTxt._x)/100;
					TweenMax.to(
						type0.textMC.aniMC.aniTxt,
						duration,
						{
							_x:			-type0.textMC.aniMC.aniTxt._width,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onType0AniTxtComplete)
						}
					);
				}
				break;
				
			case 1 :
				if (type1.textMC.normalTxt.htmlText == cmt) { return; }
				type1.textMC.normalTxt.htmlText = cmt;
				break;
		}
	}
	
	private function setPreviewCommentText(cmt:String, color:Number):Void
	{
		cmt = parseHtmlText(cmt, color);
		
		switch (typeIndex)
		{
			case 0 :
				var maxWid:Number = previewMC.type0.textMC.normalTxt._width - 1;
				previewMC.type0.textMC.normalTxt.htmlText = cmt;
				if (maxWid > previewMC.type0.textMC.normalTxt.textWidth)
				{
					previewMC.type0.textMC.normalTxt._visible = true;
					TweenMax.killTweensOf(previewMC.type0.textMC.aniMC.aniTxt);
					previewMC.type0.textMC.aniMC._visible = false;
					previewMC.type0.textMC.aniMC.aniTxt._x = 0;
				}
				else
				{
					previewMC.type0.textMC.normalTxt._visible = false;
					previewMC.type0.textMC.aniMC.aniTxt.htmlText = cmt;
					previewMC.type0.textMC.aniMC._visible = true;
					
					var duration:Number = Math.abs(-previewMC.type0.textMC.aniMC.aniTxt._width - previewMC.type0.textMC.aniMC.aniTxt._x)/100;
					TweenMax.to(
						previewMC.type0.textMC.aniMC.aniTxt,
						duration,
						{
							_x:			-previewMC.type0.textMC.aniMC.aniTxt._width,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onPreviewType0AniTxtComplete)
						}
					);
				}
				break;
				
			case 1 :
				previewMC.type1.textMC.normalTxt.htmlText = cmt;
				break;
		}
	}
	
	private function parseHtmlText(text:String, color:Number):String
	{
		var txt:String = "";
		if (color == -1)
		{
			for (var i=0; i<text.length; i++)
			{
				var rainbow:Number = _fontColor[i%7];
				var str:String = "<font color='#" + rainbow + "'>" + text.charAt(i) + "</font>";
				txt += str;
			}
		}
		else
		{
			txt = "<font color='#" + _fontColor[color] + "'>" + text + "</font>";
		}
		
		return txt;
	}
	
	private function onType0AniTxtComplete():Void
	{
		type0.textMC.aniMC.aniTxt._x = type0.textMC.normalTxt._width;
		var duration:Number = Math.abs(-type0.textMC.aniMC.aniTxt._width - type0.textMC.aniMC.aniTxt._x)/100;
		TweenMax.to(
						type0.textMC.aniMC.aniTxt,
						duration,
						{
							_x:			-type0.textMC.aniMC.aniTxt._width,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onType0AniTxtComplete)
						}
					);
	}
	
	private function onPreviewType0AniTxtComplete():Void
	{
		previewMC.type0.textMC.aniMC.aniTxt._x = previewMC.type0.textMC.normalTxt._width;
		var duration:Number = Math.abs(-previewMC.type0.textMC.aniMC.aniTxt._width - previewMC.type0.textMC.aniMC.aniTxt._x)/100;
		TweenMax.to(
						previewMC.type0.textMC.aniMC.aniTxt,
						duration,
						{
							_x:			-previewMC.type0.textMC.aniMC.aniTxt._width,
							ease:		Linear.easeNone,
							onComplete:	Delegate.create(this, onPreviewType0AniTxtComplete)
						}
					);
	}
	
	private function onFlickerCheckClick(e:Object):Void
	{
		if (e.target.selected)
		{
			this["type"+typeIndex].gotoAndPlay("show");
		}
		else
		{
			this["type"+typeIndex].gotoAndPlay(1);
		}
	}
	
	private function onPreviewBtnClick(e:Object):Void
	{
		isPreview = !isPreview;
		openPreview(isPreview);
	}
	
	private function openPreview(status:Boolean):Void
	{
		if (status)
		{
			previewMC._visible = true;
			previewMC["type"+typeIndex]._visible = true;
			setPreviewCommentText(inputComment.text, _colorNum);
	    	if (flickerCheck.selected)
			{
				previewMC["type"+typeIndex].gotoAndPlay("show");
			}
			else
			{
				previewMC["type"+typeIndex].gotoAndPlay(1);
			}
		}
		else
		{
			initPreview();
		}
	}
	
	private function onPreviewCloseBtnClick():Void
	{
		isPreview = false;
		openPreview(isPreview);
	}
	
	private function initPreview():Void
	{
		previewMC.type0._visible = false;
    	TweenMax.killTweensOf(previewMC.type0.textMC.aniMC.aniTxt);
    	previewMC.type0.textMC.normalTxt.htmlText = "";
    	previewMC.type0.textMC.aniMC.aniTxt.htmlText = "";
    	previewMC.type0.textMC.aniMC.aniTxt._x = 0;
    	previewMC.type0.bgMC.gotoAndStop(1);
    	
    	previewMC.type1._visible = false;
    	previewMC.type1.textMC.normalTxt.htmlText = "";
    	previewMC.type1.bgMC.gotoAndStop(1);
    	
    	previewMC._visible = false;
	}
	
	private function lvLoader(imgset:String):Void
	{
		var chk:String = imgset.substr(-4);
		if (chk == "_ani") { mcLoader.loadClip("CashItem_Ani/"+imgset+".swf", imgIcon); }
		else { mcLoader.loadClip(imgPathCashItem+imgset, imgIcon); }
	}
	
	private function drawRect(mc:MovieClip, x:Number, y:Number, w:Number, h:Number, cornerRadius:Number, color:Number) {
	// if the user has defined cornerRadius our task is a bit more complex. :)
		mc.clear ();
		var codeColor:String = "0x" + color;
		mc.lineStyle (1, Number(codeColor));		
		mc.beginFill (Number(codeColor), 100);
		
		var theta, angle, cx, cy, px, py;
		// make sure that w + h are larger than 2*cornerRadius
		// theta = 45 degrees in radians
		if (cornerRadius>Math.min(w, h)/2) {
			cornerRadius = Math.min(w, h)/2;
		}
		theta = Math.PI/4;
		// draw top line
		
		mc.moveTo(x+cornerRadius, y);
		mc.lineTo(x+w-cornerRadius, y);
		//angle is currently 90 degrees
		angle = -Math.PI/2;
		// draw tr corner in two parts
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		// draw right line
		mc.lineTo(x+w, y+h-cornerRadius);
		// draw br corner
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		// draw bottom line
		mc.lineTo(x+cornerRadius, y+h);
		// draw bl corner
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		// draw left line
		mc.lineTo(x, y+cornerRadius);
		// draw tl corner
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		mc.curveTo(cx, cy, px, py);
		
		mc.endFill ();
	}
	
	private function onBtnOkClick():Void
	{
		ExternalInterface.call("spectatorDeco_OnSubmitBtnClick", typeStyleArr[typeIndex].name, inputComment.text, _styleNum, _colorNum, flickerCheck.selected);
	}
}