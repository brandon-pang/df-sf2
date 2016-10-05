/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.CoolDownMaskPerFrame;
import gfx.controls.ScrollingList;
import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.sf2.hud.shooter.ShooterEquipSlot extends UIComponent
{
	public var imgIcon:MovieClip;
	public var camoTg:MovieClip;
	public var key:MovieClip;
	public var bulletTxt:TextField;
	public var infinite:MovieClip;

	private var _imgSetIndex:String;
	private var _imgSet:String;
	private var _camoBgName:String;

	private var mcLoader:MovieClipLoader;

	public function ShooterEquipSlot()
	{
		super();

		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		bulletTxt.verticalAlign = "center";
		bulletTxt.textAutoSize = "shrink";
		bulletTxt.noTranslate = true;

		infinite._visible = false;
	}

	public function setSlot(index:String, imgSet:String, camoBgName:String, bullet:Number):Void
	{

		trace("=====DashBoard slot Setting =================  SlotNo = " + this._name + " imgName = " + imgSet + " camoBgName = " + camoBgName);

		_imgSetIndex = index;
		_imgSet = imgSet;
		_camoBgName = camoBgName;
		var n = this._name.substr(-1);

		if (index == "" || imgSet == "")
		{
			mcLoader.unloadClip(imgIcon);
			mcLoader.unloadClip(camoTg.tg);
			key.gotoAndStop("off");
			bulletTxt.text = "";
			camoTg._visible=false
		}
		else
		{
			lvLoader();
			key.gotoAndStop("on");
			if (bullet != -1)
			{
				if (n == "0" || n == "1")
				{
					bulletTxt._x = -11;
					bulletTxt.text = bullet.toString() + "/ ";
					infinite._visible = true;
				}
				else
				{
					bulletTxt._x = 8;
					bulletTxt.text = bullet.toString();
					infinite._visible = false;
				}
			}
			else
			{
				bulletTxt._x = 8;
				bulletTxt.text = "";
				infinite._visible = true;
			}
		}
	}

	public function setBulletSlot(bullet:Number):Void
	{
		var n = this._name.substr(-1);
		if (n == "0" || n == "1")
		{
			bulletTxt._x = -11;
			bulletTxt.text = bullet.toString() + "/ ";
			infinite._visible = true;
		}
		else
		{
			bulletTxt._x = 8;
			bulletTxt.text = bullet.toString();
			infinite._visible = false;
		}
	}

	private function configUI():Void
	{
		super.configUI();
	}

	private function lvLoader():Void
	{
		var imgPathArmor:String;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var camoImgPath:String;
		var imgName = _imgSet;
		var chk:String = imgName.substr(-4);

		if (_global.gfxPlayer)
		{
			imgPathArmor = "gfxImgSet/Armor/" + imgName + ".png";
			imgPathCashItem = "gfxImgSet/CashItem/" + imgName + ".png";
			imgPathWeapon = "gfxImgSet/Weapon/" + imgName + ".png";
		}
		else
		{
			imgPathArmor = UDKUtils.ArmorImgPath + imgName;
			if (chk == "_ani")
			{
				imgPathCashItem = UDKUtils.CashImgAniPath + imgName;
				imgPathWeapon = UDKUtils.WeaponImgAniPath + imgName;
			}
			else
			{
				imgPathCashItem = UDKUtils.CashImgPath + imgName;
				imgPathWeapon = UDKUtils.WeaponImgPath + imgName;
			}
		}

		if (_imgSetIndex == "0")
		{
			mcLoader.loadClip(imgPathArmor,imgIcon);
		}
		else if (_imgSetIndex == "1")
		{
			mcLoader.loadClip(imgPathWeapon,imgIcon);
		}
		else if (_imgSetIndex == "3")
		{
			mcLoader.loadClip(imgPathCashItem,imgIcon);
		}

		if (_camoBgName == ""|| _camoBgName==null)
		{
			mcLoader.unloadClip(camoTg.tg);
			camoTg._visible=false
		}
		else
		{
			camoTg._visible=true

			var camoChk:String = _camoBgName.substr(-4);
			if (_global.gfxPlayer)
			{
				camoImgPath = "gfxImgSet/Camo/" + _camoBgName + ".png";
			}
			else
			{
				if (camoChk == "_ani")
				{
					camoImgPath = UDKUtils.CamoImgAniPath + _camoBgName;
				}
				else
				{
					camoImgPath = UDKUtils.CamoImgPath + _camoBgName;
				}
			}
			mcLoader.loadClip(camoImgPath,camoTg.tg);
		}

		
	}

	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "imgIcon")
		{
			if (_imgSetIndex == "0")
			{
				mc._x = -15;
				mc._y = 4;
				mc._xscale = 50;
				mc._yscale = 50;
			}
			else if (_imgSetIndex == "1")
			{
				mc._x = -8;
				mc._y = 5;
				mc._xscale = 45;
				mc._yscale = 45;
			}
			else if (_imgSetIndex == "3")
			{
				mc._x = 20;
				mc._y = 0;
				mc._xscale = 50;
				mc._yscale = 50;
			}
		}
	}


}