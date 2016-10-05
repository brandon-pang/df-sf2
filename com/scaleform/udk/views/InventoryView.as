/**
 * ...
 * @author 
 */
import com.scaleform.udk.views.View;
import com.scaleform.udk.controls.ImageScroller;
import gfx.controls.ScrollingList;
import gfx.controls.Label;
import gfx.controls.DropdownMenu;
import gfx.core.UIComponent;


class com.scaleform.udk.views.InventoryView extends View
{
	public static var viewName:String = "Inventory";
	private var list:ScrollingList;
	private var info:MovieClip;
	private var imgScroller:ImageScroller;

	private var container:MovieClip;
	private var inventory:MovieClip;
	

	public function InventoryView()
	{
		super();
	}
}