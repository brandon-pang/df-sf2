/**
 * ...
 * @author 
 */

import gfx.controls.ListItemRenderer;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
 class com.scaleform.ShopProressionItem extends ListItemRenderer
{
	public var bg:MovieClip;
	public var hitBack:MovieClip;
	public var arrow:MovieClip;
	public var imgIcon:MovieClip;
	public var weaponTxt:TextField;
	public var commentTxt:TextField;
	public var markMC:MovieClip;
	private var mcLoader:MovieClipLoader;

	public function ShopProressionItem()
	{
		super();

		hitBack.hitTestDisable = true;
		arrow.hitTestDisable = true;

		weaponTxt.noTranslate = true;
		weaponTxt.textAutoSize = "shrink";
		commentTxt.noTranslate = true;
		commentTxt.textAutoSize = "shrink";

		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
	}

	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this._visible = false;
			return;
		}

		this.data = data;
		this._visible = true;

		if (data.Complete)
		{
			bg.gotoAndStop(2);
		}
		weaponTxt.text = data.WeaponName;
		commentTxt.text = data.WeaponComment;

		lvLoader();
	}

	private function configUI():Void
	{
		super.configUI();
	}

	private function lvLoader():Void
	{
		var mark:String = data.ItemImg.slice(-4, -1);
		var markNum:Number = Number(data.ItemImg.slice(-1));
		if (mark == "_mk" && !isNaN(markNum))
		{
			data.ItemImg = data.ItemImg.slice(0, -4);
			markMC.gotoAndStop(markNum);
		}
		else
		{
			markMC.gotoAndStop(1);
		}
		var chk:String = data.ItemImg.substr(-4);
		if (chk == "_ani")
		{
			mcLoader.loadClip(UDKUtils.WeaponImgAniPath + data.ItemImg,imgIcon);
		}
		else
		{
			mcLoader.loadClip(UDKUtils.WeaponImgPath+ data.ItemImg,imgIcon);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		mc._x = -8;
		mc._y = 1;
		mc._xscale = 50;
		mc._yscale = 50;
	}
}