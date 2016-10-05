/**
 * ...
 * @author 
 */

import com.scaleform.ManHuntBeastChgItem;
import gfx.utils.Delegate;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.ManHuntBeastChgCont extends UIComponent
{
	public var item0:ManHuntBeastChgItem;
	public var item1:ManHuntBeastChgItem;
	public var item2:ManHuntBeastChgItem;
	
	private var selectedItem:ManHuntBeastChgItem;
	
    public function ManHuntBeastChgCont()
    {         
        super();  
    }
	
	public function initCont():Void
	{
		item0.initItem();
		item1.initItem();
		item2.initItem();
		
		selectedItem = null;
	}
	
	public function setItem(slot:Number, beastType:String, beastName:String, weaponType:String, mainWeapon:String, subWeapon:String, shortCut:String):Void
	{
		this["item"+slot].setItem(beastType, beastName, weaponType, mainWeapon, subWeapon, shortCut);
	}
	
	public function setSelectIndex(slot:Number):Void
	{
		this["item"+slot].selectItem(true);
		if (selectedItem && this["item"+slot] != selectedItem)
		{ 
			selectedItem.selectItem(false);
		}
		selectedItem = this["item"+slot];
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
	
	
	
}