import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.Enchant.OriGaugeCont;
import com.scaleform.sf2.lobby.Enchant.DiffGaugeCont;

class com.scaleform.sf2.lobby.Enchant.GraphCont extends UIComponent
{	
	public var txtDmg:TextField;
	public var txtRec:TextField;
	public var txtShoot:TextField;
	public var txtAcc:TextField;
	public var txtMag:TextField;
	
	public var txtVal1:TextField;
	public var txtVal2:TextField;
	public var txtVal3:TextField;
	public var txtVal4:TextField;
	
	public var txtDiffVal1:TextField;
	public var txtDiffVal2:TextField;
	public var txtDiffVal3:TextField;
	public var txtDiffVal4:TextField;
	
	public var txtMagVal:TextField;
	
	public var oriGauge1:OriGaugeCont;
	public var oriGauge2:OriGaugeCont;
	public var oriGauge3:OriGaugeCont;
	public var oriGauge4:OriGaugeCont;
	
	public var diffGauge1:DiffGaugeCont;
	public var diffGauge2:DiffGaugeCont;
	public var diffGauge3:DiffGaugeCont;
	public var diffGauge4:DiffGaugeCont;
	
	public function GraphCont() {         
        super(); 		
    } 	
	public function setGraphValue(upMinVal1:Number,upMaxVal1:Number,
								  upMinVal2:Number,upMaxVal2:Number,
								  upMinVal3:Number,upMaxVal3:Number,
								  upMinVal4:Number,upMaxVal4:Number,								  
							      difMinVal1:Number,difMaxVal1:Number,
								  difMinVal2:Number,difMaxVal2:Number,
								  difMinVal3:Number,difMaxVal3:Number,
								  difMinVal4:Number, difMaxVal4:Number,
								  magazineMinVal:Number,magzineMaxVal:Number) 
	{
									  
		var max:Number = 0;
		var valName:Number = 0;
		var uivArr:Array = [];
		var uxvArr:Array = [];
		var divArr:Array = [];
		var dxvArr:Array = [];
		
		var uiv1:Number = upMinVal1;
		var uiv2:Number = upMinVal2;
		var uiv3:Number = upMinVal3;
		var uiv4:Number = upMinVal4;
		
		var div1:Number = difMinVal1;
		var div2:Number = difMinVal2;
		var div3:Number = difMinVal3;
		var div4:Number = difMinVal3;
		
		var uxv1:Number = upMaxVal1;
		var uxv2:Number = upMaxVal2;
		var uxv3:Number = upMaxVal3;
		var uxv4:Number = upMaxVal4;
		
		var dxv1:Number = difMaxVal1;
		var dxv2:Number = difMaxVal2;
		var dxv3:Number = difMaxVal3;
		var dxv4:Number = difMaxVal3;
		
		var magMin:Number = magazineMinVal;
		var magMax:Number = magzineMaxVal;
		
		var colorNo:Number;
		
		uivArr = [null, uiv1, uiv2, uiv3, uiv4];
		uxvArr = [null, uxv1, uxv2, uxv3, uxv4];
		divArr = [null, div1, div2, div3, div4];
		dxvArr = [null, dxv1, dxv2, dxv3, dxv4];
		
		for (var i = 1; i < 5; i++) {
			trace (uivArr[i]);
			if (uivArr[i] > max) {
				max = uivArr[i]
				colorNo = i				
			}			
		}	
		
		for (var i = 1; i < 5; i++) {
			if (colorNo == i) {
				this["oriGauge" + i].setValue(1, uivArr[i], uxvArr[i])	
				this["txtVal" + i].htmlText = "<font color ='#ffcc00'>" + uivArr[i] + "</font>";
			}else {
				this["oriGauge" + i].setValue(0, uivArr[i], uxvArr[i])	
				this["txtVal" + i].htmlText = "<font color ='#C0C0C0'>" + uivArr[i] + "</font>";
			}
			this["diffGauge" + i].setDiffValue(divArr[i], dxvArr[i]);	
			this["txtDiffVal" + i].text =divArr[i]
		}
		
		txtMagVal.text = String(magMin) + " / " + String(magMax);		
	}

    private function configUI():Void
    {
    	super.configUI();
		
		var textFieldArr = ["txtDmg", "txtRec", "txtShoot", "txtAcc","txtMag", "txtVal1",
							"txtVal2", "txtVal3", "txtDiffVal1", "txtDiffVal2",
							"txtDiffVal3", "txtDiffVal4", "txtMagVal"];
							
		for (var i = 0; i < textFieldArr.length; i++) {
			this[textFieldArr[i]].textAutoSize = "shrink";
			this[textFieldArr[i]].verticalAlig = "center";
		}
		
		txtDmg.text   = "_enchant_graph_demege";
		txtRec.text   = "_enchant_graph_recoil";
		txtShoot.text = "_enchant_graph_shoot";
		txtAcc.text   = "_enchant_graph_accuracy";
		txtMag.text   = "_enchant_graph_magazine";
    }
}