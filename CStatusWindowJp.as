/**********************************************************************

Filename    :   StatusWindowCh.as
Content     :   Status Window Chinese ActionScript object
Created     :   9/11/2008
Authors     :   Ankur
Copyright   :   (c) 2008 Scaleform Corp. All Rights Reserved.

This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.

**********************************************************************/

class CStatusWindowJp extends CStatusWindowBase
{

	public var toggleSymbol:Boolean;

	public var toggleShape:Boolean;

	public var toggleInputMode:Boolean;
	
	public var parent_mc:MovieClip;

	public function CStatusWindowJp(mc: MovieClip)
	{
		toggleSymbol = false;
	
		toggleShape = false;
	
		toggleInputMode = false;
		
		parent_mc = mc;
		
		mc.Controller = this;
	}

	public function  DisplayStatusWindow(bgColor1:Number, bgColor2:Number, textColor1:Number, textColor2:Number):Void
	{
		parent_mc.CreateInputModeTab("<img src='OA' width='24' height='24' align='baseline' vspace='-10'>", bgColor1, bgColor2, textColor1, textColor2);
	}
	
	public function SetBackgroundColor(color1:Number, color2:Number):Void
	{
		parent_mc.SetBackgroundColor(color1, color2);
	}
	
	public function SetTextColor(color1:Number, color2:Number):Void
	{
		parent_mc.SetTextColor(color1, color2);
	}
	
	public function RemoveStatusWindow()
	{
		if (parent_mc.InputModeList_mc != undefined)
			removeMovieClip(parent_mc.InputModeList_mc);
	} 	

	public function SetInputMode(mode:String)
	{
		// close input mode list
		parent_mc.CloseList(parent_mc.NumRows);
		
		//trace ("mc = "+ mode)
		if (mode == "Alphanumeric_FullShape")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='OA' width='24' height='24' align='baseline' vspace='-10'>";
			//trace (targetPath(this));
		}
		
		if (mode == "Alphanumeric_HalfShape")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='BA' width='24' height='24' align='baseline' vspace='-10'>";
		}
		
		if (mode == "Katakana_HalfShape")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='BK' width='24' height='24' align='baseline' vspace='-10'>";
		}
		
		if (mode == "Katakana_FullShape")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='OK' width='24' height='24' align='baseline' vspace='-10'>";
		}
		
		if (mode == "Hiragana_FullShape")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='OH' width='24' height='24' align='baseline' vspace='-10'>";
		}
		
		if (mode == "DirectInput")
		{
			parent_mc.InputModeTab_mc.tf.htmlText = "<img src='OA' width='24' height='24' align='baseline' vspace='-10'>";
		}
		var width:Number = parent_mc.InputModeTab_mc.tf.textWidth + 4;
		parent_mc.InputModeTab_mc.tf._width = width;
		parent_mc.Resize(width, parent_mc.InputModeTab_mc);
	}
}