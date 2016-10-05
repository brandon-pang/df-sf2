/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.*; 
import com.greensock.TweenMax;
import gfx.controls.UILoader;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.HeroResultComboListItem extends ListItemRenderer
{
	public var division:MovieClip;
	
	
	public function HeroResultComboListItem()
	{
		super();
		
		division._visible = false;
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
			visible = true;
			
			division._visible = (data.label == "" || data.label == null);
		}
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	
	private function handleMouseRollOver(controllerIdx:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleMouseRollOver(controllerIdx);
	}
	
	private function handleMouseRollOut(controllerIdx:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleMouseRollOut(controllerIdx);
	}
	
	private function handleMousePress(controllerIdx:Number, keyboardOrMouse:Number, button:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleMousePress(controllerIdx, keyboardOrMouse, button);
	}
	
	private function handleMouseRelease(controllerIdx:Number, keyboardOrMouse:Number, button:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleMouseRelease(controllerIdx, keyboardOrMouse, button);
	}
	
	private function handleDragOver(controllerIdx:Number, button:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleDragOver(controllerIdx, button);
	}
	
	private function handleDragOut(controllerIdx:Number, button:Number):Void
	{
		if (data.label == "" || data.label == null) { return; }
		super.handleDragOut(controllerIdx, button);
	}	
	
	private function handleReleaseOutside(controllerIdx:Number, button:Number):Void
	{	
		if (data.label == "" || data.label == null) { return; }
		super.handleReleaseOutside(controllerIdx, button);
	}
	
	
	
	
}