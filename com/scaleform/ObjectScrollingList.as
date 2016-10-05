import gfx.core.UIComponent;
import gfx.managers.DragManager;
import gfx.utils.Delegate;
import gfx.utils.Constraints;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import flash.geom.Rectangle;

/**
 * @author noww
 */
[InspectableList("disabled", "visible", "inspectableScrollBar", "inspectableScrollBarHor", "margin", "paddingTop", "paddingBottom", "paddingLeft", "paddingRight", "thumbOffsetBottom", "thumbOffsetTop", "thumbSizeFactor", "enableInitCallback", "soundMap")]
class com.scaleform.ObjectScrollingList extends UIComponent 
{	
	public var mask:MovieClip;
	public var contents:MovieClip;
	
	private var _scrollBar:MovieClip;
	private var _scrollBarHor:MovieClip;
	private var container:MovieClip;
	
	private var _scrollPosition:Number = 0;
	private var _scrollPositionHor:Number = 0;
	
	[Inspectable(name="scrollBar", type="String")]
	private var inspectableScrollBar:Object;
	private var autoScrollBar:Boolean = false;
	
	[Inspectable(name="scrollBarHor", type="String")]
	private var inspectableScrollBarHor:Object;
	private var autoScrollBarHor:Boolean = false;
	
	[Inspectable(defaultValue="1", verbose=1)]
	private var margin:Number = 1;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingBottom:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingLeft:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var paddingRight:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetTop:Number = 0;
	[Inspectable(defaultValue="0", verbose=1)]
	private var thumbOffsetBottom:Number = 0;
	[Inspectable(defaultValue="1.0", verbose=1)]
	private var thumbSizeFactor:Number = 1.0;
	[Inspectable(defaultValue="10", verbose=1)]
	private var scrollingUnit:Number = 34;
	
	private var constraints:Constraints;
	
	private var scrollDisabled:Boolean = false;
	
	public function ObjectScrollingList() 
	{
		super();
		if (container == undefined) { 
			container = createEmptyMovieClip("container", 1); 
		}
		container.scale9Grid = new Rectangle(0,0,1,1);
		tabEnabled = focusEnabled = true;
	}
	
	public function get scrollBar():Object { return _scrollBar; }
	public function set scrollBar(value:Object):Void 
	{	
		if (!initialized) { 
			inspectableScrollBar = value;
			return;
		}
		
		if (_scrollBar != null) {
			_scrollBar.removeEventListener("scroll", this, "handleScroll");
			_scrollBar.removeEventListener("change", this, "handleScroll");
			_scrollBar.focusTarget = null;
			if (autoScrollBar) { _scrollBar.removeMovieClip(); } // Clean up auto-created scrollbars only!
		}
		
		autoScrollBar = false; // Reset
		if (typeof(value) == "string") {
			_scrollBar = MovieClip(_parent[value.toString()]); // Outside reference by name
			if (_scrollBar == null) {
				_scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000, {offsetTop:thumbOffsetTop, offsetBottom:thumbOffsetBottom}); // Created using linkage
				if (_scrollBar != null) { 
					autoScrollBar = true;
					//if (_scrollBar.scale9Grid == null) { _scrollBar.scale9Grid = new Rectangle(0,16,1,1); }
				}
			}
		} else { // Outside reference
			_scrollBar = MovieClip(value);
		}
		
		invalidate(); // Redraw to reset scrollbar bounds, even if there is no scrollBar.
		
		if (_scrollBar == null) { return; }
		
		// Now that we have a scrollBar, lets set it up.
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.addEventListener("scroll", this, "handleScroll");
		} else {
			_scrollBar.addEventListener("change", this, "handleScroll");
		}
		_scrollBar.pageScrollSize = scrollingUnit;
		_scrollBar.focusTarget = this;
		_scrollBar.tabEnabled = false;
		updateScrollBar();
	}
	
	public function get scrollBarHor():Object { return _scrollBarHor; }
	public function set scrollBarHor(value:Object):Void 
	{	
		if (!initialized) { 
			inspectableScrollBarHor = value;
			return;
		}
		
		if (_scrollBarHor != null) {
			_scrollBarHor.removeEventListener("scroll", this, "handleScroll");
			_scrollBarHor.removeEventListener("change", this, "handleScroll");
			_scrollBarHor.focusTarget = null;
			if (autoScrollBarHor) { _scrollBarHor.removeMovieClip(); } // Clean up auto-created scrollbars only!
		}
		
		autoScrollBarHor = false; // Reset
		if (typeof(value) == "string") {
			_scrollBarHor = MovieClip(_parent[value.toString()]); // Outside reference by name
			if (_scrollBarHor == null) {
				_scrollBarHor = container.attachMovie(value.toString(), "_scrollBarHor", 1000, {offsetTop:thumbOffsetTop, offsetBottom:thumbOffsetBottom}); // Created using linkage
				if (_scrollBarHor != null) { 
					autoScrollBarHor = true;
					//if (_scrollBar.scale9Grid == null) { _scrollBar.scale9Grid = new Rectangle(0,16,1,1); }
				}
			}
		} else { // Outside reference
			_scrollBarHor = MovieClip(value);
		}
		
		invalidate(); // Redraw to reset scrollbar bounds, even if there is no scrollBar.
		
		if (_scrollBarHor == null) { return; }
		
		// Now that we have a scrollBar, lets set it up.
		if (_scrollBarHor.setScrollProperties != null) {
			_scrollBarHor.addEventListener("scroll", this, "handleScrollHor");
		} else {
			_scrollBarHor.addEventListener("change", this, "handleScrollHor");
		}
		_scrollBarHor.pageScrollSize = scrollingUnit;
		_scrollBarHor.focusTarget = this;
		_scrollBarHor.tabEnabled = false;
		updateScrollBar();
	}
	
	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void 
	{
		value = Math.max(-paddingTop, Math.min((contents._height + paddingBottom) - mask._height, Math.round(value)));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		invalidatePosition();
		updateScrollBar();
	}
	
	public function get scrollPositionHor():Number { return _scrollPositionHor; }
	public function set scrollPositionHor(value:Number):Void 
	{
		value = Math.max(-paddingLeft, Math.min((contents._width + paddingRight) - mask._width, Math.round(value)));
		if (_scrollPositionHor == value) { return; }
		_scrollPositionHor = value;
		invalidatePositionHor();
		updateScrollBarHor();
	}
	
	public function toString():String 
	{
		return "[Scaleform ObjectScrollingList " + _name + "]";
	}
	
	private function configUI():Void 
	{
		super.configUI();
		
		//Mouse.addListener(this);
		
		constraints = new Constraints(this);
		constraints.addElement(mask, Constraints.ALL);
		
		_scrollPosition  = -paddingTop;
		_scrollPositionHor  = -paddingLeft;
		
		if (inspectableScrollBar != '' && inspectableScrollBar != null) {
			scrollBar = inspectableScrollBar;
			inspectableScrollBar = null;
		}
		
		if (inspectableScrollBarHor != '' && inspectableScrollBarHor != null) {
			scrollBarHor = inspectableScrollBarHor;
			inspectableScrollBarHor = null;
		}
		
		contents.addEventListener("resizeContents", this, "onResizeContents");
		contents.addEventListener("resizeContentsHor", this, "onResizeContentsHor");
		
		contents.addEventListener("posChangeContents", this, "onPosChangeContents");
		contents.addEventListener("posChangeContentsHor", this, "onPosChangeContentsHor");
		
	}
	
	private function draw():Void 
	{
		super.draw();
		constraints.update(__width, __height);
		onResizeContents();
		onResizeContentsHor();
	}
	
	private function onResizeContents():Void
	{
		invalidatePosition();
		updateScrollBar();
	}
	
	private function onResizeContentsHor():Void
	{
		invalidatePositionHor();
		updateScrollBarHor();
	}
	
	private function onPosChangeContents(e:Object):Void
	{
		var yPos:Number = e.yDist;
		_scrollPosition = Math.max(-paddingTop, Math.min((contents._height + paddingBottom) - mask._height, Math.round(_scrollPosition - yPos)));
		scrollToPosition();
		updateScrollBar();
	}
	
	private function onPosChangeContentsHor(e:Object):Void
	{
		var xPos:Number = e.xDist;
		_scrollPositionHor = Math.max(-paddingLeft, Math.min((contents._width + paddingRight) - mask._width, Math.round(_scrollPositionHor - xPos)));
		scrollToPositionHor();
		updateScrollBarHor();
	}
	
	public function invalidatePosition():Void 
	{
		_scrollPosition = Math.min(Math.max(-paddingTop, (contents._height + paddingBottom) - mask._height), _scrollPosition);
		scrollToPosition();
	}
	
	public function invalidatePositionHor():Void 
	{
		_scrollPositionHor = Math.min(Math.max(-paddingLeft, (contents._width + paddingRight) - mask._width), _scrollPositionHor);
		scrollToPositionHor();
	}
	
	private function scrollToPosition():Void
	{
		//contents._y = -_scrollPosition;
		TweenMax.to(contents, 0.5, {_y:-_scrollPosition, ease:Cubic.easeOut});
	}
	
	private function scrollToPositionHor():Void
	{
		//contents._x = -_scrollPositionHor;
		TweenMax.to(contents, 0.5, {_x:-_scrollPositionHor, ease:Cubic.easeOut});
	}
	
	private function updateScrollBar():Void 
	{		
		var max:Number = Math.max(-paddingTop, Math.floor((contents._height + paddingBottom) - mask._height));
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
		var max:Number = Math.max(-paddingLeft, Math.floor((contents._width + paddingRight) - mask._width));
		if (_scrollBarHor.setScrollProperties != null) {
			_scrollBarHor.setScrollProperties(mask._width*thumbSizeFactor, -paddingLeft, max);
		} else {
			_scrollBarHor.minimum = -paddingLeft;
			_scrollBarHor.maximum = max;
		}
		_scrollBarHor.position = _scrollPositionHor;
		_scrollBarHor.trackScrollPageSize = Math.max(1, mask._width);
	}
	
	private function handleScroll(event:Object):Void 
	{
		var newPosition:Number = event.target.position;
		if (isNaN(newPosition)) { return; }
		scrollPosition = newPosition;
	}
	
	private function handleScrollHor(event:Object):Void 
	{
		var newPosition:Number = event.target.position;
		if (isNaN(newPosition)) { return; }
		scrollPositionHor = newPosition;
	}
	
	private function scrollWheel(delta:Number):Void 
	{
		if (_disabled || scrollDisabled) { return; }
		scrollPosition = _scrollPosition - (delta * scrollingUnit);
	}
}
