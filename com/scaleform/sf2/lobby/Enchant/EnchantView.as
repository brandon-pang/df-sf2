/**
 * ...
 * @author 
 */
import com.scaleform.sf2.lobby.Enchant.onCloseEndContainer;
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.sf2.lobby.Enchant.EnchantCont;
import com.scaleform.udk.views.View;
import com.scaleform.sf2.lobby.Enchant.TreeViewDataProvider;
import com.scaleform.sf2.lobby.Enchant.TreeViewConstants;

 
class com.scaleform.sf2.lobby.Enchant.EnchantView extends View
{	
	public static var viewName:String = "Enchant View";
	public var container:EnchantCont;	
	
    public function EnchantView() {         
        super(); 
		trace(viewName + " initialized.");
    }
    
	  public function openInit():Void
    {
    	this._visible = true;
    	container.gotoAndPlay("open");
    }
    
    public function closeInit():Void
    {
    	container.gotoAndPlay("close");
    }
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_enchant");		
		if(_global.gfxPlayer){
			SetListWeaponContext("str:String<br>나란아마넝라먼ㅇㄹ<br>해주세요")
			SetPageStepperMaxValue(10) 
		}		
		ScrollWheelManager.registerList(container.enchantCont.treeModelCont.ListModel, "Enchant");
	}
	
	private function onCloseEndContainer():Void
	{
		this._visible = false;
		
		_global.getCloseMotionEnd("gfx_enchant");		
		ScrollWheelManager.unregisterNameTag("Enchant");
	}
	
	//===================
	// ListWeapon
	//===================
	public function SetListWeaponContext(str:String) {		
		container.SetListWeaponContext(str);
	}	
	public function SetPageStepperMaxValue(val:Number) {
		container.SetPageStepperMaxValue(val);
	}
	public function OnListWeaponRightMove(nowView:Number) {
		container.OnListWeaponRightMove(nowView);
	}	
	public function OnListWeaponLeftMove(nowView:Number) {
		container.OnListWeaponLeftMove(nowView);
	}
	
	//====================
	// TreeModel
	//====================
	public function SetTreeModelTxtContext(str:String) {
		container.SetTreeModelTxtContext(str);
	}	
	public function SetTreeModelTxtTip(str:String) {
		container.SetTreeModelTxtTip(str)
	}
	
	//====================
	// ListPartCont
	//====================
	public function SetMyPartsValue(PartAMin:Number, PartAMax:Number,
									PartBMin:Number, PartBMax:Number,
									PartCMin:Number, PartCMax:Number,
									PartDMin:Number, PartDMax:Number){
		container.SetMyPartsValue(PartAMin, PartAMax,
								  PartBMin, PartBMax,
								  PartCMin, PartCMax,
						          PartDMin, PartDMax)
	}
	
	//====================
	// Upgrade
	//====================
	public function SetUpgradeItemImg(WeaponTitle:String, WeaponName:String) {
		container.SetUpgradeItemImg(WeaponTitle, WeaponName)
	}
	public function SetUpgradePartData(Amin:Number, Amax:Number,
									   Bmin:Number, Bmax:Number,
									   Cmin:Number, Cmax:Number,
									   Dmin:Number, Dmax:Number) 
	{
		container.SetUpgradePartData(Amin, Amax,
									 Bmin, Bmax,
									 Cmin, Cmax,
									 Dmin, Dmax)
	}
	//Graph Upgrade
	public function SetUpgradeGraphValue(upMinVal1:Number,upMaxVal1:Number,
								  upMinVal2:Number,upMaxVal2:Number,
								  upMinVal3:Number,upMaxVal3:Number,
								  upMinVal4:Number,upMaxVal4:Number,								  
							      difMinVal1:Number,difMaxVal1:Number,
								  difMinVal2:Number,difMaxVal2:Number,
								  difMinVal3:Number,difMaxVal3:Number,
								  difMinVal4:Number, difMaxVal4:Number,
								  magazineMinVal:Number, magzineMaxVal:Number)
	{
		container.SetUpgradeGraphValue(upMinVal1,upMaxVal1,
										 upMinVal2,upMaxVal2,
										 upMinVal3,upMaxVal3,
										 upMinVal4,upMaxVal4,								  
										 difMinVal1,difMaxVal1,
										 difMinVal2,difMaxVal2,
										 difMinVal3,difMaxVal3,
										 difMinVal4, difMaxVal4,
										 magazineMinVal, magzineMaxVal) 
	}
	
	public function SetOpenPopupAbstract(timeNo:Number) {
		container.enchantCont.popupAbstract.AbstractTime = timeNo;
		container.enchantCont.popupAbstract.OnOpenPopupAbstract();
	}
	//====================
	// PopupParts
	//====================
	public function SetPopupPartsResultValue(ApartExportValue:Number , BpartExportValue:Number , 
										     CpartExportValue:Number , DpartExportValue:Number)
	{
		container.enchantCont.popupAbstractResult.SetPartsResultValue(ApartExportValue , BpartExportValue , 
																	  CpartExportValue , DpartExportValue);
	}
	public function SetOpenPopupAbstractResult() {
		container.enchantCont.popupAbstractResult.OnOpenPopupAbstract();
	}
	public function SetClosePopupAbstractResult() {
		container.enchantCont.popupAbstractResult.OnClosePopupAbstract();
	}
	
	//====================
	// PopupItemResult
	//====================
	public function SetPopupUpgradeItemResultView(WeaponTitle:String, WeaponName:String)
	{
		container.enchantCont.popupUpgradeView.setItemImgLoader(WeaponTitle, WeaponName);
	}
	private function SetOpenPopupUpgrade() {
		container.enchantCont.popupUpgradeView.OnOpenPopup();
	}
	private function SetClosePopupUpgrade() {
		container.enchantCont.popupUpgradeView.OnClosePopup();
	}
	
	//
	public function setCash(spTxt:String, cashTxt:String, tpTxt:String) {
		container.enchantCont.cashImgLoader.content.setCash(spTxt, cashTxt, tpTxt);
	}
	
	//=====================
	//
	//=====================
	public function SetTreeModelData(data:Object) {
		var dp = new TreeViewDataProvider(data);			
		container.enchantCont.treeModelCont.ListModel.dataProvider = dp;
		container.enchantCont.treeModelCont.ListModel.selectedIndex = 1;
	}
	/*
	*/	
	private function configUI():Void {
    	super.configUI();    	
        this._visible = false;    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");   
 		
		if(_global.gfxPlayer){
		//openInit()
		//
		/*
		container.enchantCont.listWeaponCont.List_itemset0.dataProvider = [
										{IconImg:"aa12_candy",Title:"aa12_candy",ItemStat:"3",ItemIndex:"1",ItemLength:"10",PcRoomStat:"netmarble",Chk:"0"},
										{IconImg:"psg1_luxury",Title:"psg1_luxury",ItemStat:"1",ItemIndex:"1",ItemLength:"10",VipIcon:"vip_bronze",PcRoomStat:"CHN_PC",Chk:"0"},
										{IconImg:"SAS_CombatJacket",Title:"SAS_CombatJacket",ItemStat:"1",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1",VipIcon:"vip_gold",ClassLimit:"0011",Cash:"10,331",PcRoomStat:"CHN_HighPC",Chk:"0"},
										{IconImg:"GIGN_CombatBelt",Title:"GIGN_CombatBelt",ItemStat:"2",ItemIndex:"0",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",ClassLimit:"0011",Cash:"10,331",PcRoomStat:"event",BuyBtnEnable:"1",GiftBtnEnable:"1",Chk:"0"},
										{IconImg:"CashItem_kit_c4_speed",Title:"CashItem_kit_c4_speed",ItemStat:"2",ItemIndex:"3",WpIcon:"1",ClassLimit:"0011",PcRoomStat:"JPN_PC",Chk:"0"},
										{IconImg:"CashItem_eagleeye_white",Title:"CashItem_eagleeye_white",ItemStat:"3",ItemIndex:"3",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1",VipIcon:"vip_gold",Cash:"10,331",Sp:"10,000",Tp:"10",GiftBtnEnable:"1",Chk:"0"},
										{IconImg:"acr_eotech_arthur",Title:"acr_eotech_arthur",ItemStat:"1",ItemIndex:"1",PcRoomStat:"TWN_HighPC",Chk:"0"},
										{IconImg:"bow_eaglesight",Title:"bow_eaglesight",ItemStat:"2",ItemIndex:"1",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1",Cash:"10,331",Chk:"0"}
										]  

		container.enchantCont.listWeaponCont.List_itemset1.dataProvider = [
										{IconImg:"cz75bd_safe",Title:"cz75bd_safe",ItemStat:"3",ItemIndex:"1",BuyLimitCase:"0",BuyLimitNo:"10",BuyLimitMeNo:"10",BestIcon:"1",NewIcon:"1",Cash:"10,331"},
										{IconImg:"Dagger",Title:"Dagger",ItemStat:"1",ItemIndex:"1",SaleIcon:"10%",NewIcon:"1",VipIcon:"vip_gold"},
										{IconImg:"deserteagle_laserdot_gold",Title:"deserteagle_laserdot_gold",ItemStat:"1",ItemIndex:"1",SaleIcon:"10%",NewIcon:"1",HotIcon:"1",BestIcon:"1"},
										{IconImg:"dragunovsvd_chrome",Title:"dragunovsvd_chrome",ItemStat:"2",ItemIndex:"1",SaleIcon:"10%",NewIcon:"1",HotIcon:"1"},
										{IconImg:"famas_acog_snake",Title:"famas_acog_snake",ItemStat:"2",ItemIndex:"1",WpIcon:"1"},
										{IconImg:"famas_eotech_chrome",Title:"famas_eotech_chrome",ItemStat:"1",ItemIndex:"1",BuyLimitCase:"1",BuyLimitNo:"10",BuyLimitMeNo:"10",WpIcon:"1"},
										{IconImg:"k3_opendot",Title:"k3_opendot",ItemStat:"1",ItemIndex:"1"},
										{IconImg:"kriss_opendot_silencer_chrome",Title:"kriss_opendot_silencer_chrome",ItemStat:"1",ItemIndex:"1"}
										]  
		*/								
		SetMyPartsValue(100, 300,
						140, 300,
						200, 300,
						280, 300);
						
		SetUpgradeItemImg("AK103_EOTECH", "ak103_eotech_rudolph_gb");		
		
		SetUpgradePartData(100, 300,
						   140, 300,
						   200, 300,
						   260, 300);
						
		SetUpgradeGraphValue(40, 300,
		                     100, 300,
					         140, 300,
					         120, 300,
					         200, 300,
					         120, 300,
					         280, 300,
					         300, 300,
					         70, 120);
		SetPopupUpgradeItemResultView("cheytac_huntsman_gb","cheytac_huntsman_gb")
		SetPopupPartsResultValue(40 , 12 , 20 , 30);
		
		container.enchantCont.listWeaponCont.btnOk.addEventListener("click", this, "SetOpenPopupAbstract");
		container.enchantCont.upgradeCont.btnUpgrade.addEventListener("click", this, "SetOpenPopupUpgrade");
		var root:Object = { 
								label:"설계도",
								nodes:[ 
										{ label: "M4A1" ,
										nodes:[
												{label:"asdfas" },
												{label:"12341234"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										},
										{ label: "M4asdfasdfasdfasdfA1" ,
										nodes:[
												{label:"asdasdfasdfasdff" },
												{label:"asdsdfasdfasdfasdf2"}
											  ]
										}
										
									  ]
								
							   };
		var dp = new TreeViewDataProvider(root);			
		container.enchantCont.treeModelCont.ListModel.dataProvider = dp;
		container.enchantCont.treeModelCont.ListModel.selectedIndex = 1;	
		}
	}
	
	
	
	
	
	
}