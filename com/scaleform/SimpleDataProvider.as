import gfx.events.EventDispatcher;
import gfx.io.GameDelegate;

/**
 * Defines the methods that all DataProviders should expose. Note that this interface is not implemented by the existing components, and does not need to be implemented, it is just a reference. There are additional properties and getter/setters defined in the interface, which are commented out for compiler compatibility.
 */
class com.scaleform.SimpleDataProvider extends EventDispatcher {
	
	public var length = 0;
	
	public function SimpleDataProvider() { 
		super();		
		GameDelegate.call("Simple.requestLength", [], this, "invalidate");
	}
	
	public function initialize(list:Object):Void
	{
		list.cachedData = new Array();
		list.buildData = function() {
			for (var i:Number = 0; i < arguments.length; i++) {
				this.cachedData[i] = arguments[i];
			}
			this.populateData(this.cachedData);
		}
	}
	
	public function requestItemRange(startIndex:Number, endIndex:Number, scope:Object, callBack:String):Array
	{
		GameDelegate.call("Simple.requestItemRange", [startIndex, endIndex], scope, "buildData");
		return null;
	}
	
	public function invalidate(length:Number):Void
	{
		this.length = length;
		dispatchEvent({type:"change"});
	}

}