import com.scaleform.udk.utils.SFMouseEvent;
import gfx.core.UIComponent;
import gfx.managers.PopUpManager;
import gfx.utils.Delegate;
import System.capabilities;

/**
 * @author noww
 */
[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.Tooltip extends UIComponent {
	
// Static Interface
	public static var currentTooltip:MovieClip;
	public static var open:Boolean = false;
	
	private var _bSetup:Boolean = false;
	
	/**
	 * Create a Dialog instance using the {@code PopUpManager}.  The dialog is pre-populated with initialization data, and centered on the stage. The calling object can add event listeners for "close" and "submit" events when using the default Dialog class, or custom events dispatched from custom dialogs.
	 *
	 * {@code var dialog:MovieClip = Dialog.show("DialogSymbol", props, true);
	 	dialog.addEventListener("submit", this, "handleSubmit");
		function handleSubmit(event:Object):Void;}
	 * @param context The context used to create the popup instance. Typically this would be the source for the dialog.
	 * @param linkage The library linkage to attach as a dialog.
	 * @param props Properties specific to the dialog.
	 * @param modal Determines if the modal blocks user interaction of other controls outside the Dialog while open.
	 * @returns A reference to the newly-created dialog.
	 * @see PopUpManager
	 */
	public static function show(context:MovieClip, linkage:String, props:Object):MovieClip 
	{		
		hide();
		
		var toolTip:MovieClip = PopUpManager.createPopUp(context, linkage, props, _level0);
		if (toolTip == null) {
			return null;
		}		
		currentTooltip = toolTip;
		currentTooltip.owner = context;
		SFMouseEvent.instance.addEventListener("mouseMove", currentTooltip, "setPosition");
		
		open = true;
		return toolTip;
	}
	
	/**
	 * Remove the current dialog from the stage. The {@code hide()} method destroys the dialog using {@code removeMovieClip()}, which automatically cleans up dialogs extending UIComponent.
	 */
	public static function hide():Void
	{
		open = false;
		if (currentTooltip == null) { return; }
		SFMouseEvent.instance.removeEventListener("mouseMove", currentTooltip, "setPosition");
		currentTooltip.owner = null;
		currentTooltip.removeMovieClip();
		currentTooltip = null;
	}
	
	
// Public Properties:
	public var title:String;
	public var message:String;    	
	public var owner:Object;
	[Inspectable(type="Object", defaultValue="theme:default,close:close,submit:submit")]
	public var soundMap:Object = { theme:"default", close:"close", submit:"submit" };
	
// Private Properties:
	

// Initialization:
	
	public function Tooltip() { super(); }

// Public Methods:	
	/** @exclude */
	public function toString():String {
		return "[Scaleform Tooltip " + _name + "]";
	}
	
// Private Methods:
	private function draw():Void {
		if (!_bSetup)
		{
			populateUI();
			_bSetup = true;
		}
		
		super.draw();
	}
	
	/**
	 * Populate the UI with data, usually passed in via the initObject of {@code Dialog.show()}. This method can be overriden in child classes, or can be added to the timeline of a Dialog.
	 */
	private function populateUI():Void {}
	
	private function setPosition():Void {}

}
