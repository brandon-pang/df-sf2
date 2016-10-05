/**
 * ...
 * @author 
 */
import com.scaleform.sf2.lobby.Enchant.EnchantWnd;
import gfx.core.UIComponent;

class com.scaleform.sf2.lobby.Enchant.EnchantCont extends UIComponent
{	
	public static var viewName:String = "EnchantContainer";	
	public var enchantCont:EnchantWnd;
	
    public function EnchantCont() {         
        super(); 
		trace(viewName + " initialized.");
    }
	
	//===================
	// ListWeapon
	//===================
	public function SetListWeaponContext(str:String) {				
		enchantCont.SetListWeaponContext(str);
	}	
	public function SetPageStepperMaxValue(val:Number) {
		enchantCont.SetPageStepperMaxValue(val);
	}	
	public function OnListWeaponRightMove(nowView:Number) {
		enchantCont.OnListWeaponRightMove(nowView);		
	}	
	public function OnListWeaponLeftMove(nowView:Number) {
		enchantCont.OnListWeaponLeftMove(nowView);
	}
	
	//====================
	// TreeModel
	//====================
	public function SetTreeModelTxtContext(str:String) {
		enchantCont.SetTreeModelTxtContext(str);
	}
	public function SetTreeModelTxtTip(str:String) {
		enchantCont.SetTreeModelTxtTip(str)
	}
	
	//====================
	// ListPartCont
	//====================
	public function SetMyPartsValue(PartAMin:Number, PartAMax:Number,
									PartBMin:Number, PartBMax:Number,
									PartCMin:Number, PartCMax:Number,
									PartDMin:Number, PartDMax:Number) {
									
		enchantCont.setMyPartsValue(PartAMin, PartAMax,
								    PartBMin, PartBMax,
								    PartCMin, PartCMax,
						            PartDMin, PartDMax)
	}
	
	//====================
	// upgrade
	//====================
	public function SetUpgradeItemImg(WeaponTitle:String, WeaponName:String) {
		enchantCont.SetUpgradeItemImg(WeaponTitle, WeaponName)
	}
	
	public function SetUpgradePartData(Amin:Number, Amax:Number,
									   Bmin:Number, Bmax:Number,
									   Cmin:Number, Cmax:Number,
									   Dmin:Number, Dmax:Number) {
										   
		enchantCont.SetUpgradePartData(Amin, Amax,
									   Bmin, Bmax,
									   Cmin, Cmax,
									   Dmin, Dmax)
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
		enchantCont.SetUpgradeGraphValue(upMinVal1,upMaxVal1,
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
    }	
}