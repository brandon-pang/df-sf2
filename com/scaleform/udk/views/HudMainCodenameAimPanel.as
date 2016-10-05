/**
 * ...
 * @author 
 */

import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.udk.views.HudMainCodenameAimPanel extends Panel
{
	public var codenameAimCont:MovieClip;
	
    public function HudMainCodenameAimPanel()
    {         
        super();
        
    }
	
	public function showCodenameAim(codename:String):Void
	{
		if (codename == null || codename == "") { return; }
		codenameAimCont.codename.text = codename;
		codenameAimCont.codenameBg.text = codename;
		gotoAndPlay("show");
	}
	
	public function hideCodenameAim():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{		
		super.configUI();
		
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onCloseEnd():Void
	{
		codenameAimCont.codename.text = "";
		codenameAimCont.codenameBg.text = "";
	}
	
	
	
}