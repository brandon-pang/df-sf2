/**
 * ...
 * @author 
 */
import gfx.controls.Button;
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import com.scaleform.sf2.lobby.Enchant.ListPartControl;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.Enchant.PopupPartAbstractResult extends UIComponent
{	
	public var txtSet:MovieClip;
	public var gridBg:MovieClip;
	public var bgAni:MovieClip;	
	public var bg:MovieClip;
	
	public var partA:ListPartControl;
	public var partB:ListPartControl;
	public var partC:ListPartControl;
	public var partD:ListPartControl;
	
	public var btnPartOk:Button;
	public var partResultTxtSet:MovieClip;	
	
	public var NowPartAVal:Number;
	public var NowPartBVal:Number;
	public var NowPartCVal:Number;
	public var NowPartDVal:Number;
	
	public var OriPartAMinVal:Number;
	public var OriPartBMinVal:Number;
	public var OriPartCMinVal:Number;
	public var OriPartDMinVal:Number;
	
	public var OriPartAMaxVal:Number;
	public var OriPartBMaxVal:Number;
	public var OriPartCMaxVal:Number;
	public var OriPartDMaxVal:Number;
	
	
	
    public function PopupPartAbstractResult() {         
        super();  
    }
	
	public function SetPartsResultValue(partA:Number,
										partB:Number,
										partC:Number,
										partD:Number)
	{
		NowPartAVal = partA;
		NowPartBVal = partB;
		NowPartCVal = partC;
		NowPartDVal = partD;
		
		partResultTxtSet.partATxtVal.txtVal.text = "+ "+partA;
		partResultTxtSet.partBTxtVal.txtVal.text = "+ "+partB;
		partResultTxtSet.partCTxtVal.txtVal.text = "+ "+partC;
		partResultTxtSet.partDTxtVal.txtVal.text = "+ "+partD;
	}
	
	public function OnOpenPopupAbstract() {
		this.gotoAndPlay("open");
		ExternalInterface.call("popupPartResultOpen", "");
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
		bg._visible = vis;		
		partA._visible = vis;
		partB._visible = vis;
		partC._visible = vis;
		partD._visible = vis;
		btnPartOk._visible = vis
		
		this._y = 80
	}
	
	private function onOpenEndContainer():Void
	{
		bgAni.gotoAndPlay("open");
		partResultTxtSet.gotoAndPlay("open");
		
	}
	
	private function onCloseEndContainer():Void
	{	
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible = vis;
		bg._visible = vis;
		partA._visible = vis;
		partB._visible = vis;
		partC._visible = vis;
		partD._visible = vis;
		btnPartOk._visible = vis
		
		bgAni.gotoAndPlay(1);
		partResultTxtSet.gotoAndPlay(1);
		
		partA.setData(OriPartAMinVal, OriPartAMaxVal);	
		partB.setData(OriPartBMinVal, OriPartBMaxVal);	
		partC.setData(OriPartCMinVal, OriPartCMaxVal);	
		partD.setData(OriPartDMinVal, OriPartDMaxVal);	
		
		this._y = -1000;
	}
	
	private function onOpenPartA():Void
	{	
		partA.setData(OriPartAMinVal+NowPartAVal, OriPartAMaxVal);		
	}
	private function onOpenPartB():Void
	{	
		partB.setData(OriPartBMinVal+NowPartBVal, OriPartBMaxVal);
	}
	private function onOpenPartC():Void
	{	
		partC.setData(OriPartCMinVal+NowPartCVal, OriPartCMaxVal);
	}
	private function onOpenPartD():Void
	{	
		partD.setData(OriPartDMinVal+NowPartDVal, OriPartDMaxVal);
	}
	
	private function OnBtnPartClickHandle(e:Object) {
		OnClosePopupAbstract()
		ExternalInterface.call("popupPartResultClose", "");
	}
	
    private function configUI():Void
    {
    	super.configUI();
		
		this._y = -1000;
		
		var vis:Boolean = false;
		txtSet._visible=vis;
		gridBg._visible=vis;
		bgAni._visible=vis;
		bg._visible = vis;
		partA._visible = vis;
		partB._visible = vis;
		partC._visible = vis;
		partD._visible = vis;
		btnPartOk._visible = vis
		
		txtSet.txtTitle.verticalAlign = "center";
		txtSet.txtTitle.textAutoSize = "shrink";
		txtSet.txtContext.verticalAlign = "center";
		txtSet.txtContext.textAutoSize = "shrink";		
		txtSet.txtTitle.text = "_enchant_parts_abstract_result_title";
		txtSet.txtContext.text = "_enchant_parts_abstract_result_context";
		
		partResultTxtSet.partATxtVal.txtVal.verticalAlign = "center";
		partResultTxtSet.partATxtVal.txtVal.textAutoSize = "shrink";		
		partResultTxtSet.partBTxtVal.txtVal.verticalAlign = "center";
		partResultTxtSet.partBTxtVal.txtVal.textAutoSize = "shrink";
		partResultTxtSet.partCTxtVal.txtVal.verticalAlign = "center";
		partResultTxtSet.partCTxtVal.txtVal.textAutoSize = "shrink";
		partResultTxtSet.partDTxtVal.txtVal.verticalAlign = "center";
		partResultTxtSet.partDTxtVal.txtVal.textAutoSize = "shrink";
		
		this.addEventListener("openStart", this, "onOpenStartContainer");
		this.addEventListener("openEnd", this, "onOpenEndContainer");
    	this.addEventListener("closeEnd", this, "onCloseEndContainer"); 
		
		this.addEventListener("partAin", this, "onOpenPartA");
		this.addEventListener("partBin", this, "onOpenPartB");
    	this.addEventListener("partCin", this, "onOpenPartC"); 
		this.addEventListener("partDin", this, "onOpenPartD"); 
		
		btnPartOk.label = "_ok";
		btnPartOk.addEventListener("click", this, "OnBtnPartClickHandle");
    }
}