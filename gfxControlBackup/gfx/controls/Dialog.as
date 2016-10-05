﻿/**
	The CLIK Dialog component displays a dialog view, such as an Alert dialog, on top of the rest of the application. It provides a static interface to instantiate, show and hide any MovieClip as a dialog, as well as a base class that can be used (extended) as the actual dialog MovieClip. To ensure only a single dialog is open at once, new Dialog.show() calls will close the currently open dialog. 
 
 	<b>Inspectable Properties</b>
 	A MovieClip that derives from the Dialog component will have the following inspectable properties:<ul>
	<li><i>visible</i>: Hides the component if set to false.</li>
	<li><i>disabled</i>: Disables the component if set to true.</li>
	<li><i>enableInitCallback</i>: If set to true, _global.CLIK_loadCallback() will be fired when a component is loaded and _global.CLIK_unloadCallback will be called when the component is unloaded. These methods receive the instance name, target path, and a reference the component as parameters.  _global.CLIK_loadCallback and _global.CLIK_unloadCallback should be overriden from the game engine using GFx FunctionObjects.</li>
	<li><i>soundMap</i>: Mapping between events and sound process. When an event is fired, the associated sound process will be fired via _global.gfxProcessSound, which should be overriden from the game engine using GFx FunctionObjects.</li></ul>
	
	<b>States</b>
	There are no states for the Dialog component. The MovieClip displayed as the dialog view may or may not have its own states.
	
	<b>Events</b>
	All event callbacks receive a single Object parameter that contains relevant information about the event. The following properties are common to all events. <ul>
	<li><i>type</i>: The event type.</li>
	<li><i>target</i>: The target that generated the event.</li></ul>
		
	The events generated by the Dialog component are listed below. The properties listed next to the event are provided in addition to the common properties.<ul>
	<li><i>show</i>: The component’s visible property has been set to true at runtime.</li>
	<li><i>hide</i>: The component’s visible property has been set to false at runtime.</li>
	<li><i>submit</i>: The submit button of the Dialog has been clicked.</li><ul>
		<li><i>data</i>: The submitted data of the Dialog. The Dialog component’s getSubmitData method is invoked for this property, and should be overridden by custom dialog boxes. The default value returned is true (Boolean). The return value of getSubmitData is AS2 Object.</li></ul></li>
	<li><i>close</i>: The close button of the Dialog has been clicked.</li></ul>
*/

/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

/*
*/
 
import gfx.controls.Button;
import gfx.core.UIComponent;
import gfx.managers.PopUpManager;
import gfx.utils.Delegate;
import System.capabilities;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class gfx.controls.Dialog extends UIComponent {
	
// Static Interface
	/** A reference to the current, open dialog. */
	public static var currentDialog:MovieClip;
	/** Determines if there is a currently open dialog. */
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
	public static function show(context:MovieClip, linkage:String, props:Object, modal:Boolean):MovieClip {		
		// Single-dialog support only.
		hide();
		
		// If it's modal, add a modal blocking clip.
		//LM: This could be changed to happen once instead of each time.
		var modalBackground:MovieClip = null;
		if (modal) {
			modalBackground = PopUpManager.createPopUp(context, "PopUpModal", {_x:0, _y:0}, _level0);
			if (modalBackground != null) {
				modalBackground._width = Stage.width;
				modalBackground._height = Stage.height;
				modalBackground.tabEnabled = false;
				modalBackground.useHandCursor = false;
				modalBackground.onRelease = blockInteraction;
			}
		}
		
		var dialog:MovieClip = PopUpManager.createPopUp(context, linkage, props, _level0);
		if (dialog == null) {
			if (modalBackground != null) { modalBackground.removeMovieClip(); }
			return null;
		}		
		currentDialog = dialog;
		
		dialog["modalBackground"] = modalBackground;
		PopUpManager.centerPopUp(dialog);
		for (var i:Number = 0; i < capabilities["numControllers"]; i++) {		
			Selection.setModalClip(dialog, i); // The Scaleform GFx player will only tab controls inside this clip when this property is set.
		}
		dialog.addEventListener("close", Dialog, "closeDialog");
		dialog.addEventListener("submit", Dialog, "closeDialog");
		open = true;
		return dialog;
	}
	
	/**
	 * Remove the current dialog from the stage. The {@code hide()} method destroys the dialog using {@code removeMovieClip()}, which automatically cleans up dialogs extending UIComponent.
	 */
	public static function hide():Void {
		for (var i:Number = 0; i < capabilities["numControllers"]; i++) {
			Selection.setModalClip(null, i);
		}
		open = false;
		if (currentDialog == null) { return; }
		if (currentDialog.modalBackground != null) { currentDialog.modalBackground.removeMovieClip(); }
		currentDialog.removeMovieClip();
		currentDialog = null;
	}
	
	private static function closeDialog(event:Object):Void {
		hide();
	}
	
	private static function blockInteraction():Void {}
	
	
// Public Properties:
	/** The optional title of a dialog. Only defined when it is passed in the initObject of {@code Dialog.show()}. */
	public var title:String;
	/** The optional message of a dialog. Only defined when it is passed in the initObject of {@code Dialog.show()}. */
	public var message:String;    	
	/** Mapping between events and sound process */
	[Inspectable(type="Object", defaultValue="theme:default,close:close,submit:submit")]
	public var soundMap:Object = { theme:"default", close:"close", submit:"submit" };

// Private Properties:

// UI Elements
	/** An optional Button UI element used as a "close" button. When clicked, a "close" event is dispatched. */
	public var closeBtn:Button;
	/** An optional Button UI element used as a "cancel" button. When clicked, a "close" event is dispatched. */
	public var cancelBtn:Button;
	/** An optional Button UI element used as a submit button. When clicked, a "submit" event is dispatched, containing a {@code data} property which is the value of the {@code getSubmitData()} method. */
	public var submitBtn:Button;
	/** An optional Button UI element used to drag the Dialog around the stage. */
	public var dragBar:MovieClip;
	

// Initialization:
	/**
	 * The constructor is called when a Dialog or a sub-class of Dialog is instatiated on stage or by using {@code attachMovie()} in ActionScript. This component can <b>not</b> be instantiated using {@code new} syntax. When creating new components that extend Dialog, ensure that a {@code super()} call is made first in the constructor.
	 */
	public function Dialog() { super(); }

// Public Methods:	
	/** @exclude */
	public function toString():String {
		return "[Scaleform Dialog " + _name + "]";
	}
	
// Private Methods:
	private function draw():Void {
		if (!_bSetup)
		{
			if ((closeBtn ? !closeBtn.initialized : false) || (cancelBtn ? !cancelBtn.initialized : false) || (submitBtn ? !submitBtn.initialized : false)) {
				invalidate();
				return;
			}
			
			if (closeBtn != null) { closeBtn.addEventListener("click", this, "handleClose"); }
			if (cancelBtn != null) { cancelBtn.addEventListener("click", this, "handleClose"); }
			if (submitBtn != null) { submitBtn.addEventListener("click", this, "handleSubmit"); }
			
			if (dragBar != null) { 
				dragBar.tabEnabled = false;
				dragBar.onPress = Delegate.create(this, startDrag);
				dragBar.onRelease = Delegate.create(this, stopDrag);
			}
			populateUI();
			_bSetup = true;
		}
		
		super.draw();
	}
	
	/**
	 * Populate the UI with data, usually passed in via the initObject of {@code Dialog.show()}. This method can be overriden in child classes, or can be added to the timeline of a Dialog.
	 */
	private function populateUI():Void {}
	
	/**
	 * Dispatches a "close" event. Objects creating dialogs can also listen for this event to handle it manually, however the dialog will automatically close when the close event is dispatched.
	 */
	private function handleClose(event:Object):Void {
		dispatchEventAndSound({type:"close"});
	}
	
	/**
	 * Dispatches a "submit" event. The submit event includes a data property, which returns the data retrieved from the {@code getSubmitData} method. Objects creating dialogs need to listen for this event to handle it manually, however the dialog will automatically close when the submit event is dispatched.
	 */
	private function handleSubmit(event:Object):Void {
		dispatchEventAndSound({type:"submit", data:getSubmitData()});
	}
	
	/**
	 * Returns an object containing the data collected in the dialog.  Custom dialogs can override this method to return data specific to the dialog when the {@link handleSubmit} method is called. Alternatively, this method can be defined on the timeline of the Dialog symbol. This enables custom submit data to be added to a Dialog without extending the Dialog class.
	 * @returns An object containing data collected in a submit operation. Defaults to {@code true}.
	 */
	private function getSubmitData():Object {
		return true;
	}

}
