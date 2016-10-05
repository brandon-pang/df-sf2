/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.udk.controls.ImageScroller;
import gfx.controls.ScrollingList;
import gfx.controls.CheckBox;
import gfx.controls.DropdownMenu;
import gfx.controls.Label;
import gfx.core.UIComponent;

class com.scaleform.udk.dialogs.TopNoticeDialog extends View
{
	public static var viewName:String = "InfoDialog";
	
	//public var firstSelection:MovieClip;
	//public var backBtn:MovieClip;

	public function TopNoticeDialog()
	{
		super();
		trace(viewName+" initialized.");

		//setLabelText(container.dialog);

		//setDropDownMenu(container.dialog);
	}

	public function setBackBtn(inBackBtn:MovieClip):Void
	{
		//backBtn = inBackBtn;
		//firstSelection = backBtn;
		//SetFocus();
	}
}