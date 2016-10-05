import flash.geom.Rectangle;
import com.scaleform.Tooltip;

/**
 * @author noww
 */
[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.MultiRowTooltip extends Tooltip
{
	public var textField:TextField;
	public var bg:MovieClip;
	
	public function MultiRowTooltip()
	{
		super();
		textField.html = true;
		textField.autoSize = true;
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function populateUI():Void
	{
		textField.htmlText = message;
		
		bg._width = Math.round(textField.textWidth) + 34;
		bg._height = Math.round(textField.textHeight) + 24;
		
		transformPos();
	}
	
	private function setPosition(e:Object):Void
	{
		transformPos();
	}
	
	private function transformPos():Void
	{
		var origRect:Rectangle = Stage.originalRect;
		var visibleRect:Rectangle = Stage.visibleRect;
		
		var offsetX:Number = 8;
		var offsetY:Number = 20;
		
		if (visibleRect.width + visibleRect.x - offsetX  < _root._xmouse + bg._width)
		{
			offsetX = 20 - bg._width;
		}
		
		if (visibleRect.height + visibleRect.y - offsetY < _root._ymouse + bg._height)
		{
			offsetY = 2 - bg._height;
		}
		
		var point:Object = {x:_root._xmouse, y:_root._ymouse};
		owner._parent.globalToLocal(point);
		
		this._x = point.x + offsetX;
		this._y = point.y + offsetY;
		
	}
}
