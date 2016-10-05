/**
 * ...
 * @author 
 */

import gfx.utils.Constraints;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.MyInfoChallengeAchieveIconExplainMedal extends UIComponent
{
	public var textField:TextField;
	public var lightMC:MovieClip;
	public var bg:MovieClip;
	
	private var constraints:Constraints;
	
    public function MyInfoChallengeAchieveIconExplainMedal()
    {         
        super();  
    }

	private function configUI():Void
	{		
		constraints = new Constraints(this, true);
		constraints.addElement(bg, Constraints.ALL);
		super.configUI();
	}
	
	private function draw():Void
	{
		super.draw();
        if (initialized) {        
		    constraints.update(__width, __height);
        } 
	}
}