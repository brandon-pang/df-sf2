/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeTotalPoint extends UIComponent
{
	
	public var titleTxt:TextField;
	public var pointTxt:TextField;
	public var bg:MovieClip;
	
    public function MyInfoChallengeTotalPoint()
    {         
        super();  
    }
	
	public function challenge_ShowTotalPoint(str:String):Void
    {
    	visible = true;
		if (str != null) { pointTxt.text = str; }
		else { pointTxt.text = ""; }
    }
    
    public function challenge_HideTotalPoint():Void
    {
    	visible = false;
		pointTxt.text = "";
    }
	
	private function configUI():Void
	{
		super.configUI();
		visible = false;
		titleTxt.autoSize = "right";
		titleTxt.text = "_challenge_total_point";
		if (_root.designMode) { titleTxt.text = "총 포인트 :"; }
		bg._width = titleTxt._width + pointTxt._width + 10;
		bg._x = 0 - titleTxt._width - 4;
		
		if (_root.designMode)
		{
			challenge_ShowTotalPoint("99");
		}
	}

	
	
	
}