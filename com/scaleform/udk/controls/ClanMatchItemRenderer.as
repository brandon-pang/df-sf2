/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ClanMatchItemRenderer extends ListItemRenderer {
	private var lockIcon:MovieClip;
	private var fullIcon:MovieClip;

	private var textField0:MovieClip;
	//private var textField1:MovieClip;
	
	private var textField2:MovieClip;
	private var textField3:MovieClip;
	private var textField4:MovieClip;
	private var textField5:MovieClip;
	
	public var _idx:String;
	//private var _hit:MovieClip;
	//private var _mask:MovieClip;
	//private var doubleClickDuration:Number = 500;//LM: This could be public or public-static?
	//private var doubleClickInterval:Number;

	// Initialization:
	public function ClanMatchItemRenderer() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined || data.No == "") {
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;
		fullIcon.gotoAndStop(Number(data.Full)+1);
		lockIcon.gotoAndStop(Number(data.Pass)+1);

		textField0.text = data.No;		
		textField2.text = data.GameMode;		
		textField3.text = data.Players;
		textField4.text = data.Stat;
		this.disabled = data.bIsLocked;		
		
		_idx = String(this.index);
	}

	private function updateAfterStateChange():Void {
		fullIcon.gotoAndStop(Number(data.Full)+1);
		lockIcon.gotoAndStop(Number(data.Pass)+1);

		textField0.text = data.No;
		textField2.text = data.GameMode;
		textField3.text = data.Players;
		textField4.text = data.Stat;
		this.disabled = data.bIsLocked;
		
		_idx = String(this.index);
	}
}