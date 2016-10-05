/**
 * ...
 * @author 
 */

import com.scaleform.udk.controls.ShopUnitExplainScroll;
import gfx.core.UIComponent;
import gfx.controls.Button;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.ShopUnitExplainItem extends UIComponent
{
	public var btnChrBuy:Button;
	public var transparencyBtn:Button;
	public var prevBtn:Button;
	public var nextBtn:Button;
	public var unitMC:MovieClip;
	public var wheelMC:ShopUnitExplainScroll;
	
	private var intervalId:Number;
	private var duration:Number = 2000;
	private var curIndex:Number = 0;
	private var unitWidth:Number = 556;
	
	public function ShopUnitExplainItem()
    {         
        super();  
    }
	
	public function removeUnit():Void
	{
		clearInterval(intervalId);
		TweenMax.killTweensOf(unitMC, true);
		
		transparencyBtn.removeEventListener("rollOver", this, "onTransBtnRollOver");
		transparencyBtn.removeEventListener("rollOut", this, "onTransBtnRollOut");
		transparencyBtn.removeEventListener("dragOut", this, "onTransBtnRollOut");
		
		prevBtn.removeEventListener("rollOver", this, "onTransBtnRollOver");
		prevBtn.removeEventListener("rollOut", this, "onTransBtnRollOut");
		prevBtn.removeEventListener("dragOut", this, "onTransBtnRollOut");
		nextBtn.removeEventListener("rollOver", this, "onTransBtnRollOver");
		nextBtn.removeEventListener("rollOut", this, "onTransBtnRollOut");
		nextBtn.removeEventListener("dragOut", this, "onTransBtnRollOut");
		
		prevBtn.removeEventListener("click", this, "prevExplain");
		nextBtn.removeEventListener("click", this, "nextExplain");
		
		wheelMC.removeEventListener("scrollWheel", this, "onUnitScrollWheel");
		Mouse.removeListener(wheelMC);
		wheelMC = null;
		curIndex = 0;
		intervalId = null;
		unitMC._x = 0;
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		btnChrBuy.label= "_shop_buy_chracter";
		btnChrBuy.addEventListener("click",this,"onBtnChrBuy");
		
		intervalId = setInterval(this, "intervalCallback", duration);
		
		transparencyBtn.addEventListener("rollOver", this, "onTransBtnRollOver");
		transparencyBtn.addEventListener("rollOut", this, "onTransBtnRollOut");
		transparencyBtn.addEventListener("dragOut", this, "onTransBtnRollOut");
		
		prevBtn.addEventListener("rollOver", this, "onTransBtnRollOver");
		prevBtn.addEventListener("rollOut", this, "onTransBtnRollOut");
		prevBtn.addEventListener("dragOut", this, "onTransBtnRollOut");
		nextBtn.addEventListener("rollOver", this, "onTransBtnRollOver");
		nextBtn.addEventListener("rollOut", this, "onTransBtnRollOut");
		nextBtn.addEventListener("dragOut", this, "onTransBtnRollOut");
		
		prevBtn.addEventListener("click", this, "prevExplain");
		nextBtn.addEventListener("click", this, "nextExplain");
		
		prevBtn.visible = false;
		nextBtn.visible = false;
		
		wheelMC.addEventListener("scrollWheel", this, "onUnitScrollWheel");
	}
	
	private function onUnitScrollWheel(e:Object):Void
	{
		if (e.delta == 1)
		{
			prevExplain();
		}
		else if (e.delta == -1)
		{
			nextExplain();
		}
	}
	
	private function onBtnChrBuy():Void
	{
		_global.shopBtnChrBuy();
	}
	
	private function intervalCallback():Void
	{
		nextExplain();
	}
	
	private function onTransBtnRollOver():Void
	{
		clearInterval(intervalId);
		//TweenMax.killTweensOf(unitMC, true);
		prevBtn.visible = true;
		nextBtn.visible = true;
	}
	
	private function onTransBtnRollOut():Void
	{
		intervalId = setInterval(this, "intervalCallback", duration);
		//TweenMax.killTweensOf(unitMC, true);
		prevBtn.visible = false;
		nextBtn.visible = false;
	}
	
	private function nextExplain():Void
	{
		TweenMax.killTweensOf(unitMC, true);
		if (curIndex == 2) { curIndex = 0; unitMC._x = unitWidth; }
		else { curIndex = curIndex + 1; } 
		var targetPos:Number = curIndex * -(unitWidth);
		TweenMax.to(unitMC, 0.5, {_x:targetPos, ease:Cubic.easeOut});
	}
	
	private function prevExplain():Void
	{
		TweenMax.killTweensOf(unitMC, true);
		if (curIndex == -1) { curIndex = 1; unitMC._x = -(unitWidth*2); }
		else { curIndex = curIndex - 1; }
		var targetPos:Number = curIndex * -(unitWidth);
		TweenMax.to(unitMC, 0.5, {_x:targetPos, ease:Cubic.easeOut});
	}
	
}

