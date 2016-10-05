﻿/**
 * Manage focus between the components.  Intercept focus from the player, and hand it off to the "focused" component through the display-list hierarchy using a bubbling approach. Focus can be interupted or handled on every level.
 */

/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

/*
 With sub components, if the sub-component is later in the tab order than its parent, it will cause issues.  OptionStepper is a good example
 SetFocus does not fire Selection change events if the previous target is its child... Works in GFX!
 
 # First item must receive focus via and explicit call to component.setFocus();
 # If no components are included, there is no Focus Handler.
 # Clicks propagate to this class by way of Selection.setFocus handler.
*/

import gfx.managers.InputDelegate;
import gfx.ui.NavigationCode;
import System.capabilities;

class gfx.managers.FocusHandler {
	
// Constants:	

// Static Interface
	private static var _instance:FocusHandler = instance;
	/** Return a reference to the static FocusHandler instance.*/
	public static function get instance():FocusHandler {
		if (_instance == null) { _instance = new FocusHandler(); }
		return _instance;
	}
	
// Public Properties:

// Private Properties:
	private var inputDelegate:InputDelegate;
	private var currentFocusLookup:Array;
	private var actualFocusLookup:Array;
	private var inited:Boolean = false;

// Initialization:
	/**
	 * Create a new FocusHandler instance. This method should only be called internally by the FocusHandler class, as the implementation is a Singleton.
	 */
	public function FocusHandler() {
		Selection.addListener(this); // Selection handles Keyboard focus changes only!
		_global.gfxExtensions = 1; // Enable GFx extensions
		Selection.alwaysEnableArrowKeys = true; // Capture moveFocus commands whether or not the focusRect is visible.
		Selection.disableFocusKeys = true; // Disable the actual arrow key behaviour so we can override it.
		Selection.disableFocusAutoRelease = true; // Focus will not be removed by a mouse movement 
		Selection.disableFocusRolloverEvent = true;	// Focus will not fire onRollOver/Out events
		_root._focusrect = false;
		
		currentFocusLookup = [];
		actualFocusLookup = [];
	}
	
	private function initialize():Void {
		inited = true;
		inputDelegate = InputDelegate.instance;
		inputDelegate.addEventListener("input", this, "handleInput");
	}

// Public Methods:
	/**
	 * Returns the current focus, according to the focusHandler. This may vary from the actual stage focus.
	 */
	public function getFocus(focusIdx:Number):MovieClip { return currentFocusLookup[focusIdx]; }
	
	/**
	 * Set focus to a component.  This is called internally when stage focus changes, and can also be called manually to set focus to the first component in a movie. The actual focus is determined by recursively checking the {@code focusTarget} of the component.
	 * @param focus The movieclip to apply focus to.
	 */
	public function setFocus(focus:MovieClip, focusIdx:Number):Void {
		if (!inited) { initialize(); } // InputHandler is not yet available when the FocusHandler is created.
		// Determine Component focus
		while (focus.focusTarget != null) {
			focus = focus.focusTarget;
		}
		
		// Make focus change
		var actualFocus:MovieClip = actualFocusLookup[focusIdx];
		var currentFocus:MovieClip = currentFocusLookup[focusIdx];
		if (currentFocus != focus) { // Component focus has changed
			currentFocus.focused = currentFocus.focused & ~(1 << focusIdx);
			currentFocus = focus;
			currentFocusLookup[focusIdx] = focus;
			currentFocus.focused = currentFocus.focused | (1 << focusIdx);
		}
		
		/*	Stage focus has changed. This is important to do separately, in case a sub-component was clicked, and it might get stage focus.
			Note that in composite components, since the parent component will likely not have mouse events, the stage focus remains
			on the element that has been clicked. */
		if (actualFocus != currentFocus && !(actualFocus instanceof TextField)) {
			var controllerMask:Number = Selection.getControllerMaskByFocusGroup(focusIdx);
			for (var i:Number = 0; i < capabilities["numControllers"]; i++) {
				var controllerValue:Boolean = ((controllerMask >> i) & 0x1) != 0;
				if (controllerValue) { Selection.setFocus(currentFocus, i); }
			}			
		}		
	}
	
	/**
	 * Handle input events from the {@link InputDelegate}.  Input details are passed onto the first item in the {@code pathToFocus}, which is a display list hierarchy of Scaleform components, or any view that implements a "handleInput" method. If a view "handles" input, it will return {@code true}.  If this method receives a return value of {@code false}, it will pass the input onto the Scaleform player using the {@code Selection.moveFocus()} method.
	 * @param event The input event generated by the InputDelegate.
	 */
	public function handleInput(event:Object):Void {
		var controllerIdx:Number = event.details.controllerIdx;
		var focusIdx:Number = Selection.getControllerFocusGroup(controllerIdx);
		var path:Array = getPathToFocus(focusIdx);
		if (path.length == 0 || path[0].handleInput == null || path[0].handleInput(event.details, path.slice(1)) != true) {
			if (event.details.value == "keyUp") { return; }
			var nav:String = event.details.navEquivalent;
			if (nav != null) {
				var focusedElem:Object = eval(Selection.getFocus(controllerIdx));
				// TextField edge-case. If a TextField is focused, use the caret position to determine if focus should change.
				var actualFocus:MovieClip = actualFocusLookup[focusIdx];
				if (actualFocus instanceof TextField && focusedElem == actualFocus && textFieldHandleInput(nav, controllerIdx)) { return; } 
				
				var dirH:Boolean = (nav == NavigationCode.LEFT || nav == NavigationCode.RIGHT);
				var dirV:Boolean = (nav == NavigationCode.UP || nav == NavigationCode.DOWN);				
				var focusContext:MovieClip = focusedElem._parent;
				var focusMode:String = "default";
				if (dirH || dirV) {
					var focusProp:String = dirH ? "focusModeHorizontal" : "focusModeVertical";
					while (focusContext) {
						focusMode = focusContext[focusProp];
						if (focusMode && focusMode != "default") break;
						focusContext = focusContext._parent;
					}
				}
				else { focusContext = null; }
				//var newFocus:Object = Selection.findFocus(nav, focusContext, focusMode == "loop", null, false, controllerIdx);
				//if (newFocus) { Selection.setFocus(newFocus, controllerIdx); }
				
				/*
				trace("----");				
				trace("findFocus nav: " + nav);
				trace("          focusContext: " + focusContext); 
				trace("          focusMode: " + focusMode);
				trace("          controllerIdx: " + controllerIdx);
				trace("          focusIdx: " + focusIdx);
				/*/
				//*/
			}
		}
	}
	
// Private Methods:
	private function getPathToFocus(focusIdx:Number):Array {
		var currentFocus:MovieClip = currentFocusLookup[focusIdx];
		var f:MovieClip = currentFocus;
		var path:Array = [f];
		while (f) {
			f = f._parent;
			if (f.handleInput != null) {
				path.unshift(f);
			}
			if (f == _root) { break; }
		}
		return path;
	}
	
	/**
	 * @exclude
	 */
	public function onSetFocus(oldFocus, newFocus, controllerIdx:Number):Void {	
		if (oldFocus instanceof TextField && newFocus == null) { return; } // Do not allow the textField->null default behaviour in the framework.
		var focusIdx:Number = Selection.getControllerFocusGroup(controllerIdx);
		// Special case: If the MovieClip that included focus was unloaded and reloaded, then the FocusHandler thinks the new instance is the unloaded one and considers the new instance as the currently focused element - which is incorrect. Check if actualFocus.focused or actualFocus._parent.focused (for TextField) is false - if so, reapply focus.
		var actualFocus:MovieClip = actualFocusLookup[focusIdx];		
		if (actualFocus == newFocus) {
			var np:MovieClip = (newFocus instanceof TextField) ? newFocus._parent : newFocus;
			var npf:Number = np.focused;
			if (npf & (1 << focusIdx) == 0) {
				np.focused = npf | (1 << focusIdx);
			}
		}
			
		actualFocusLookup[focusIdx] = newFocus;
		setFocus(newFocus, focusIdx);
	}
	
	/**
	 * TextFields do not have any logic to stop focus from changing when they are the stage focus, so we check the caret index, and only change focus if it is at the top/bottom depending on the navigation direction.
	 */
	private function textFieldHandleInput(nav:String, controllerIdx:Number):Boolean {
		var position:Number = Selection.getCaretIndex(controllerIdx);
		var focusIdx:Number = Selection.getControllerFocusGroup(controllerIdx);
		var actualFocus:MovieClip = actualFocusLookup[focusIdx];
		switch(nav) {
			case NavigationCode.UP:
				if (!actualFocus.multiline) { return false; }
			case NavigationCode.LEFT:
				return (position > 0);
			case NavigationCode.DOWN:
				if (!actualFocus.multiline) { return false; }
			case NavigationCode.RIGHT:
				return (position < TextField(actualFocus).length);
		}
		return false;
	}

}