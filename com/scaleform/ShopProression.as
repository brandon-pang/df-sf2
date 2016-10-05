/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import flash.external.ExternalInterface;
import com.scaleform.FlexibleScrollingList;
import gfx.controls.Button;
import com.scaleform.ShopProressionItem;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.ShopProression extends UIComponent
{
	public var closeBtn:Button;
	public var progressionList:FlexibleScrollingList;
	public var contents:MovieClip;
	
	private var _termsType:Number;
	private var _imgName:String;
	
	private var mcLoader:MovieClipLoader;
	private var imgPathClass:String = "imgset_big_class.swf";
	private var imgPathChallenge:String = "img://Imgset_Challenge_Emblem.64.";
	
    public function ShopProression()
    {         
        super();
        
        contents.weaponTxt.noTranslate = true;
        contents.expalinTxt.noTranslate = true;
        contents.expalinTxt.verticalAlign = "center";
        contents.termsExplainTxt.noTranslate = true;
        contents.termsExplainTxt.verticalAlign = "center";
        
        contents.termsTxt.text = "_shop_buy_terms";
        contents.achieveTxt.noTranslate = true;
        
        mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
    }
	
	public function initProgression():Void
	{
		progressionList.dataProvider = [];
		progressionList.selectedIndex = -1;
		contents.weaponTxt.text = "";
		contents.expalinTxt.text = "";
		contents.cashBtn.label = "";
		contents.spBtn.label = "";
		contents.spBtn.disabled = true;
		contents.achieveTxt.htmlText = "";
		contents.completeMC._visible = false;
		contents.termsExplainTxt.text = "";
		mcLoader.unloadClip(contents.imgIcon);
	}
	
	public function setProgressionList(data:Array):Void
	{
		progressionList.dataProvider = data;
		progressionList.selectedIndex = 0;
	}
	
	public function setProgressionContents(
											weaponName:String, weaponExplain:String,
											progressionComp:Boolean, costCash:Number, costSp:Number,
											termsType:Number, detailTerms:String,
											imgName:String, curAchieve:Number, totalAchieve:Number
										):Void
	{
		_termsType = termsType;
		_imgName = imgName;
		contents.weaponTxt.text = weaponName;
		contents.expalinTxt.text = weaponExplain;
		if (costCash > 0)
		{
			contents.cashBtn.visible = true;
			var cash:String = Tool.comma(costCash);
			contents.cashBtn.label = "<img src='SHOP_CASH_USA' vspace='-5'> " + cash;
		}
		else
		{
			contents.cashBtn.label = "";
			contents.cashBtn.visible = false;
		}
		var sp:String = Tool.comma(costSp);
		contents.spBtn.label = "<img src='SHOP_SP' vspace='-5'> " + sp;
		if (progressionComp)
		{
			contents.spBtn.disabled = false;
			contents.completeMC._visible = true;
			if (_termsType == 0)
			{
				contents.achieveTxt.htmlText = "";
				contents.completeMC._x = 130;
				contents.completeMC._y = 211;
			}
			else if (_termsType == 1)
			{
				contents.achieveTxt.htmlText = curAchieve + "/" + totalAchieve;
				contents.completeMC._x = 130;
				contents.completeMC._y = 198;
			}
		}
		else
		{
			contents.spBtn.disabled = true;
			contents.completeMC._visible = false;
			if (_termsType == 0) { contents.achieveTxt.htmlText = ""; }
			else if (_termsType == 1) { contents.achieveTxt.htmlText = "<font color='#E10000'>" + curAchieve + "</font>/" + totalAchieve; }
		}
		lvLoader();
		contents.termsExplainTxt.text = detailTerms;
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		closeBtn.addEventListener("click", this, "onCloseBtnClick");
		
		progressionList.addEventListener("change", this, "onProgressionListItemClick");
		
		contents.cashBtn.addEventListener("click", this, "onCashBtnClick");
		contents.spBtn.addEventListener("click", this, "onSpBtnClick");
		
		contents.cashBtn.tooltip = "_progression_cashBtn_explain";
	}
	
	private function lvLoader():Void
	{
		if (_termsType == 0)
		{
			mcLoader.loadClip(imgPathClass, contents.imgIcon);
		}
		else if (_termsType == 1)
		{
			mcLoader.loadClip(imgPathChallenge + _imgName, contents.imgIcon);
		}
	}
	
	private function onLoadInit(mc:MovieClip):Void
	{
		if (_termsType == 0)
		{
			mc.set_level(_imgName);
			mc._xscale = 100;
			mc._yscale = 100;
			mc._x  = 99;
			mc._y  = 181;
		}
		else if (_termsType == 1)
		{
			mc._xscale = 90;
			mc._yscale = 90;
			mc._x  = 103;
			mc._y  = 177;
		}
	}
	
	private function onCloseBtnClick():Void
	{
		ExternalInterface.call("shopWeaponProgression_OnCloseBtnClick");
	}
	
	private function onProgressionListItemClick(e:Object):Void
	{
		if (e.index != -1)
		{
			ExternalInterface.call("shopWeaponProgression_OnListClick", e.index);
		}
	}
	
	private function onCashBtnClick(e:Object):Void
	{
		ExternalInterface.call("shopWeaponProgression_OnCashBtnClick");
	}
	
	private function onSpBtnClick(e:Object):Void
	{
		ExternalInterface.call("shopWeaponProgression_OnSpBtnClick");
	}
	
}