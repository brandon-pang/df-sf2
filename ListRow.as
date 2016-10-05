/**********************************************************************

Filename    :   ListRow.as
Content     :   
Created     :   
Authors     :   Ankur 
Copyright   :   (c) 2007 Scaleform Corp. All Rights Reserved.

This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.

**********************************************************************/

class ListRow extends MovieClip
 {
	public var bkGround_mc:MovieClip;
	public var RowNumberBackground_mc:MovieClip;
	public var currentState:String = "UnSelected";
	public var Value:TextField;
	public var ID:TextField;
	public var controller:Object;
	
	function ListRow(_controller:Object)
	{
		controller = _controller;
	}
	// This class is a good place to keep these functions because they are loaded up when the listrow movie 
	// is instantiated during attachMovie and they are available for execution before the first advance on this movie
	// is called. If these functions are put on the first frame of the listrow movie, they will not be available
	// until the first advance.
	public function GotoOffState()
	{
		if(bkGround_mc != undefined)
		{
			controller.DisplayInfo(this._name);
		//	bkGround_mc.gotoAndPlay("off");
			var oldTextFormat:TextFormat = Value.getTextFormat();		
			oldTextFormat.color = _root.candidateList.TextColor;		
			oldTextFormat.size 	= _root.candidateList.FontSize;
			new Color(bkGround_mc).setRGB(_root.candidateList.TextBackgroundColor);
			new Color(RowNumberBackground_mc).setRGB(_root.candidateList.IndexBackgroundColor);
			Value.setTextFormat(oldTextFormat);
			ID.setTextFormat(oldTextFormat);
			if (_root.candidateList.DisplayCallback != undefined)
				_root.candidateList.DisplayCallback(0);
		}
		currentState = "UnSelected";  
		
	}
	
	public function GotoOnState()
	{
		controller.DisplayInfo(this._name);
		if(bkGround_mc != undefined)
		{
	//		bkGround_mc.gotoAndPlay("on");
			var oldTextFormat:TextFormat = Value.getTextFormat();
			oldTextFormat.color = _root.candidateList.SelectedTextColor;		
			oldTextFormat.size 	= _root.candidateList.FontSize;
			new Color(bkGround_mc).setRGB(_root.candidateList.SelectedTextBackgroundColor);
			new Color(RowNumberBackground_mc).setRGB(_root.candidateList.SelectedIndexBackgroundColor);
			Value.setTextFormat(oldTextFormat);
			ID.setTextFormat(oldTextFormat);
		}
		currentState = "Selected"; 		
	}
 }