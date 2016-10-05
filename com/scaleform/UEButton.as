﻿
/**
 * 	Buttons are the foundation component of the CLIK framework and are used anywhere a clickable interface control is required. The default Button class (gfx.controls.Button) supports a textField to display a label, and states to visually indicate user interaction. Buttons can be used on their own, or as part of a composite component, such as ScrollBar arrows or the Slider thumb. Most interactive components that are click-activated compose or extend Button.
   
   	The CLIK Button is a general purpose button component, which supports mouse interaction, keyboard interaction, states and other functionality that allow it to be used in a multitude of user interfaces. It also supports toggle capability as well as animated states. The ToggleButton, AnimatedButton and AnimatedToggleButton provided in the Button.fla component source file all use the same base component class.
	
	<b>Inspectable Properties</b>
	The inspectable properties of the Button component are:<ul>
	<li><i>label</i>: Sets the label of the Button.</li>
	<li><i>toggle</i>: Sets the toggle property of the Button. If set to true, the Button will act as a toggle button.</li>
	<li><i>visible</i>: Hides the button if set to false.</li>
	<li><i>disabled</i>: Disables the button if set to true.</li>
	<li><i>disableFocus</i>: By default buttons receive focus for user interactions. Setting this property to true will disable focus acquisition.</li>
		<li><i>disableConstraints</i>: The Button component contains a constraints object that determines the placement and scaling of the textField inside of the button when the component is resized. Setting this property to true will disable the constraints object. This is particularly useful if there is a need to resize or reposition the button's textField via a timeline animation AND the button component is never resized. If not disabled, the textField will be moved and scaled to its default values throughout its lifetime, thus nullifying any textField translation/scaling tweens that may have been created in the button's timeline.</li></ul>
	
	<b>States</b>
	The CLIK Button component supports different states based on user interaction. These states include <ul>
	<li>an up or default state.</li>
	<li>an over state when the mouse cursor is over the component, or when it is focused.</li>
	<li>a down state when the button is pressed.</li>
	<li>a disabled state.</li></ul>

	These  states are represented as keyframes in the Flash timeline, and are the minimal set of keyframes required for the Button component to operate correctly. There are other states that extend the capabilities of the component to support complex user interactions and animated transitions, and this information is provided in the Getting Started with CLIK Buttons document.	
	
	<b>Events</b>
	All event callbacks receive a single Object parameter that contains relevant information about the event. The following properties are common to all events. <ul>
	<li><i>type</i>: The event type.</li>
	<li><i>target</i>: The target that generated the event.</li></ul>
		
	The events generated by the Button component are listed below. The properties listed next to the event are provided in addition to the common properties.<ul>
	<li><i>show</i>: The visible property has been set to true at runtime.</li>
	<li><i>hide</i>: The visible property has been set to false at runtime.</li>
	<li><i>focusIn</i>: The button has received focus.</li>
	<li><i>focusOut</i>: The button has lost focus.</li>
	<li><i>select</i>: The selected property has changed.<ul>
		<li><i>selected</i>: The selected state of the Button, true for selected. Boolean type.</li></ul></li>
	<li><i>stateChange</i>: The button's state has changed.<ul>
		<li><i>state</i>: The Button's new state. String type, Values "up", "over", "down", etc.</li></ul></li>
	<li><i>rollOver</i>: The mouse cursor has rolled over the button.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>rollOut</i>: The mouse cursor has rolled out of the button.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</</li></ul></li>
	<li><i>press</i>: The button has been pressed.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</</li></ul></li>
	<li><i>doubleClick</i>: The button has been double clicked. Only fired when the {@link doubleClickEnabled} property is set.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</</li></ul></li>
	<li><i>click</i>: The button has been clicked.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</</li></ul></li>
	<li><i>dragOver</i>: The mouse cursor has been dragged over the button (while the left mouse button is pressed).<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</</li></ul></li>
	<li><i>dragOut</i>: The mouse cursor has been dragged out of the button (while the left mouse button is pressed).<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments).Number type. Values 0 to 3.</</li></ul></li>
	<li><i>releaseOutside</i>: The mouse cursor has been dragged out of the button and the left mouse button has been released.<ul>
		<li><i>mouseIndex</i>: The index of the mouse cursor used to generate the event (applicable only for multi-mouse-cursor environments).Number type. Values 0 to 3.</</li></ul></li></ul>

*/

/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

import flash.external.ExternalInterface; 
import gfx.controls.Button;

[InspectableList("disabled", "disableFocus", "visible", "toggle", "labelID", "disableConstraints", "bindingEnabled", "enableInitCallback")]
class com.scaleform.UEButton extends Button {
	
	public function UEButton() { super(); }
    
    private function configUI():Void {		
		if (bindingEnabled)
		{
			// Register control with game and setup events to fire back to the back-end
			ExternalInterface.call("__registerControl", this._name, this, "Button");
			addEventListener("click", this, "dispatchEventToGame");
			bindingEnabled = false;
		}	

		super.configUI();
		
		// Force dimension check if autoSize is set to true
		if (_autoSize) {
			sizeIsInvalid = true;
		}
		
		onRollOver = handleMouseRollOver;
		onRollOut = handleMouseRollOut;
		onPress = handleMousePress;
		onRelease = handleMouseRelease;		
		onDragOver = handleDragOver;
		onDragOut = handleDragOut;
		onReleaseOutside = handleReleaseOutside;
		
		if (focusIndicator != null && !_focused && focusIndicator._totalFrames == 1) { focusIndicator._visible = false; }
		
		updateAfterStateChange();
	}
		
	private function draw():Void {
		// Note that if this is called after a frame change, and there is a new keyframe, the size may be read incorrectly in GFx.
		if (sizeIsInvalid) { // The size has changed.	
			if (_autoSize && textField != null) { __width = calculateWidth(); }
			_width = __width;
			_height = __height;
		}
	}

}