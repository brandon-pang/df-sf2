/**
 * ...
 * @author 
 */

import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "enableInitCallback", "autoSize", "soundMap")]
class com.scaleform.udk.controls.EventDialogListItemSubBtn extends Button
{
	public var titleTxt:TextField;
	public var arrow:MovieClip;
	public var bg:MovieClip;
	public var back:MovieClip;
	
	public var index:Number;
	public var opened:Boolean = false;
	
	public function EventDialogListItemSubBtn()
	{
		super();
		
		titleTxt.verticalAlign = "center";
		titleTxt.textAutoSize = "shrink";
		titleTxt.noTranslate = true;
		
		arrow._visible = false;
		arrow.hitTestDisable = true;
	}
	
	[Inspectable(defaultValue="false")]
	public function get selected():Boolean { return _selected; }
	public function set selected(value:Boolean):Void
	{        
		super.selected = value;
		arrow._visible = value;
	}
	
	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			visible = false;
		}
		else
		{
			this.data = data;
			titleTxt.text = data.title;
			visible = true;
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
		enableInitCallback = false;
		if (data) { setData(data); }
	}
}