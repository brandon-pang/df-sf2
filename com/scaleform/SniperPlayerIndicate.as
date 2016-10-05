/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.Tool;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.SniperPlayerIndicate extends Panel
{
	public var indicateCont:MovieClip;
	
	private var _bodyNum:Number;
	
	private var AIM_POINT_HEAD:Array = [{x:92, y:38}, {x:102, y:43}, {x:93, y:55}, {x:100, y:58}, {x:96, y:48}];
	private var AIM_POINT_CHEST:Array = [{x:73, y:96}, {x:96, y:98}, {x:115, y:95}, {x:76, y:130}, {x:97, y:132}, {x:116, y:130}, {x:94, y:115}];
	private var AIM_POINT_STOMACH:Array = [{x:74, y:171}, {x:94, y:171}, {x:114, y:171}];
	
	
    public function SniperPlayerIndicate()
    {         
        super();  
    }
	
	public function show(value:Number):Void
	{
		if (value == null) { return; }
		initBody();
		_bodyNum = value;
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
		
		this.addEventListener("openEnd", this, "onOpenEnd");
		
		initBody();
	}
	
	private function onOpenEnd(e:Object):Void
	{
		switch (_bodyNum)
		{
			case 0:
				indicateCont.aim._x = AIM_POINT_HEAD[Tool.randRange(0, AIM_POINT_HEAD.length-1)].x;
				indicateCont.aim._y = AIM_POINT_HEAD[Tool.randRange(0, AIM_POINT_HEAD.length-1)].y;
				indicateCont.aim.gotoAndPlay("show");
				indicateCont.blood.gotoAndPlay("show");
				break;
			
			case 1:
				indicateCont.aim._x = AIM_POINT_CHEST[Tool.randRange(0, AIM_POINT_CHEST.length-1)].x;
				indicateCont.aim._y = AIM_POINT_CHEST[Tool.randRange(0, AIM_POINT_CHEST.length-1)].y;
				indicateCont.aim.gotoAndPlay("show");
				indicateCont.blood.gotoAndPlay("show");
				break;
				
			case 2:
				indicateCont.blood.gotoAndPlay("show");
				break;
			
			case 3:
				indicateCont.aim._x = AIM_POINT_STOMACH[Tool.randRange(0, AIM_POINT_STOMACH.length-1)].x;
				indicateCont.aim._y = AIM_POINT_STOMACH[Tool.randRange(0, AIM_POINT_STOMACH.length-1)].y;
				indicateCont.aim.gotoAndPlay("show");
				indicateCont.blood.gotoAndPlay("show");
				break;
			
			case 4:
				indicateCont.blood.gotoAndPlay("show");
				break;
				
			default :
				break;
		}
	}
	
	private function initBody():Void
	{
		indicateCont.blood.gotoAndStop(1);
		indicateCont.aim.gotoAndStop(2);
		indicateCont.head._visible = false;
		indicateCont.chest._visible = false;
		indicateCont.arm._visible = false;
		indicateCont.stomach._visible = false;
		indicateCont.leg._visible = false;
	}
}