/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.Enchant.ListWeaponCont;
import com.scaleform.sf2.lobby.Enchant.UpgradeCont;
import com.scaleform.sf2.lobby.Enchant.TreeModelCont;
import com.scaleform.sf2.lobby.Enchant.ListPartCont;
import com.scaleform.sf2.lobby.Enchant.PopupPartAbstract;
import com.scaleform.sf2.lobby.Enchant.PopupPartAbstractResult;
import com.scaleform.sf2.lobby.Enchant.PopupUpgradeItemView;
import gfx.controls.UILoader;
import com.scaleform.sf2.lobby.Enchant.TreeViewDataProvider;
import com.scaleform.sf2.lobby.Enchant.TreeViewConstants;

class com.scaleform.sf2.lobby.Enchant.EnchantWnd extends UIComponent
{	
	public static var viewName:String = "EnchantWnd";
	public var listWeaponCont:ListWeaponCont;
	public var treeModelCont:TreeModelCont;
	public var listPartCont:ListPartCont;
	public var upgradeCont:UpgradeCont;
	public var popupAbstract:PopupPartAbstract;
	public var popupAbstractResult:PopupPartAbstractResult;
	public var popupUpgradeView:PopupUpgradeItemView;
	public var cashImgLoader:UILoader;
	
	
    public function EnchantWnd() {         
        super(); 
		trace(viewName + " initialized.");
    }
	
	public function setMyPartsValue(PartAMin:Number, PartAMax:Number,
									PartBMin:Number, PartBMax:Number,
									PartCMin:Number, PartCMax:Number,
									PartDMin:Number, PartDMax:Number) {
										
		var pai:Number = PartAMin;
		var pax:Number = PartAMax;
		var pbi:Number = PartBMin;
		var pbx:Number = PartBMax;
		var pci:Number = PartCMin;
		var pcx:Number = PartCMax;
		var pdi:Number = PartDMin;
		var pdx:Number = PartDMax;
		
		listPartCont.partMcA.setData(pai, pax);
		listPartCont.partMcB.setData(pbi, pbx);
		listPartCont.partMcC.setData(pci, pcx);
		listPartCont.partMcD.setData(pdi, pdx);
		
		popupAbstractResult.OriPartAMinVal = pai;
		popupAbstractResult.OriPartBMinVal = pbi;
		popupAbstractResult.OriPartCMinVal = pci;
		popupAbstractResult.OriPartDMinVal = pdi;
		
		popupAbstractResult.OriPartAMaxVal = pax;
		popupAbstractResult.OriPartBMaxVal = pbx;
		popupAbstractResult.OriPartCMaxVal = pcx;
		popupAbstractResult.OriPartDMaxVal = pdx;
		
		popupAbstractResult.partA.setData(pai, pax);
		popupAbstractResult.partB.setData(pbi, pbx);
		popupAbstractResult.partC.setData(pci, pcx);
		popupAbstractResult.partD.setData(pdi, pdx);
	}
	
	
	
	//===================
	// ListWeapon
	//===================
	public function SetListWeaponContext(str:String) {			
		listWeaponCont.setTxtContent(str);
	}
	public function SetPageStepperMaxValue(val:Number) {
		listWeaponCont.SetPageStepperMaxValue(val);
	}
	public function OnListWeaponRightMove(nowView:Number) {
		listWeaponCont.onRightMove(nowView)
	}	
	public function OnListWeaponLeftMove(nowView:Number) {
		listWeaponCont.onLeftMove(nowView)	
	}
	
	//====================
	// TreeModel
	//====================
	public function SetTreeModelTxtContext(str:String) {
		treeModelCont.SetTxtContext(str);
	}
	public function SetTreeModelTxtTip(str:String) {
		treeModelCont.SetTxtTip(str);
	}
	
	//====================
	// Upgrade
	//====================
	public function SetUpgradeItemImg(WeaponTitle:String, WeaponName:String) {
		upgradeCont.setItemImgLoader(WeaponTitle, WeaponName);
	}	
	public function SetUpgradePartData(Amin:Number, Amax:Number,
									   Bmin:Number, Bmax:Number,
									   Cmin:Number, Cmax:Number,
									   Dmin:Number, Dmax:Number) {
										   
		upgradeCont.partMcA.setData(Amin, Amax);
		upgradeCont.partMcB.setData(Bmin, Bmax);
		upgradeCont.partMcC.setData(Cmin, Cmax);
		upgradeCont.partMcD.setData(Dmin, Dmax);	
	}
	
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
		upgradeCont.SetUpgradeGraphValue(upMinVal1,upMaxVal1,
										 upMinVal2,upMaxVal2,
										 upMinVal3,upMaxVal3,
										 upMinVal4,upMaxVal4,								  
										 difMinVal1,difMaxVal1,
										 difMinVal2,difMaxVal2,
										 difMinVal3,difMaxVal3,
										 difMinVal4, difMaxVal4,
										 magazineMinVal, magzineMaxVal) 
	}
	//
    private function configUI():Void
    {
    	super.configUI();
		cashImgLoader.source = "gfx_cashbar.swf";
		
		//listWeaponCont.btnOk.addEventListener("click", this, "onBtnPartAbstract");
		//upgradeCont.btnUpgrade.addEventListener("click", this, "onBtnUpGrade");
		//popupUpgradeView.setItemImgLoader("cheytac_huntsman_gb","cheytac_huntsman_gb")
		/*
		setMyPartsValue(100, 300,
						140, 300,
						200, 300,
						260, 300);
		*/				
		//popupAbstractResult.SetPartsResultValue(40 , 12 , 20 , 30);
		
    }
	
}