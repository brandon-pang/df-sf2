/**
 * ...
 * @author 
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.ButtonBar;
import gfx.controls.TileList;
import gfx.controls.NumericStepper
import com.greensock.*; 
import com.greensock.easing.*;
import com.greensock.plugins.*;
import com.scaleform.sf2.lobby.shop.ShopItemListScroll;

class com.scaleform.sf2.lobby.Inven.InvenBaseWnd extends UIComponent 
{
	public var InvenBbTop:ButtonBar;
    private var mcLoader:MovieClipLoader;   
    private var miconPath:String = "gfx_cashbar.swf";
	private var searchPath:String = "gfx_shop_searchFilters.swf";
	public var tmc_cashBar:MovieClip;    
	public var tmc_searchBar:MovieClip;   
	public var bg:MovieClip;
	public var backInShadow:MovieClip;
	public var List_itemset0:TileList;
	public var List_itemset1:TileList;
	public var scrollBg:ShopItemListScroll
	public var InvenPageStepper:NumericStepper;

	public function InvenBaseWnd()
	{         
		super();
		TweenPlugin.activate([BlurFilterPlugin]);
	}
	//================================
	//base tap setting
	//================================
	public function SetMainTab($data:Array):Void
	{
		var _arr=$data
		var _no:Number=Number(_arr[0].Code)
		setTapData(_no)	

		InvenBbTop.dataProvider = _arr;		
		InvenBbTop.labelField   = "Label";		
		InvenBbTop.displayFocus = true;
		InvenBbTop.addEventListener("change",this,"onTapClick");	
	}

	public function onTapClick(e:Object)
	{
		var no = e.item.Code;		
		_global.onTapClickIndex(no);		
		setTapData(no)
	}

	public function setTapData($no:Number)
	{
		trace ("xxxxx"+$no)
		var no=$no		
		//InvenBuyTabs.hotNewClickBox._visible=false;
		//InvenBuyTabs.hotNewClickBox.blinkMc.gotoAndPlay(1)
		//InvenBuyTabs.hotNewClickBox.bg.gotoAndPlay(1)

		if (no == 0)
		{			
			//InvenBuyTabs.hotNewClickBox._y=-800
		}
		else if (no == 1)
		{
			//InvenBuyTabs.hotNewClickBox._y=-800
		}
		else if (no == 2)
		{
			//InvenBuyTabs.hotNewClickBox._y=-800
		}
		else if (no == 3)
		{
			//InvenBuyTabs.hotNewClickBox._y=-800
		}
		else if (no == 4)
		{
			//InvenBuyTabs.hotNewClickBox._y=0
			

		}
		else if (no == 5)
		{
		
		}
	}
 
	//================================
	//content Loader
	//================================
	private function onLoadInit(mc:MovieClip)
    {
        
    }

    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(path,mc);
    }
    
    //================================================
	// 아이템 구매탭 세팅
	//================================================
    public function setWeaponClickItemProvider(obj:Object) {
      // InvenBuyTabsView.setWeaponClickItemProvider(obj);
    }
    public function setChrItemProvider(obj:Object) {
      // InvenBuyTabsView.setChrItemProvider(obj);
    }
    public function setCashClickItemProvider(obj:Object) {
      // InvenBuyTabsView.setCashClickItemProvider(obj);
    }
    public function setModeClickItemProvider(obj:Object) {
      // InvenBuyTabsView.setModeClickItemProvider(obj);
    }
    public function setHotNewItemProvider(obj:Object) {
     //  InvenBuyTabs.hotNewClickBox.setInit(obj)
    }
	//===============================================
	// END
	//===============================================
	private var nowNo:Number=1;
	private var nowView:Number=0;

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
			onRightMove(nowView);
		}
		if (prevNo<nowNo) {
			if (nowView == 0) {
				nowView = 1;
			} else {
				nowView = 0;
			}
			onLeftMove(nowView);
		}
		nowNo = Number(n)
	}	

	private function onRightMove(nowView) {
		trace ("nowNo ="+ nowNo)
		trace ("right="+nowView)
		if (nowView == 0) {
			List_itemset0._x = 542;
			TweenMax.to(List_itemset0, 0.3, {_x:6,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:-530,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		} else {
			List_itemset1._x = 542;
			TweenMax.to(List_itemset0, 0.3, {_x:-530,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:6, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		}		
	}
	private function onLeftMove(nowView) {
		trace ("left="+nowView)
		if (nowView == 0) {
			List_itemset0._x = -530;		
			TweenMax.to(List_itemset0, 0.3, {_x:6,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:542, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
		} else {
			List_itemset1._x = -530;
			TweenMax.to(List_itemset0, 0.3, {_x:542, blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});
			TweenMax.to(List_itemset1, 0.3, {_x:6,  blurFilter:{blurX:5, blurY:5, quality:3, remove:true}, ease:Cubic.easeInOut});			
		}
	}

	private function onIconNaviScrollWheel(e:Object):Void {
		var v = InvenPageStepper.value;
		var d = e.delta
		InvenPageStepper.value=(v-d)
	}

    private function configUI():Void
    {
    	super.configUI();
		lvLoader(miconPath, tmc_cashBar);
		lvLoader(searchPath, tmc_searchBar);
		
		SetMainTab([{Label:"핫앤뉴", Code:4, IconImg:false}, 
				{Label:"무기", Code:0, IconImg:false},
				{Label:"캐릭터", Code:5, IconImg:false},
				{Label:"아이템", Code:2, IconImg:false}, 
				{Label:"모드전용", Code:3, IconImg:true } ]);
		
		InvenPageStepper.addEventListener("change",this,"onPageStepper");
		scrollBg.addEventListener("scrollWheel", this, "onIconNaviScrollWheel");
		
		List_itemset0.dataProvider = [
										{IconImg:"cz700_side_scope_b_icejam",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"1",ItemLength:"10",PcRoomStat:"netmarble"},
										{IconImg:"CashItem_awp_famas_package",Title:"CashItem_awp_famas_package",ItemStat:"1",ItemIndex:"3",ItemLength:"10",VipIcon:"vip_bronze",PcRoomStat:"CHN_PC"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1",VipIcon:"vip_gold",ClassLimit:"0011",Cash:"10,331",PcRoomStat:"CHN_HighPC"},
										{IconImg:"Common_ChristmasGlove",Title:"Common_ChristmasGlove",ItemStat:"2",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",ClassLimit:"0011",Cash:"10,331",PcRoomStat:"event",BuyBtnEnable:"1",GiftBtnEnable:"1"},
										{IconImg:"CashItem_ClanMarkPack",Title:"CashItem_use_gold3pack",ItemStat:"2",ItemIndex:"3",WpIcon:"1",ClassLimit:"0011",PcRoomStat:"JPN_PC"},
										{IconImg:"cz700_side_scope_b_icejam",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"1",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1",VipIcon:"vip_gold",Cash:"10,331",Sp:"10,000",Tp:"10",GiftBtnEnable:"1"},
										{IconImg:"CashItem_pak_blackmamba",Title:"CashItem_PAK_DoubleUP",ItemStat:"1",ItemIndex:"3",PcRoomStat:"TWN_PC"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0",PcRoomStat:"TWN_HighPC"},
										{IconImg:"Common_ChristmasGlove",Title:"Common_ChristmasGlove",ItemStat:"2",ItemIndex:"0",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1",Cash:"10,331"},
										{IconImg:"cz700_side_scope_b_icejam",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"1",BuyLimitCase:"0",BuyLimitNo:"10",BuyLimitMeNo:"10",BestIcon:"1",NewIcon:"1",VipIcon:"vip_gold",BuyBtnEnable:"1"},
										{IconImg:"CashItem_mission_pin",Title:"CashItem_PAK_DoubleUP",ItemStat:"1",ItemIndex:"3",SaleIcon:"10%",NewIcon:"1",Cash:"10,331",Sp:"10,000",Tp:"10",GiftBtnEnable:"1"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1",VipIcon:"vip_gold",Cash:"10,331",BuyBtnEnable:"1",GiftBtnEnable:"1"}
										]  

			List_itemset1.dataProvider = [
										{IconImg:"CashItem_VikiniMamba_package",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"3",BuyLimitCase:"0",BuyLimitNo:"10",BuyLimitMeNo:"10",BestIcon:"1",NewIcon:"1",Cash:"10,331"},
										{IconImg:"CashItem_pak_tempesto_xhia_dipper",Title:"CashItem_PAK_DoubleUP",ItemStat:"1",ItemIndex:"3",SaleIcon:"10%",NewIcon:"1",VipIcon:"vip_gold"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1"},
										{IconImg:"Common_ChristmasGlove",Title:"Common_ChristmasGlove",ItemStat:"2",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1"},
										{IconImg:"CashItem_pak_summerpackage",Title:"CashItem_use_gold3pack",ItemStat:"2",ItemIndex:"3",WpIcon:"1"},
										{IconImg:"cz700_side_scope_b_icejam",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"1",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1"},
										{IconImg:"pvemode_glasses",Title:"CashItem_PAK_DoubleUP",ItemStat:"1",ItemIndex:"3"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0"},
										{IconImg:"cz700_side_scope_b_icejam",Title:"Common_ChristmasGlove",ItemStat:"2",ItemIndex:"1",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1"},
										{IconImg:"CashItem_use_snake_package",Title:"cz700_side_scope_b_icejam",ItemStat:"3",ItemIndex:"3",BuyLimitCase:"0",BuyLimitNo:"10",BuyLimitMeNo:"10",BestIcon:"1",NewIcon:"1",VipIcon:"vip_gold"},
										{IconImg:"SFCItem_Func_PKG_Gold_m4a1_cz700_ump45",Title:"CashItem_PAK_DoubleUP",ItemStat:"1",ItemIndex:"3",SaleIcon:"10%",NewIcon:"1"},
										{IconImg:"com_SpeedBoots01",Title:"com_SpeedBoots01",ItemStat:"1",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1"}
										]  
    }
}