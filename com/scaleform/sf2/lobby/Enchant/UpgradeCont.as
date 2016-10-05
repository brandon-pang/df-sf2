import gfx.utils.Delegate;
import gfx.core.UIComponent;
import gfx.controls.Button;
import gfx.controls.UILoader;
import com.scaleform.udk.utils.UDKUtils;
import com.scaleform.sf2.lobby.Enchant.ListPartControl
import com.greensock.*; 
import com.greensock.easing.*;
import com.scaleform.sf2.lobby.Enchant.GraphCont;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.Enchant.UpgradeCont extends UIComponent
{
	public var txtTitle:TextField;
	public var btnBuySp:Button;
	public var btnBuyCash:Button;
	public var btnUpgrade:Button;
	public var partMcA:ListPartControl;
	public var partMcB:ListPartControl;
	public var partMcC:ListPartControl;
	public var partMcD:ListPartControl;
	public var weaponImgLoader:UILoader;
	public var combatImgLoader:UILoader;
	public var txtWeaponTitle:TextField;
	public var btnPage1:Button;
	public var btnPage2:Button;
	public var graphCont:GraphCont;
    
	public function UpgradeCont() {         
        super(); 	
    }    

	public function setItemImgLoader(WeaponTitle:String,WeaponName:String)
	{	
		var title:String = WeaponTitle;
		var imgPathWeapon:String;
		var combatPath:String;
		var imgName = WeaponName;
		var chk = imgName.substr( -4);
		var WpChgName = "";
		
		txtWeaponTitle.htmlText = title;		
		WpChgName = WeaponChgName(imgName.toLowerCase());
		
		if (_global.gfxPlayer)
		{
			imgPathWeapon = "D:/UI_DESIGN_SVN/이미지셋/가챠/가챠상품/" + imgName + ".png";
			combatPath="D:/UI_DESIGN_SVN/이미지셋/무기/컴뱃메시지/combat_silhouette/AR/width를 128로/"+ WpChgName.toLowerCase() + ".png";
		}
		else
		{	
			if (chk == "_ani")
			{				
				imgPathWeapon = "upk://Imgset_GachaSelect_BigItem." + imgName;
			}
			else
			{
				imgPathWeapon = "img://Imgset_GachaSelect_BigItem." + imgName;
			}	
			
			combatPath="img://Imgset_Combat."+WpChgName.toLowerCase()
		}
		
		weaponImgLoader.source = imgPathWeapon;	   
		combatImgLoader.source = combatPath;
	}		
	
	private function WeaponChgName(str:String)
	{
		var wpChgName:String = "";
		var chk2str:String = "";
		var chk3str:String = "";
		var chk4str:String ="";
		
		var divArr = [];
		var sliceStr = str.substr(0, 7);	
		
		if (sliceStr == "manhunt" || sliceStr == "crawler" || sliceStr == "gas_stu" || 
			sliceStr == "liberti" || sliceStr == "ripper_" || sliceStr == "stunner" || 
			sliceStr == "tyrant_")
		{
			wpChgName = str;
		}
		else
		{
			var divArr = str.split("_");			
			if (divArr.length == 1){wpChgName = str;}			
			if (divArr.length == 2){
				chk2str = strChk(divArr[1]);
				if (chk2str == ""){wpChgName = divArr[0];}
				else {wpChgName = divArr[0] + "_" + chk2str;}
			}
			if (divArr.length == 3){
				chk2str = strChk(divArr[1]);
				chk3str = strChk(divArr[2]);
				if (chk2str == "" && chk3str == ""){wpChgName = divArr[0];}
				else if (chk2str != "" && chk3str == ""){wpChgName = divArr[0] + "_" + chk2str;}
				else if (chk2str == "" && chk3str != ""){wpChgName = divArr[0] + "_" + chk3str;}
				else if (chk2str != "" && chk3str != ""){wpChgName = divArr[0] + "_" + chk2str + "_" + chk3str;}
			}			
			if (divArr.length >= 4){
				chk2str = strChk(divArr[1]);
				chk3str = strChk(divArr[2]);
				chk4str = strChk(divArr[3]);
				if (chk2str == "" && chk3str == "" && chk4str==""){wpChgName = divArr[0];}
				else if (chk2str != "" && chk3str == ""&& chk4str == ""){wpChgName = divArr[0] + "_" + chk2str;}
				else if (chk2str != "" && chk3str != ""&& chk4str == ""){wpChgName = divArr[0] + "_" + chk2str+"_" + chk3str;}
				//
				else if (chk2str == "" && chk3str != ""&& chk4str == ""){wpChgName = divArr[0] + "_" + chk3str;}
				else if (chk2str == "" && chk3str != ""&& chk4str != ""){wpChgName = divArr[0] + "_" + chk3str+ "_" + chk4str;}
				//
				else if (chk2str == "" && chk3str == ""&& chk4str != ""){wpChgName = divArr[0] + "_" + chk4str;}
				else if (chk2str != "" && chk3str == ""&& chk4str != ""){wpChgName = divArr[0] + "_" + chk2str+ "_" + chk4str;}			
				//
				else if (chk2str != "" && chk3str != ""&& chk4str != ""){wpChgName = divArr[0] + "_" + chk2str + "_" + chk3str+"_" + chk4str;}
			}	
		}		
		return wpChgName
	}

	private function strChk(str:String):String{
		var tStr:String = str;
		var rStr:String = "";
		for (var i:Number = 0; i < UDKUtils.weaponOptionArr.length; i++){
			if (UDKUtils.weaponOptionArr[i] == tStr){rStr = tStr;}
		}
		return rStr;
	}
	
	private function onBtnPageHandler(e:Object) {
		//trace (e.target._name)
		var n = e.target._name;
		if (n == "btnPage1") {
			btnPage1._visible = false;
			btnPage2._visible = !false;
			TweenMax.to(weaponImgLoader, 0.3, { _x:-449, ease:Cubic.easeInOut } );
			TweenMax.to(graphCont, 0.3, { _x:30, ease:Cubic.easeInOut } );
			ExternalInterface.call("onWeaponPageClicked", "");
		}else {
			btnPage1._visible = !false;
			btnPage2._visible = false;
			TweenMax.to(weaponImgLoader, 0.3, { _x:-43, ease:Cubic.easeInOut } );
			TweenMax.to(graphCont, 0.3, { _x:436, ease:Cubic.easeInOut } );
			ExternalInterface.call("onGraphPageClicked", "");
		}		
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
		graphCont.setGraphValue(upMinVal1,upMaxVal1,
								upMinVal2,upMaxVal2,
								upMinVal3,upMaxVal3,
								upMinVal4,upMaxVal4,								  
								difMinVal1,difMaxVal1,
								difMinVal2,difMaxVal2,
								difMinVal3,difMaxVal3,
								difMinVal4, difMaxVal4,
								magazineMinVal, magzineMaxVal) 
	}
	
    private function configUI():Void
    {
    	super.configUI();
		txtTitle.verticalAlign = "center";
		txtTitle.text = "_enchant_upgrade";
		txtWeaponTitle.verticalAlign = "center";
		txtWeaponTitle.textAutoSize = "shrink";
		
		btnBuySp.label = "<img src='SHOP_SP' vspace='-5'>Parts Buy";
		btnBuyCash.label = "<img src='SHOP_CASH' vspace='-5'>Parts Buy";
		btnUpgrade.label = "_ebchant_btn_upgrade";
		
		//setItemImgLoader("AK103_EOTECH","ak103_eotech_rudolph_gb");
		
		//partMcA.setData(100, 300);
		//partMcB.setData(140, 300);
		//partMcC.setData(200, 300);
		//partMcD.setData(260, 300);
		
		btnPage1.addEventListener("click", this, "onBtnPageHandler")
		btnPage2.addEventListener("click", this, "onBtnPageHandler")
		
		btnPage2._visible = false;
    }
}