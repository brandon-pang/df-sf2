import flash.external.ExternalInterface;
import gfx.utils.Delegate;
import gfx.events.EventDispatcher;

/**
 * @author noww
 */
 
class com.scaleform.udk.utils.SFMouseEvent
{
	private static var _instance:SFMouseEvent = null;
	
	private var mouseListener:Object;
	
	// EventDispatcher mix-in
	/** Mixed in from {@link EventDispatcher#addEventListener EventDispatcher} */
	public var addEventListener:Function;	
	/** Mixed in from {@link EventDispatcher#removeEventListener EventDispatcher} */ 
	public var removeEventListener:Function;
	/** Mixed in from {@link EventDispatcher#hasEventListener EventDispatcher} */
	public var hasEventListener:Function;
	/** Mixed in from {@link EventDispatcher#removeAllEventListeners EventDispatcher} */
	public var removeAllEventListeners:Function;	
	/** Mixed in from {@link EventDispatcher#cleanUpEvents EventDispatcher} */
	private var cleanUpEvents:Function;
	/** Mixed in from {@link EventDispatcher#dispatchEvent EventDispatcher} */
	private var dispatchEvent:Function;
	
	public function SFMouseEvent()
	{
		super();
		EventDispatcher.initialize(this);
		
		mouseListener= new Object();
		mouseListener.onMouseDown = Delegate.create(this, onMouseDownListener);
		mouseListener.onMouseUp = Delegate.create(this, onMouseUpListener);
		mouseListener.onMouseMove = Delegate.create(this, onMouseMoveListener);
		mouseListener.onMouseWheel = Delegate.create(this, onMouseWheelListener);
		
		Mouse.addListener(mouseListener);
	}
	
	// 인스턴스 생성
	public static function get instance():SFMouseEvent
	{
		if(SFMouseEvent._instance == null){
			SFMouseEvent._instance = new SFMouseEvent();
		}
		return SFMouseEvent._instance;
	}
	
	private function onMouseDownListener(button:Number, targetPath:String, mouseIdx:Number, x:Number, y:Number):Void
	{
		dispatchEvent({type:"mouseDown", button:button, targetPath:targetPath});
	}
	
	private function onMouseUpListener(button:Number, targetPath:String, mouseIdx:Number, x:Number, y:Number):Void
	{
		dispatchEvent({type:"mouseUp", button:button, targetPath:targetPath});
	}
	
	private function onMouseMoveListener(mouseIdx:Number, x:Number, y:Number):Void
	{
		dispatchEvent({type:"mouseMove", mouseIdx:mouseIdx, x:x, y:y});
	}
	
	private function onMouseWheelListener(delta:Number, targetPath:String, mouseIdx:Number, x:Number, y:Number):Void
	{
		dispatchEvent({type:"mouseMove", delta:delta, targetPath:targetPath});
	}
	
	
	
}
