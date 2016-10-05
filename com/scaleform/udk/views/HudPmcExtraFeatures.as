/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import com.scaleform.udk.utils.UDKUtils

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.udk.views.HudPmcExtraFeatures extends Panel
{
	
	public var pmcExtraCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathClass:String = "imgset_class.swf";
	private var _camoIndex:String;
	private var _classicon:String;
	private var _manner:String;
	private var _inited:Boolean = true;
	private var LIST_BASE_X:Number = 6;
	private var LIST_BASE_Y:Number = 32;
	private var damageItemArr:Array = [];
					   
	
    public function HudPmcExtraFeatures()
    {         
        super();
        
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        
        pmcExtraCont.killMeTxt.text = "_pmc_extra_killme";
        pmcExtraCont.weaponTxt.noTranslate = true;
        pmcExtraCont.codenameTxt.noTranslate = true;
        pmcExtraCont.codenameTxt.html = true;
        pmcExtraCont.damageList.damageTxt.text = "_pmc_extra_damage";
        pmcExtraCont.damageList.damageSumTxt.noTranslate = true;
        pmcExtraCont.accrueScore.textField.noTranslate = true;
        pmcExtraCont.accrueScore.textField.html = true;
        pmcExtraCont.accrueScore.textField.textAutoSize="shrink";
        pmcExtraCont.accrueScore.textField.verticalAlign = "center";
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setKillMeData(
									weaponIndex:String, camoIndex:String, weaponName:String,
									classIcon:String, manner:String, codeName:String,
									damageArr:Array, sum:Number, limit:Number,
									accrueKill:String, accrueKillNum:Number, killVariation:Number,
									accrueAssist:String, accrueAssistNum:Number, assistVariation:Number,
									accrueDeath:String, accrueDeathNum:Number
								):Void
	{
		initContents();
		if (codeName == "" || codeName == null || weaponIndex == "")
		{
			pmcExtraCont.killMeTxt._visible = false;
			pmcExtraCont.bg._visible = false;
			pmcExtraCont.damageList._y = 0;
		}
		else
		{
			loadWeaponIcon(weaponIndex, camoIndex);
			pmcExtraCont.weaponTxt.text = weaponName;
			_manner = manner;
			_classicon = classIcon;
			loadClassIcon();
			pmcExtraCont.codenameTxt.htmlText = codeName;
			pmcExtraCont.killMeTxt._visible = true;
			pmcExtraCont.bg._visible = true;
		}
		if (damageArr != null && damageArr.length != 0)
		{
			pmcExtraCont.damageList.damageSumTxt.text = Tool.comma(sum);
			if (sum < limit) { pmcExtraCont.damageList.damageBar._xscale = sum / limit * 100; }
			else { pmcExtraCont.damageList.damageBar._xscale = 100; }
			for (var i:Number=0; i<damageArr.length; i++)
			{
				var item:MovieClip = pmcExtraCont.damageList.attachMovie("pmcExtraDamageItem", "pmcExtraDamageItem"+i, pmcExtraCont.damageList.getNextHighestDepth(), {_x:LIST_BASE_X});
				item._y = LIST_BASE_Y + i * 28;
				item.setItem(damageArr[i]);
				if (i == damageArr.length-1) { item.line._visible = false; }
				item.box._visible = (i%2 == 0);
				damageItemArr.push(item);
			}
			pmcExtraCont.damageList.bg._height = damageArr.length * 28 + 36;
			pmcExtraCont.damageList._visible = true;
			
			if (accrueKill != null && accrueKillNum != null && killVariation != null &&
				accrueAssist != null && accrueAssistNum != null && assistVariation != null &&
				accrueDeath != null && accrueDeathNum != null)
			{
				var accrueStr:String = "";
				accrueStr += "<font size='11' color='#aaaaaa'>" + accrueKill + "</font>" + " " + accrueKillNum;
				if (killVariation != 0) { accrueStr += "<font color='#ff0000'>(<img src='PMC_death_UP'/>" + killVariation + ")</font>"; }
				accrueStr += " / ";
				accrueStr += "<font size='11' color='#aaaaaa'>" + accrueAssist + "</font>" + " " + accrueAssistNum;
				if (assistVariation != 0) { accrueStr += "<font color='#ff0000'>(<img src='PMC_death_UP'/>" + assistVariation + ")</font>"; }
				accrueStr += " / ";
				accrueStr += "<font size='11' color='#aaaaaa'>" + accrueDeath + "</font>" + " " + accrueDeathNum;
				
				pmcExtraCont.accrueScore.textField.htmlText = accrueStr;
				pmcExtraCont.accrueScore._visible = true;
			}
		}
		else
		{
			pmcExtraCont.damageList._visible = false;
			pmcExtraCont.accrueScore._visible = false;
		}
		
		_inited = false;
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		this.addEventListener("openEnd", this, "onOpenEnd");
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onOpenEnd():Void
	{
		
	}
	
	private function onCloseEnd():Void
	{
		initContents();
	}
	
	private function initContents():Void
	{
		if (_inited) { return; }
		//if (pmcExtraCont.weaponIcon["weaponImg"]) { pmcExtraCont.weaponIcon["weaponImg"].removeMovieClip(); }
		//if (pmcExtraCont.weaponIcon["camoImg"]) { pmcExtraCont.weaponIcon["camoImg"].removeMovieClip(); }
		mcLoader.unloadClip(pmcExtraCont.weaponIcon);
		_camoIndex = "";
		pmcExtraCont.weaponTxt.text = "";
		mcLoader.unloadClip(pmcExtraCont.classicon);
		pmcExtraCont.numbericon._visible = false;
		pmcExtraCont.codenameTxt.htmlText = "";
		for (var i:Number=0; i<damageItemArr.length; i++)
		{
			if (damageItemArr[i])
			{
				damageItemArr[i].removeMovieClip();
			}
		}
		damageItemArr = [];
		pmcExtraCont.damageList._y = 107;
		pmcExtraCont.accrueScore.textField.htmlText = "";
		pmcExtraCont.accrueScore._visible = false;
		
		_inited = true;
	}
	
	private function loadWeaponIcon(weaponIndex:String, camoIndex:String):Void
	{
		if (weaponIndex == null || weaponIndex == "") { return; } 
		var _Weapon = WeaponChgName(weaponIndex.toLowerCase());	
		mcLoader.loadClip("img://Imgset_Combat." + _Weapon.toLowerCase(), pmcExtraCont.weaponIcon);
		//_camoIndex = camoIndex;		
	}
	
	private function WeaponChgName(str):String
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
			
			if (divArr.length == 1)
			{
				wpChgName = str;
			}
			
			if (divArr.length == 2)
			{
				chk2str = strChk(divArr[1]);
				if (chk2str == "")
				{
					wpChgName = divArr[0];
				}
				else
				{
					wpChgName = divArr[0] + "_" + chk2str;
				}
			}
			if (divArr.length == 3)
			{
				chk2str = strChk(divArr[1]);
				chk3str = strChk(divArr[2]);
				if (chk2str == "" && chk3str == "")
				{
					wpChgName = divArr[0];
				}
				else if (chk2str != "" && chk3str == "")
				{
					wpChgName = divArr[0] + "_" + chk2str;
				}
				else if (chk2str == "" && chk3str != "")
				{
					wpChgName = divArr[0] + "_" + chk3str;
				}
				else if (chk2str != "" && chk3str != "")
				{
					wpChgName = divArr[0] + "_" + chk2str + "_" + chk3str;
				}
			}
			
			if (divArr.length >= 4)
			{
				chk2str = strChk(divArr[1]);
				chk3str = strChk(divArr[2]);
				chk4str = strChk(divArr[3]);
				//000
				//100
				//110
				//010
				//011
				//001
				//101
				//111
				if (chk2str == "" && chk3str == "" && chk4str=="")
				{
					wpChgName = divArr[0];
				}
				else if (chk2str != "" && chk3str == ""&& chk4str == "")
				{
					wpChgName = divArr[0] + "_" + chk2str;
				}
				else if (chk2str != "" && chk3str != ""&& chk4str == "")
				{
					wpChgName = divArr[0] + "_" + chk2str+"_" + chk3str;
				}
				//
				else if (chk2str == "" && chk3str != ""&& chk4str == "")
				{
					wpChgName = divArr[0] + "_" + chk3str;
				}
				else if (chk2str == "" && chk3str != ""&& chk4str != "")
				{
					wpChgName = divArr[0] + "_" + chk3str+ "_" + chk4str;
				}
				//
				else if (chk2str == "" && chk3str == ""&& chk4str != "")
				{
					wpChgName = divArr[0] + "_" + chk4str;
				}
				else if (chk2str != "" && chk3str == ""&& chk4str != "")
				{
					wpChgName = divArr[0] + "_" + chk2str+ "_" + chk4str;
				}			
				//
				else if (chk2str != "" && chk3str != ""&& chk4str != "")
				{
					wpChgName = divArr[0] + "_" + chk2str + "_" + chk3str+"_" + chk4str;
				}
			}	
		}
		trace ("change name = "+wpChgName)
		return wpChgName
	}

	private function strChk(str:String):String
	{
		var tStr:String = str;
		var rStr:String = "";
		for (var i:Number = 0; i < UDKUtils.weaponOptionArr.length; i++)
		{
			if (UDKUtils.weaponOptionArr[i] == tStr)
			{
				rStr = tStr;
			}
		}
		return rStr;
	}
	
	private function loadClassIcon():Void
	{
		if (_classicon.charAt(0) == "R")
		{
			pmcExtraCont.numbericon._visible = true;
			pmcExtraCont.numbericon.gotoAndStop(1);
			pmcExtraCont.numbericon["txtNo"].text = _classicon.substring(1);
			mcLoader.unloadClip(pmcExtraCont.classicon);

		}
		else if (_classicon.charAt(0) == "B")
		{
			pmcExtraCont.numbericon._visible = true;
			pmcExtraCont.numbericon.gotoAndStop(2);
			pmcExtraCont.numbericon["txtNo"].text = _classicon.substring(1);
			mcLoader.unloadClip(pmcExtraCont.classicon);

		}
		else
		{
			pmcExtraCont.numbericon._visible = false;
			mcLoader.loadClip(_imgPathClass, pmcExtraCont.classicon);
		}
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classicon")
		{
			mc.set_level(_classicon);
			var manner:String = _manner;
			if (manner == "4")
			{
				mc.manner.gotoAndStop(2);
			}
			else
			{
				mc.manner.gotoAndStop(1);
			}
			mc._xscale = 80;
			mc._yscale = 80;
		}
		else if (mc._name == "weaponIcon")
		{
			mc._x = pmcExtraCont.bg._width - mc._width >> 1;
		}
	}
}