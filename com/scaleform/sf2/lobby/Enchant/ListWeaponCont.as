/**
 * ...
 * @author 
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.TileList;
import gfx.controls.NumericStepper;
import com.greensock.*; 
import com.greensock.easing.*;
import com.greensock.plugins.*;
import com.scaleform.sf2.lobby.shop.ShopItemListScroll;
 
class com.scaleform.sf2.lobby.Enchant.ListWeaponCont extends UIComponent
{	
	public static var viewName:String = "Enchant_ListWeaponCont";
	public var txtTitle:TextField;
    public var txtContent:TextField;
	public var btnOk:Button;
	
    private var mcLoader:MovieClipLoader;       
	private var searchPath:String = "gfx_shop_searchFilters.swf";	
	public var tmc_searchBar:MovieClip;   
	public var bg:MovieClip;
	public var List_itemset0:TileList;
	public var List_itemset1:TileList;
	public var scrollBg:ShopItemListScroll
	public var InvenPageStepper:NumericStepper;
	
    private var nowNo:Number=1;
	private var nowView:Number = 0;
    public var pageMax:Number = 1;
	
	public function ListWeaponCont() {         
        super(); 	
		trace(viewName + " initialized.");
		TweenPlugin.activate([BlurFilterPlugin]);
    }    
	
	public function setTxtContent(str:String) {
		txtContent.htmlText = str;
	}
	private function onLoadInit(mc:MovieClip)
    {
		if (mc._name == "tmc_searchBar") {
			mc.searchFilters.tinp_search._x =180
			mc.searchFilters.btn_search._x = 299
			mc.searchFilters.bg._x = 172
		}
    }
	private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(path,mc);
    }
	
	private function onPageStepper(e:Object):Void{	
 		TweenMax.killTweensOf(List_itemset0, true);
		TweenMax.killTweensOf(List_itemset1, true);	

		var n = e.target.value;
		var prevNo = Number(n)

		if (prevNo>nowNo) {
			if (nowView == 0) {
				nowView = 1;
			} else {
				nowView = 0;
			}
			
			ExternalInterface.call("ListPageCallRight", nowView,n);
			//onRightMove(nowView);
		}
		if (prevNo<nowNo) {
			if (nowView == 0) {
				nowView = 1;
			} else {
				nowView = 0;
			}
			ExternalInterface.call("ListPageCallLeft", nowView,n);
			//onLeftMove(nowView);
		}
		nowNo = Number(n)
	}	

	public function onRightMove(nowView:Number) {
		if (nowView == 0) {
			List_itemset0._x = 332;
			TweenMax.to(List_itemset0, 0.3, {_x:28,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:-276,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		} else {
			List_itemset1._x = 332;
			TweenMax.to(List_itemset0, 0.3, {_x:-276,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:28, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		}		
	}
	public function onLeftMove(nowView:Number) {
		if (nowView == 0) {
			List_itemset0._x = -276;		
			TweenMax.to(List_itemset0, 0.3, {_x:28,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:332, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		} else {
			List_itemset1._x = -276;
			TweenMax.to(List_itemset0, 0.3, {_x:332, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:28,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});			
		}
	}

	private function onIconNaviScrollWheel(e:Object):Void {
		var v = InvenPageStepper.value;
		var d = e.delta
		InvenPageStepper.value = (v - d)
	}
	
	public function SetPageStepperMaxValue(val:Number) {
		InvenPageStepper.maximum = val;
		InvenPageStepper.labelFunction = function(value:Number) {
			return "<font color='#ffffff'>"+value+"</font>"+"<font color='#515151'> / "+this._maximum+"</font>"
		}
	}
    private function configUI():Void
    {
    	super.configUI();
		
		txtTitle.verticalAlign = "center";
		txtTitle.text = "_enchant_supply";
		txtContent.verticalAlign = "center";
		txtContent.noTranslate = true;
		btnOk.label = "_enchant_sampling";
		lvLoader(searchPath, tmc_searchBar);	
		InvenPageStepper.maximum = pageMax;			
		InvenPageStepper.addEventListener("change", this, "onPageStepper");
		
		scrollBg.addEventListener("scrollWheel", this, "onIconNaviScrollWheel");
    }
	
}