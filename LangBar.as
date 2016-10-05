/**********************************************************************

Filename    :   StatusWindowCh.as
Content     :   Status Window Chinese ActionScript object
Created     :   9/11/2008
Authors     :   Ankur
Copyright   :   (c) 2008 Scaleform Corp. All Rights Reserved.

This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.

**********************************************************************/

class LangBar 
{

	public var toggleSymbol:Boolean;

	public var toggleShape:Boolean;

	public var toggleInputMode:Boolean;
	
	public var parent_mc:MovieClip;

	public function LangBar(mc: MovieClip)
	{
		toggleSymbol = false;
	
		toggleShape = false;
	
		toggleInputMode = false;
		
		parent_mc = mc;
		
		mc.Controller = this;
	}

	public function DisplayStatusWindow():Void
	{
		parent_mc.CreateInputModeTab("DirectInput");
	}
	
	public function RemoveStatusWindow()
	{
		trace("removestatuswindow called on jp window: " + parent_mc.InputModeList_mc);
		removeMovieClip(parent_mc.InputModeList_mc);
	}
	
	public function SetInputMode(mode:String)
	{
		trace("mode = " + mode);
		if (mode == "Alphanumeric_FullShape")
		{
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Full-width Alphanumeric";
		}
		
		if (mode == "Alphanumeric_HalfShape")
		{
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Half-width Alphanumeric";
		}
		
		if (mode == "Katakana_HalfShape")
		{
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Half-width Katakana";
		}
		
		if (mode == "Katakana_FullShape")
		{
			trace(parent_mc.InputModeTab_mc.InputMode_tf.text);
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Full-width Katakana";
		}
		
		if (mode == "Hiragana_FullShape")
		{
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Hiragana";
		}
		
		if (mode == "DirectInput")
		{
			parent_mc.InputModeTab_mc.InputMode_tf.text = "Direct Input";
		}
		
		parent_mc.Resize();
	}
}