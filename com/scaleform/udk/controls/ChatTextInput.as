/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.TextInput;

import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;

class com.scaleform.udk.controls.ChatTextInput extends TextInput
{

	// Initialization:
	public function ChatTextInput()
	{
		super();
	}
	public function handleInput(details:gfx.ui.InputDetails, pathToFocus:Array)
	{
		//
		// We use handleInput to intercept the event before it reaches its target - the input textfield
		//
		if (details.code == Key.ENTER && details.value == "keyDown") {			
			dispatchEvent({type:"submit"});			
			return true;			
		} else {			
			return //super.handleInput(details, pathToFocus);
		}
	}
}