/**
 * ...
 * @author 
 */
import gfx.controls.Button;
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.controls.UILoader;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.Enchant.PopupUpgradeItemView extends UIComponent
{	
	public var txtSet:MovieClip;
	public var gridBg:MovieClip;
	public var bgAni:MovieClip;	
	public var bg:MovieClip;	
	public var btnPartOk:Button;
	public var weaponImgLoader:UILoader;
	public var weaponTitleMc:MovieClip;	
	
	
    public function PopupUpgradeItemView() {         
        super();  
    }
	
	public function setItemImgLoader(WeaponTitle:String,WeaponName:String)
	{	
		var title:String = WeaponTitle;
		var imgPathWeapon:String;		
		var imgName = WeaponName;
		var chk = imgName.substr( -4);
		var WpChgName = ""
		weaponTitleMc.txtWeaponTitle.htmlText = title;	
		
		if (_global.gfxPlayer)
		{
			imgPathWeapon = "D:/UI_DESIGN_SVN/이미지셋/가챠/가챠상품/" + imgName + ".png";			
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
		}	
		weaponImgLoader.source = imgPathWeapon;	   
	}
	
	public function OnOpenPopup() {
		this.gotoAndPlay("open");
	}
	
	public function OnClosePopup() {
		this.gotoAndPlay("close");
	}
	
	private function onOpenStartContainer():Void
	{
		weaponTitleMc._alpha = 0
		
		var vis:Boolean = true;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bg._visible = vis;		
		btnPartOk._visible = vis;
		//weaponImgLoader._visible = vis;
		weaponTitleMc._visible = vis;
		TweenMax.to(weaponTitleMc, 0.5, {_alpha:100, ease:Cubic.easeIn});
		this._y = 80
		ExternalInterface.call("popupUpgradeItemResultOpen", "");
	}
	
	private function onOpenEndContainer():Void
	{
		weaponImgLoader._alpha = 20
		
		var vis:Boolean = true;
		weaponImgLoader._visible = vis;
		
		bgAni.gotoAndPlay("open");	
		TweenMax.to(weaponImgLoader, 0.3, {_alpha:100, ease:Cubic.easeIn});
		
	}
	
	private function onCloseEndContainer():Void
	{	
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible = vis;
		bg._visible = vis;		
		btnPartOk._visible = vis;
		weaponImgLoader._visible = vis;
		weaponTitleMc._visible = vis;
		
		bgAni.gotoAndPlay(1);
		
		this._y = -1000
		
		ExternalInterface.call("popupUpgradeItemResultClose", "");
	}
		
	private function OnBtnPartClickHandle(e:Object) {
		OnClosePopup()
		//ExternalInterface.call("popupUpgradeItemResultClose", "");
	}
	
    private function configUI():Void
    {
    	super.configUI();
		
		this._y = -1000
		
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bg._visible = vis;		
		btnPartOk._visible = vis
		weaponImgLoader._visible = vis
		weaponTitleMc._visible = vis
		
		txtSet.txtTitle.verticalAlign = "center";
		txtSet.txtTitle.textAutoSize = "shrink";
		txtSet.txtContext.verticalAlign = "center";
		txtSet.txtContext.textAutoSize = "shrink";		
		txtSet.txtTitle.text = "_enchant_upgrade_result_title";
		txtSet.txtContext.text = "_enchant_upgrade_result_context";	
		
		weaponTitleMc.txtWeaponTitle.verticalAlign = "center";
		weaponTitleMc.txtWeaponTitle.textAutoSize = "shrink";
		
		this.addEventListener("openStart", this, "onOpenStartContainer");
		this.addEventListener("openEnd", this, "onOpenEndContainer");
    	this.addEventListener("closeEnd", this, "onCloseEndContainer"); 
		
		btnPartOk.label = "_ok";
		//btnPartOk.addEventListener("click", this, "OnBtnPartClickHandle");
    }
}