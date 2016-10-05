/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.ManHuntBeastChgItem extends UIComponent
{
	public var bg:MovieClip;
	public var classIcon:MovieClip;
	public var beastNameTxt:TextField;
	public var weaponTypeTxt:TextField;
	//public var beastSpeedTxt:TextField;
	//public var speedGraph:MovieClip;
	public var mainWeapon:MovieClip;
	public var subWeapon:MovieClip;
	public var shortCutTxt:TextField;
	
    public function ManHuntBeastChgItem()
    {         
        super();
        
        var format:TextFormat = new TextFormat();
		format.italic = true;
		
		beastNameTxt.setTextFormat(format);
		beastNameTxt.setNewTextFormat(format);
		weaponTypeTxt.setTextFormat(format);
		weaponTypeTxt.setNewTextFormat(format);
		//beastSpeedTxt.setTextFormat(format);
		//beastSpeedTxt.setNewTextFormat(format);
		
		beastNameTxt.verticalAlign = "center";
		weaponTypeTxt.verticalAlign = "center";
		//beastSpeedTxt.verticalAlign = "center";
		mainWeapon.weaponName.verticalAlign = "center";
		subWeapon.weaponName.verticalAlign = "center";
		
		beastNameTxt.textAutoSize = "shrink";
		weaponTypeTxt.textAutoSize = "shrink";
		//beastSpeedTxt.textAutoSize = "shrink";
		mainWeapon.weaponName.textAutoSize = "shrink";
		subWeapon.weaponName.textAutoSize = "shrink";

		beastNameTxt.noTranslate = true;
		weaponTypeTxt.noTranslate = true;
		mainWeapon.weaponName.noTranslate = true;
		subWeapon.weaponName.noTranslate = true;
		shortCutTxt.weaponName.noTranslate = true;
    }
	
	public function initItem():Void
	{
		classIcon.gotoAndStop(1);
		beastNameTxt.text = "";
		weaponTypeTxt.text = "";
		//speedGraph.gotoAndStop(1);
		mainWeapon.classIcon.gotoAndStop(1);
		mainWeapon.weaponName.text = "";
		subWeapon.classIcon.gotoAndStop(1);
		subWeapon.weaponName.text = "";
		shortCutTxt.text = "";
		
		classIcon._alpha = 40;
		beastNameTxt._alpha = 40;
		weaponTypeTxt._alpha = 40;
		//beastSpeedTxt._alpha = 40;
		//speedGraph._alpha = 40;
		mainWeapon._alpha = 40;
		subWeapon._alpha = 40;
		
		bg.gotoAndStop(2);
	}
	
	public function selectItem(value:Boolean):Void
	{
		if (value)
		{
			classIcon._alpha = 100;
			beastNameTxt._alpha = 100;
			weaponTypeTxt._alpha = 100;
			//beastSpeedTxt._alpha = 100;
			//speedGraph._alpha = 100;
			mainWeapon._alpha = 100;
			subWeapon._alpha = 100;
			
			bg.gotoAndPlay("select");
		}
		else
		{
			classIcon._alpha = 40;
			beastNameTxt._alpha = 40;
			weaponTypeTxt._alpha = 40;
			//beastSpeedTxt._alpha = 40;
			//speedGraph._alpha = 40;
			mainWeapon._alpha = 40;
			subWeapon._alpha = 40;
			
			bg.gotoAndPlay("up");
		}
	}
	
	public function setItem(beastType:String, beastName:String, weaponType:String, mainWeaponName:String, subWeaponName:String, shortCut:String):Void
	{
		classIcon.gotoAndStop(beastType);
		beastNameTxt.text = beastName;
		weaponTypeTxt.text = weaponType;
		weaponTypeTxt._x = beastNameTxt._x + beastNameTxt.textWidth + 6;
		//speedGraph.gotoAndStop(beastType);
		//speedGraph._x = beastSpeedTxt._x + beastSpeedTxt.textWidth + 6;
		mainWeapon.classIcon.gotoAndStop(beastType);
		mainWeapon.weaponName.text = mainWeaponName;
		subWeapon.classIcon.gotoAndStop(beastType);
		subWeapon.weaponName.text = subWeaponName;
		shortCutTxt.text = shortCut;
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		initItem();
	}
	
	
	
	
	
}