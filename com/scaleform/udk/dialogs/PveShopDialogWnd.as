/**
 * ...
 * @author 
 */

import com.scaleform.udk.dialogs.PveShopDialogList;
import gfx.layout.Panel;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import flash.external.ExternalInterface;
import com.scaleform.udk.controls.ChallengeDialogRewardItem;
import com.scaleform.udk.views.MyInfoChallengeTask;
import gfx.controls.Button;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")] 
class com.scaleform.udk.dialogs.PveShopDialogWnd extends Panel
{
	public var shopList:PveShopDialogList;
	
	public function PveShopDialogWnd()
	{         
		super();  
	}
    
    public function resetItemList()
	{
		shopList.resetItem();
	}
    
    public function setItemList(arr:Array):Void
    {
    	resetItemList();
    	shopList.setItem(arr);
    }
    
    public function setItemListIndex(index:Number):Void
    {
    	shopList.setItemListIndex(index);
    }
    
    public function pveShop_SetResolution(w:Number, h:Number):Void
    {
    	shopList.pveShop_SetResolution(w, h);
    }
    
    private function configUI():Void
    {
    	super.configUI();
	}
}