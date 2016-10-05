/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.SniperEnemyIndicate extends Panel
{
	public var indicateCont:MovieClip;
	
    public function SniperEnemyIndicate()
    {         
        super();  
    }
	
	public function show(value:Number):Void
	{
		if (value == null) { return; }
		initBody();
		switch (value)
		{
			case 0:
				indicateCont.head._visible = true;
				break;
			
			case 1:
				indicateCont.chest._visible = true;
				break;
				
			case 2:
				indicateCont.arm._visible = true;
				break;
			
			case 3:
				indicateCont.stomach._visible = true;
				break;
			
			case 4:
				indicateCont.leg._visible = true;
				break;
				
			default :
				return;
		}
		
		gotoAndPlay("show");
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		initBody();
	}
	
	private function initBody():Void
	{
		indicateCont.head._visible = false;
		indicateCont.chest._visible = false;
		indicateCont.arm._visible = false;
		indicateCont.stomach._visible = false;
		indicateCont.leg._visible = false;
	}
}