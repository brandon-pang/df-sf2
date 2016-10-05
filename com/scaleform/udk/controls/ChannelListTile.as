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
import gfx.motion.Tween;
import mx.transitions.easing.*;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ChannelListTile extends ListItemRenderer {

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var typeIcon:MovieClip;
	private var gaugeBar:MovieClip;
	private var bg:MovieClip;
	private var textField0:MovieClip;
	private var textField1:MovieClip;
	private var gaugeNum:Number;

	private var frendViewMC:MovieClip;
	
	private var txt1:String;
	private var txt2:String;
	

	// Initialization:
	public function ChannelListTile() {
		super();
	}

	public function setData(data:Object):Void {
		trace("ChannelList Data tooltip ======================  "+data.ToolTip);
		if (data == undefined) {
			this._visible = false;
			return;
		}		
		this._visible = true;
		this.data = data;		
		
		textField0.noTranslate=true
		textField1.noTranslate=true		
		frendViewMC.txt1.noTranslate=true
		frendViewMC.txt3.noTranslate=true
		
		var boo:Boolean;
		//0:none 1:녹색 2:붉은색 3:흰색 4:와인색
		
		trace ("data.typeIcon = " +data.typeIcon)
		
		if (data.typeIcon == undefined || data.typeIcon == "0" || data.typeIcon == "") {
			typeIcon.gotoAndStop(1);
		} else {
			typeIcon.gotoAndStop(Number(data.typeIcon)+1);
		}

		if (data.Flag == "0") {
			this.disabled = false
			setVisible(true);

			textField0.text = data.No;
			textField1.text = data.ChannelName;
			setGaugeValue(Number(data.StatBarNo),Number(data.FullGauge));
		}
		
		else if (data.Flag == "1") {
			this.disabled  = true;
			setVisible(true);			
			
			textField0.text = data.No;
			textField1.text = data.ChannelName;			
			setGaugeValue(Number(-1),Number(data.FullGauge));
		}		

		if (data.ClanFrendLength == undefined && data.FrendLength == undefined) {
			frendViewMC._visible = false;
		} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
			frendViewMC._visible = false;
		} else {			
			frendViewMC._visible = true;

			if (data.ClanFrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt3.text = data.ClanFrendLength
			}
			if (data.FrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt3.text = data.FrendLength
			}
			if (data.ClanFrendLength != "" && data.FrendLength != "") {
				frendViewMC.gotoAndStop(2);
				frendViewMC.txt1.text = data.ClanFrendLength
				frendViewMC.txt3.text = data.FrendLength
				
			} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
				frendViewMC._visible = false;
			}
		}
	}
	public function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized) {
			return;
		}
		validateNow();// Ensure that the width/height is up to date.

		//arrow._z = -450;
		//arrow._y = -50;
        //trace (_label)
		
		if (data.typeIcon == undefined || data.typeIcon == "0" || data.typeIcon == "") {
			typeIcon.gotoAndStop(1);
		} else {
			typeIcon.gotoAndStop(Number(data.typeIcon)+1);
		}

		if (data.Flag == "0") {
			this.disabled = false
			textField0.text = data.No;
			textField1.text = data.ChannelName;
			setGaugeValue(Number(data.StatBarNo),Number(data.FullGauge));
		}
		
		else if (data.Flag == "1") {
			this.disabled  = true;			
			textField0.text = data.No;
			textField1.text = data.ChannelName;			
			setGaugeValue(Number(-1),Number(data.FullGauge));
		}		

		if (data.ClanFrendLength == undefined && data.FrendLength == undefined) {
			frendViewMC._visible = false;
		} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
			frendViewMC._visible = false;
		} else {			
			frendViewMC._visible = true;

			if (data.ClanFrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt3.text = data.ClanFrendLength
			}
			if (data.FrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt3.text = data.FrendLength
			}
			if (data.ClanFrendLength != "" && data.FrendLength != "") {
				frendViewMC.gotoAndStop(2);
				frendViewMC.txt1.text = data.ClanFrendLength
				frendViewMC.txt3.text = data.FrendLength
				
			} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
				frendViewMC._visible = false;
			}
		}
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	/*private function updateAfterStateChange():Void {		
		
	}*/


	private function setVisible(boo:Boolean):Void {
		bg._visible = boo;
		typeIcon._visible = boo;
		gaugeBar._visible = boo;
		textField0._visible = boo;
		textField1._visible = boo;
	}

	private function setGaugeValue(no:Number, full:Number):Void {		
		if (no>=0) {			
			gaugeBar.gotoAndStop(1);
			var tWid = (190/100)*no;
			//----------------------------------------------게이지 꽉 차면 다른색상으로 변경
			if (full == 1) {
				gaugeBar["bar"].gotoAndStop(2);
			} else {
				gaugeBar["bar"].gotoAndStop(1);
			}
			Tween.init();
			gaugeBar["bar"].tweenTo(0.1,{_width:tWid},Strong.easeOut);
		} else {				
			gaugeBar.gotoAndStop(2);			
		}
	}
}