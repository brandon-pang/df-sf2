import com.scaleform.ObjectScrollingList;

/**
 * @author noww
 */
[InspectableList("disabled", "visible", "inspectableScrollBar", "inspectableScrollBarHor", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "enableInitCallback", "soundMap")]
class com.scaleform.ObjectScrollingListEx extends ObjectScrollingList 
{	
	
	public function ObjectScrollingListEx() 
	{
		super();
	}

	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void 
	{
		value = Math.max(-paddingTop, Math.min((contents.targetHeight + paddingBottom) - mask._height, Math.round(value)));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		invalidatePosition();
		updateScrollBar();
	}
	
	public function get scrollPositionHor():Number { return _scrollPositionHor; }
	public function set scrollPositionHor(value:Number):Void 
	{
		value = Math.max(-paddingLeft, Math.min((contents.targetWidth + paddingRight) - mask._width, Math.round(value)));
		if (_scrollPositionHor == value) { return; }
		_scrollPositionHor = value;
		invalidatePositionHor();
		updateScrollBarHor();
	}
	
	public function toString():String 
	{
		return "[Scaleform ObjectScrollingListEx " + _name + "]";
	}
	
	private function configUI():Void 
	{
		super.configUI();
	}
	
	private function onPosChangeContents(e:Object):Void
	{
		var yPos:Number = e.yDist;
		_scrollPosition = Math.max(-paddingTop, Math.min((contents.targetHeight + paddingBottom) - mask._height, Math.round(_scrollPosition - yPos)));
		scrollToPosition();
		updateScrollBar();
	}
	
	private function onPosChangeContentsHor(e:Object):Void
	{
		var xPos:Number = e.xDist;
		_scrollPositionHor = Math.max(-paddingLeft, Math.min((contents.targetWidth + paddingRight) - mask._width, Math.round(_scrollPositionHor - xPos)));
		scrollToPositionHor();
		updateScrollBarHor();
	}
	
	public function invalidatePosition():Void 
	{
		_scrollPosition = Math.min(Math.max(-paddingTop, (contents.targetHeight + paddingBottom) - mask._height), _scrollPosition);
		scrollToPosition();
	}
	
	public function invalidatePositionHor():Void 
	{
		_scrollPositionHor = Math.min(Math.max(-paddingLeft, (contents.targetWidth + paddingRight) - mask._width), _scrollPositionHor);
		scrollToPositionHor();
	}
	
	private function updateScrollBar():Void 
	{		
		var max:Number = Math.max(-paddingTop, Math.floor((contents.targetHeight + paddingBottom) - mask._height));
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.setScrollProperties(mask._height*thumbSizeFactor, -paddingTop, max);
		} else {
			_scrollBar.minimum = -paddingTop;
			_scrollBar.maximum = max;
		}
		_scrollBar.position = _scrollPosition;
		_scrollBar.trackScrollPageSize = Math.max(1, mask._height);
	}
	
	private function updateScrollBarHor():Void 
	{		
		var max:Number = Math.max(-paddingLeft, Math.floor((contents.targetWidth + paddingRight) - mask._width));
		if (_scrollBarHor.setScrollProperties != null) {
			_scrollBarHor.setScrollProperties(mask._width*thumbSizeFactor, -paddingLeft, max);
		} else {
			_scrollBarHor.minimum = -paddingLeft;
			_scrollBarHor.maximum = max;
		}
		_scrollBarHor.position = _scrollPositionHor;
		_scrollBarHor.trackScrollPageSize = Math.max(1, mask._width);
	}
}
