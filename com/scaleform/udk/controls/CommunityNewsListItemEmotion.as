/**
 * ...
 * @author 
 */


import flash.external.ExternalInterface;
import gfx.controls.Button;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.controls.CommunityNewsListItemEmotion extends UIComponent
{
    public var iconJoy:Button;
    public var iconSorrow:Button;
    public var iconLove:Button;
    public var dummyJoy:Button;
    public var dummySorrow:Button;
    public var dummyLove:Button;
    public var txtJoy:TextField;
    public var txtSorrow:TextField;
    public var txtLove:TextField;
    
	private var intervalId:Number;
    
    
    public function CommunityNewsListItemEmotion()
    {         
        super();
        
        txtJoy.autoSize = true;
		txtSorrow.autoSize = true;
		txtLove.autoSize = true; 
    }  
    
	public function setData(data:Object):Void
	{
		var emoArr:Array = [];
		if (data.Joy > 0)
		{
			iconJoy.visible = true;
			dummyJoy.visible = true;
			txtJoy.text = data.Joy.toString();
			emoArr.push("Joy");
		}
		else
		{
			iconJoy.visible = false;
			dummyJoy.visible = false;
			txtJoy.text = "";
		}
		
		if (data.Sorrow > 0)
		{
			iconSorrow.visible = true;
			dummySorrow.visible = true;
			txtSorrow.text = data.Sorrow.toString();
			emoArr.push("Sorrow");
		}
		else
		{
			iconSorrow.visible = false;
			dummySorrow.visible = false;
			txtSorrow.text = "";
		}
		
		if (data.Love > 0)
		{
			iconLove.visible = true;
			dummyLove.visible = true;
			txtLove.text = data.Love.toString();
			emoArr.push("Love");
		}
		else
		{
			iconLove.visible = false;
			dummyLove.visible = false;
			txtLove.text = "";
		}
		
		
		for (var i:Number=0; i<emoArr.length; i++)
		{
			if (i==0)
			{
				this["icon"+emoArr[i]]._x = 0;
				this["dummy"+emoArr[i]]._x = 0;
			}
			else
			{
				this["icon"+emoArr[i]]._x = this["txt"+emoArr[i-1]]._x + this["txt"+emoArr[i-1]]._width + 4;
				this["dummy"+emoArr[i]]._x = this["icon"+emoArr[i]]._x;
			}
			this["txt"+emoArr[i]]._x = this["icon"+emoArr[i]]._x + this["icon"+emoArr[i]]._width - 2;
		}
	}
    
    public function setTooltip(type:Number, value:Array):Void
    {
    	var nameStr:String = "";
    	var newLine:Number = 1;
		for (var i:Number=0; i<value.length; i++)
		{
			nameStr += value[i];
			if (i > value.length-2) { break; }
			if (i/3 == newLine)
			{
				nameStr += ",<br>";
				newLine++;
			}
			else
			{
				nameStr += ",  ";
			}
		}
		
		switch (type)
    	{
    		case 0 :
    			iconJoy.tooltipMulti = nameStr;
    			dummyJoy.visible = false;
    			break;
    		
    		case 1 :
    			iconSorrow.tooltipMulti = nameStr;
    			dummySorrow.visible = false;
    			break;
    		
    		case 2 :
    			iconLove.tooltipMulti = nameStr;
    			dummyLove.visible = false;
    			break;
    	}
	}

	private function configUI():Void
    {
    	super.configUI();
    	
    	iconJoy.data = "0";
    	iconSorrow.data = "1";
    	iconLove.data = "2";
    	
    	dummyJoy.data = "0";
    	dummySorrow.data = "1";
    	dummyLove.data = "2";
    	
    	dummyJoy.addEventListener("rollOver", this, "onDummyRollOver");
    	dummySorrow.addEventListener("rollOver", this, "onDummyRollOver");
    	dummyLove.addEventListener("rollOver", this, "onDummyRollOver");
    	
    	dummyJoy.addEventListener("rollOut", this, "onDummyRollOut");
    	dummySorrow.addEventListener("rollOut", this, "onDummyRollOut");
    	dummyLove.addEventListener("rollOut", this, "onDummyRollOut");
    	
    	dummyJoy.addEventListener("releaseOutside", this, "onDummyRollOut");
    	dummySorrow.addEventListener("releaseOutside", this, "onDummyRollOut");
    	dummyLove.addEventListener("releaseOutside", this, "onDummyRollOut");
    	
    	iconJoy.addEventListener("rollOut", this, "onEmotionRollOut");
    	iconSorrow.addEventListener("rollOut", this, "onEmotionRollOut");
    	iconLove.addEventListener("rollOut", this, "onEmotionRollOut");
    	
    	iconJoy.addEventListener("releaseOutside", this, "onEmotionRollOut");
    	iconSorrow.addEventListener("releaseOutside", this, "onEmotionRollOut");
    	iconLove.addEventListener("releaseOutside", this, "onEmotionRollOut");
    }
    
    private function onDummyRollOver(e:Object):Void
    {
    	intervalId = setInterval(this, "callEmotionRollOver", 300, [e.target]);
    }
    
    private function onDummyRollOut(e:Object):Void
    {
    	clearInterval(intervalId);
    }
    
    private function callEmotionRollOver(param:Array):Void
    {
		clearInterval(intervalId);
    	ExternalInterface.call("community_OnEmotionRollOver", _parent.index, Number(param[0].data));
    }
    
    
    private function onEmotionRollOut(e:Object):Void
    {
    	e.target.tooltipMulti = "";
    	switch (Number(e.target.data))
    	{
    		case 0 :
    			dummyJoy.visible = true;
    			break;
    		
    		case 1 :
    			dummySorrow.visible = true;
    			break;
    		
    		case 2 :
    			dummyLove.visible = true;
    			break;
    	}
    }
    
}