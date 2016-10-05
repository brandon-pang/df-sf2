/**
 * ...
 * @author 
 */

import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.ManHuntHpInfo extends Panel
{
	public var hpInfoCont:MovieClip;
	
	private var _hp:Number = 0;
	private var maxPosX:Number = 95;
	private var _per:Number;
	
    public function ManHuntHpInfo()
    {         
        super();
		
		hpInfoCont.hpTitleTxt.text = "_hp";
		
		var format:TextFormat = new TextFormat();
		format.italic = true;
		
		hpInfoCont.hpTitleTxt.setTextFormat(format);
		hpInfoCont.hpTitleTxt.setNewTextFormat(format);
		
		hpInfoCont.hpTitleTxt.verticalAlign = "center";
		hpInfoCont.hpTxt.hpTxtMC.textField.verticalAlign = "center";
		hpInfoCont.hpTitleTxt.textAutoSize = "shrink";
		hpInfoCont.hpTxt.hpTxtMC.textField.textAutoSize = "shrink";
		hpInfoCont.hpTxt.hpTxtMC.textField.noTranslate = true;
		hpInfoCont.hpTxt.hpTxtMC.textField.html = true;
    }
	
	public function show(per:Number):Void
	{
		_per = (per != null)?per:15;
		gotoAndPlay("show");
	}
	
	public function setHp(hp:Number, total:Number):Void
	{
		TweenMax.killTweensOf(hpInfoCont.graph.mask);
		var ratio:Number = hp/total*100;
		if (ratio >= _per)
		{
			hpInfoCont.hpTxt.hpTxtMC.textField.htmlText = "<font color='#ffffff'>" + hp +"</font>";
			hpInfoCont.graph.bar.gotoAndStop(1);
		}
		else
		{
			hpInfoCont.hpTxt.hpTxtMC.textField.htmlText = "<font color='#ff0000'>" + hp +"</font>";
			hpInfoCont.graph.bar.gotoAndStop(2);
		}
		if (_hp < hp) { hpInfoCont.hpTxt.gotoAndPlay("show"); }
		_hp = hp;
		var targetX:Number = hp/total*maxPosX;
		TweenMax.to(
						hpInfoCont.graph.mask,
						0.2,
						{
							_x:targetX,
							ease:Cubic.easeOut
						}
					);
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		hpInfoCont.hpTxt.hpTxtMC.textField.text = "";
		_hp = 0;
	}
}