/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.utils.Constraints;
import gfx.controls.ListItemRenderer;
import com.scaleform.FlexibleScrollingList;
import gfx.controls.Button;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.CommunityFriendListItem extends ListItemRenderer
{
	public var owner:FlexibleScrollingList;
	
// Private Properties:

// UI Elements:
	
	
	public var emblemIcon:MovieClip;
	public var codename:TextField;
	public var addFriendBtn:Button;
	public var tagJobIcon:MovieClip;
	public var tagSchoolIcon:MovieClip;
	public var tagGameIcon:MovieClip;
	public var tagJobTxt:TextField;
	public var tagSchoolTxt:TextField;
	public var tagGameTxt:TextField;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	private var tagTxtColor:Object = {basic:0x989898, job:0xf0e788, school:0xd3a484, game:0x84bed3};
	
	public function CommunityFriendListItem()
	{
		super();
		
		var format:TextFormat = new TextFormat();
		format.italic = true;
		
		tagJobTxt.setTextFormat(format);
		tagJobTxt.setNewTextFormat(format);
		tagSchoolTxt.setTextFormat(format);
		tagSchoolTxt.setNewTextFormat(format);
		tagGameTxt.setTextFormat(format);
		tagGameTxt.setNewTextFormat(format);
		
		mcLoader = new MovieClipLoader();
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
			
			mcLoader.loadClip(_imgPathPersonal+data.EmblemIcon, emblemIcon);
			codename.htmlText = data.Codename;
			
			tagJobIcon._visible = false;
			tagJobTxt.text = "";
			tagJobTxt.textColor = tagTxtColor.basic;
			tagSchoolIcon._visible = false;
			tagSchoolTxt.text = "";
			tagSchoolTxt.textColor = tagTxtColor.basic;
			tagGameIcon._visible = false;
			tagGameTxt.text = "";
			tagGameTxt.textColor = tagTxtColor.basic;
			if (data.TagJob != null && data.TagJob.name != null && data.TagJob.name != "")
			{
				if (data.TagJob.match) { tagJobIcon._visible = true; tagJobTxt.textColor = tagTxtColor.job; }
				tagJobTxt.text = data.TagJob.name;
			}
			
			if (data.TagSchool != null && data.TagSchool.name != null && data.TagSchool.name != "")
			{
				if (data.TagSchool.match) { tagSchoolIcon._visible = true; tagSchoolTxt.textColor = tagTxtColor.school; }
				tagSchoolTxt.text = data.TagSchool.name;
			}
			
			if (data.TagGame != null && data.TagGame.name != null && data.TagGame.name != "")
			{
				if (data.TagGame.match) { tagGameIcon._visible = true; tagGameTxt.textColor = tagTxtColor.game; }
				tagGameTxt.text = data.TagGame.name;
			}
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
		
		addFriendBtn.addEventListener("click", this, "onAddFriendBtnClick");
	}
	
	private function onAddFriendBtnClick(e:Object):Void
	{
		ExternalInterface.call("community_OnAddFriendBtnClick", index);
	}
	
	
}