/**
 * ...
 * @author 
 */

import flash.geom.Rectangle;
import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.warrior.WarriorModeHelp extends Panel
{
	
	public var helpBtn:MovieClip;
	public var helpWnd:MovieClip;
	
	private var firstOpen:Boolean = false;
	private var opened:Boolean = false;
	
    public function WarriorModeHelp()
    {         
        super();
        
        helpBtn.shortcut.textField.noTranslate = true;
        helpWnd.cartoon1.contents.noTranslate = true;
        helpWnd.cartoon2.contents.noTranslate = true;
        helpWnd.cartoon3.contents.noTranslate = true;
        helpWnd.cartoon4.contents.noTranslate = true;
        
        helpBtn.textField.autoSize = true;
        helpBtn.textField.text = "_help_title";
		helpBtn.shortcut._x = helpBtn.textField._x +  helpBtn.textField._width;
        helpBtn.bg._width = helpBtn.shortcut._x + helpBtn.shortcut._width;
        
        helpWnd.cartoon1.subject.text = "_help_combat";
        helpWnd.cartoon2.subject.text = "_help_reward";
        helpWnd.cartoon3.subject.text = "_help_growup";
        helpWnd.cartoon4.subject.text = "_help_victory";
    }
	
	public function show(explain1:String, explain2:String, explain3:String, explain4:String):Void
	{
		if (opened) { return; }
		opened = true;
		helpWnd.cartoon1.contents.htmlText = explain1;
		helpWnd.cartoon2.contents.htmlText = explain2;
		helpWnd.cartoon3.contents.htmlText = explain3;
		helpWnd.cartoon4.contents.htmlText = explain4;
		gotoAndPlay("show");
		helpBtn.shortcut.gotoAndPlay("show");
	}
	
	public function setShortcut(shortcut:String):Void
	{
		helpBtn.shortcut.textField.text = shortcut;
	}
	
	public function hide():Void
	{
		if (!opened) { return; }
		opened = false;
		gotoAndPlay("hide");
		helpBtn.shortcut.gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		this.addEventListener("openEnd", this, "onOpenEnd");
	}
	
	private function onOpenEnd():Void
	{
		if (firstOpen) { helpWnd.gotoAndStop("end"); }
		else { helpWnd.gotoAndPlay("show"); firstOpen = true; }
	}
	
}