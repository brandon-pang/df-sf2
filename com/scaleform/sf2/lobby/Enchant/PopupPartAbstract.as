/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.Enchant.PopupPartAbstract extends UIComponent
{	
	public var txtSet:MovieClip;
	public var gridBg:MovieClip;
	public var bgAni:MovieClip;
	public var bar:MovieClip;
	public var bg:MovieClip;
	public var abstractAction:MovieClip;
	public var AbstractTime:Number;
	
    public function PopupPartAbstract() {         
        super();  
    }
	
	public function setTimeValue() {
		bar._width = 500;
		TweenMax.to(bar, AbstractTime, {_width:0, ease:Cubic.easeIn,delay:0.5,onComplete:Delegate.create(this,OnCompGauge)});
	}
	private function OnCompGauge():Void {
		OnClosePopupAbstract()
	}
	
	public function OnOpenPopupAbstract() {
		this.gotoAndPlay("open");
		ExternalInterface.call("popupPartAbstractOpen", "");
	}
	
	public function OnClosePopupAbstract() {
		this.gotoAndPlay("close");
	}
	
	private function onOpenStartContainer():Void
	{
		var vis:Boolean = true;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bar._visible=vis;
		bg._visible = vis;
		abstractAction._visible = vis;
		this._y = 80;
	}
	
	private function onOpenEndContainer():Void
	{
		bgAni.gotoAndPlay("open");
		abstractAction.gotoAndPlay("open");
		setTimeValue();
	}
	
	private function onCloseEndContainer():Void
	{	
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bar._visible =vis;
		bg._visible = vis;
		abstractAction._visible = vis;
		
		bgAni.gotoAndPlay(1);
		abstractAction.gotoAndPlay(1);
		this._y = -1000;
		
		ExternalInterface.call("popupPartAbstractClose", "");
		
		if (_global.gfxPlayer) {
			_parent.popupAbstractResult.OnOpenPopupAbstract();
		}
	}
	
    private function configUI():Void
    {
    	super.configUI();
		
		this._y = -1000;
		
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bar._visible=vis;
		bg._visible = vis;
		abstractAction._visible = vis;
		
		txtSet.txtTitle.verticalAlign = "center";
		txtSet.txtTitle.textAutoSize = "shrink";
		txtSet.txtContext.verticalAlign = "center";
		txtSet.txtContext.textAutoSize = "shrink";		
		txtSet.txtTitle.text = "_enchant_parts_abstract_title";
		txtSet.txtContext.text = "_enchant_parts_abstract_context";
		
		this.addEventListener("openStart", this, "onOpenStartContainer");
		this.addEventListener("openEnd", this, "onOpenEndContainer");
    	this.addEventListener("closeEnd", this, "onCloseEndContainer");    
		
		AbstractTime = 2;
    }
}