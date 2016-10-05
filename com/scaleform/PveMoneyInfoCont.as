/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.PveMoneyInfoCont extends UIComponent
{
	public var textField:TextField;
	public var txtSymbol:TextField;
	private var curMoney:Number = 0;
	private var targetMoney:Number = 0;
	private var intervalId:Number;
	private var positiveNum:Number;
	private var unitNum:Number;
	private var isChanging:Boolean = false;
	
    public function PveMoneyInfoCont()
    {         
        super();  
    }
	
	public function initCont():Void
	{
		textField.text = "";
		curMoney = 0;
		isChanging = false;
		targetMoney = 0;
		clearInterval(intervalId);
	}
	
	public function setMoney(value:Number):Void
	{
		if (value != null) { curMoney = value; }
		setMoneyTxt();
	}
	
	public function changeMoney(value:Number):Void
	{
		if (value == null || value == 0) { return; }
		if (isChanging)
		{
			clearInterval(intervalId);
			curMoney = targetMoney;
			setMoneyTxt();
		}
		targetMoney = curMoney + value;
		unitNum = Math.ceil(Math.abs(value)/12);
		positiveNum = (value > 0)?1:-1;
		
		makeInterval();
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		textField.noTranslate = true;
		textField.verticalAlign = "center";
		txtSymbol.verticalAlign = "center";
	}
	
	private function setMoneyTxt():Void
	{
		if (curMoney >= 0)
		{
			textField.text = Tool.comma(curMoney);
		}
		else 
		{
			var comma:String = Tool.comma(Math.abs(curMoney));
			textField.text = "-"+comma;
		}
	}
	
	private function makeInterval():Void
	{
		isChanging = true;
		intervalId = setInterval(this, "makeIntervalCallBack", 50, targetMoney);
	}
	
	private function makeIntervalCallBack(target:Number):Void
	{
		var unit:Number = positiveNum * unitNum;
		curMoney = curMoney + unit;
		if (positiveNum == 1) { curMoney = Math.min(curMoney, target); }
		else if (positiveNum == -1) { curMoney = Math.max(curMoney, target); }
		setMoneyTxt();
		if (curMoney == target)
		{
			isChanging = false;
			clearInterval(intervalId);
		}
	}
	
	
	
}