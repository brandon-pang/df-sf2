/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import com.scaleform.udk.controls.CommunityNewsListItemEmotion;
import gfx.utils.Constraints;
import gfx.controls.ListItemRenderer;
import com.scaleform.FlexibleScrollingList;
import gfx.controls.Button;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.CommunityNewsListItem extends ListItemRenderer
{
	public var owner:FlexibleScrollingList;
	
// Private Properties:

// UI Elements:
	public var frame:MovieClip;
	public var line:MovieClip;
	public var bg:MovieClip;
	
	public var emblemIcon:MovieClip;
	public var classIcon:MovieClip;
	public var codename:TextField;
	public var emotionBtn:Button;
	public var emotionSelect:MovieClip;
	public var comment:TextField;
	public var contents:TextField;
	public var emotion:CommunityNewsListItemEmotion;
	public var dateTxt:TextField;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	private var _imgPathClass:String = "imgset_class.swf";
	private var _typeColor:Array = ["#41af46", "#ff7800", "#9f42ff", "#4292ff"];
	private var _voted:Boolean;
	private var _emoData:Object;
	
	public function CommunityNewsListItem()
	{
		super();
		
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		
		contents.autoSize = true;
		
		var format:TextFormat = new TextFormat();
		format.italic = true;
		
		dateTxt.setTextFormat(format);
		dateTxt.setNewTextFormat(format);
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
			
			// contents setting
			mcLoader.loadClip(_imgPathPersonal+data.EmblemIcon, emblemIcon);
			mcLoader.loadClip(_imgPathClass, classIcon);
			codename.htmlText = data.Codename;
			_voted = data.Voted;
			if (initialized)
			{
				if (data.Voted)
				{
					emotionBtn.selected = false;
					emotionBtn.disabled = true;
					emotionSelect._visible = false;
				}
				else
				{
					emotionBtn.disabled = false;
				}
			}
			var cmt:String = "<font color='" + _typeColor[data.Type] + "'>"+ data.Comment + "</font>";
			comment.htmlText = cmt;
			contents.text = data.Contents;
			dateTxt.text = data.Date;
			
			var emoData:Object = {
									Joy:data.Joy, JoyNames:data.JoyNames,
									Sorrow:data.Sorrow, SorrowNames:data.SorrowNames,
									Love:data.Love, LoveNames:data.LoveNames
								};
			_emoData = emoData;
			if (initialized) { emotion.setData(emoData); }
			
			// layout setting
			frame._height = contents._y + Math.round(contents._height) + 40;
			emotion._y = frame._height - 31;
			dateTxt._y = frame._height - 26;
			line._visible = !(index == owner.dataProvider.length-1);
			line._y = frame._height + 2;
			bg._height = frame._height + 12;
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classIcon")
		{
			mc.set_level(data.ClassIcon);
//			var lvNo:String = data.ClassIcon;
//			var KD:String = lvNo.charAt(0);
//			var LV:String = lvNo.charAt(1);
//			var chkCl:String = lvNo.substr(2, 3);
//			var CL:String;
//			if (chkCl.charAt(0) == "0") { CL = chkCl.charAt(1); }
//			else { CL = chkCl; }
//			
//			classIcon.lv0.gotoAndStop(Number(CL)+1);
//			classIcon.lv1.gotoAndStop(Number(LV)+1);
//			classIcon.lv2.gotoAndStop(Number(KD)+1);
//			
			if (data.Manner == "4") { mc.manner.gotoAndStop(2); }
			else { mc.manner.gotoAndStop(1); }
		}
		else if (mc._name == "emblemIcon")
		{
			mc._height = mc._width = 58;
		}
	}
	
	private function configUI():Void
	{
		//super.configUI();
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField, Constraints.ALL);
		}
		if (_autoSize != "none") {
			sizeIsInvalid = true;
		}
		if (focusIndicator != null && !_focused && focusIndicator._totalFrames == 1) { focusIndicator._visible = false; }
		updateAfterStateChange();
		focusTarget = owner;
		
		
		emotionBtn.addEventListener("click", this, "onEmotionBtnClick");
		emotionSelect._visible = false;
		emotionSelect.selectJoy.data = "0";
		emotionSelect.selectSorrow.data = "1";
		emotionSelect.selectLove.data = "2";
		emotionSelect.selectJoy.addEventListener("click", this, "onEmotionSelectBtnClick");
		emotionSelect.selectSorrow.addEventListener("click", this, "onEmotionSelectBtnClick");
		emotionSelect.selectLove.addEventListener("click", this, "onEmotionSelectBtnClick");
		
		if (_voted)
		{
			emotionBtn.selected = false;
			emotionBtn.disabled = true;
			emotionSelect._visible = false;
		}
		else
		{
			emotionBtn.disabled = false;
		}
		if (_emoData) { emotion.setData(_emoData); }
	}
	
	private function onEmotionBtnClick(e:Object)
	{
		if (data.Voted) { return; }
		e.target.selected = !e.target.selected;
		emotionSelect._visible = e.target.selected;
	}
	
	private function onEmotionSelectBtnClick(e:Object)
	{
		emotionSelect._visible = false;
		emotionBtn.selected = false;
		
		ExternalInterface.call("community_OnEmotionSelectClick", index, Number(e.target.data));
	}
	
	
	
	
}