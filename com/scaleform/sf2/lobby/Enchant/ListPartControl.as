
import gfx.utils.Delegate;
import gfx.core.UIComponent;


class com.scaleform.sf2.lobby.Enchant.ListPartControl extends UIComponent
{
    public var txtCount:TextField;
	public var maskMc:MovieClip;
	public var lineMc:MovieClip;
	public var partShape:MovieClip;
	
	public function ListPartControl() {         
        super(); 
		maskMc._width = 0
		lineMc._width = 0
    }    
	public function setData(valueMin:Number, valueMax:Number)
	{
		var vMin:String = String(valueMin);
		var vMax:String = String(valueMax);
		txtCount.htmlText = "<font size='16' color='#ffffcc'>"+vMin+"</font> <font size='13' color='#ffffff'> / "+vMax+"</font>";
		drawPart(valueMin, valueMax);
	}
	public function drawPart(min:Number, max:Number) {
		var div = ((min / max) * 186);
		var div2 = ((min / max) * 83);
		var per = Math.floor((min / max) * 100);
		
		maskMc._width = div;
		lineMc._width = div2;
		
		if (per < 41) {partShape.gotoAndStop(1);}
		if (per >= 41 && per <= 70) {partShape.gotoAndStop(2);}
		if (per >= 71 && per <= 100) {partShape.gotoAndStop(3);}
		
	}
    private function configUI():Void
    {
    	super.configUI();
		
		txtCount.verticalAlign = "bottom";
		txtCount.noTranlate = true;
	
    }
}