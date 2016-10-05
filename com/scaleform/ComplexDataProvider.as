import gfx.events.EventDispatcher;
import gfx.io.GameDelegate;

/**
 * Defines the methods that all DataProviders should expose. Note that this interface is not implemented by the existing components, and does not need to be implemented, it is just a reference. There are additional properties and getter/setters defined in the interface, which are commented out for compiler compatibility.
 */
class com.scaleform.ComplexDataProvider extends EventDispatcher {
	
	public var length = 0;
	
	public function ComplexDataProvider() { 
		super();		
		GameDelegate.call("Complex.requestLength", [], this, "invalidate");
	}
	
	public function initialize(list:Object):Void
	{
		list.cachedData = new Array();
		list.buildData = function() {
			for (var i:Number = 0; i < this.rowCount; i++) {
				if (!this.cachedData[i]) this.cachedData[i] = new Object();
				var e:Object = this.cachedData[i];
				e.id = arguments[i*2];
				e.name = arguments[i*2+1];
			}
			this.populateData(this.cachedData);
		}
	}
	
	public function requestItemRange(startIndex:Number, endIndex:Number, scope:Object, callBack:String):Array
	{
		GameDelegate.call("Complex.requestItemRange", [startIndex, endIndex], scope, "buildData");
		return null;
	}
	
	public function invalidate(length:Number):Void
	{
		this.length = length;
		dispatchEvent({type:"change"});
	}

}