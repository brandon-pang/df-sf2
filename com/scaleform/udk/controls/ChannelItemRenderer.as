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
 class com.scaleform.udk.controls.ChannelItemRenderer extends ListItemRenderer {

	// Constants:

	// Public Properties:

	// Priver Properties:
	private var typeIcon:MovieClip;
	//private var faceIcon:MovieClip;
	private var gaugeBar:MovieClip;
	private var bg:MovieClip;
	private var _hit:MovieClip;
	private var textField0:MovieClip;
	private var textField1:MovieClip;
	private var textField2:MovieClip;

	private var gaugeNum:Number;

	private var frendViewMC:MovieClip;
	private var mc_select_over:MovieClip;
	
	private var txt1:String;
	private var txt2:String;
	

	// Initialization:
	public function ChannelItemRenderer() {
		super();
		
	}

	public function setData(data:Object):Void {
		//trace(data.toString());
		if (data == undefined) {
			this._visible = false;
			return;
		}
		
		this._visible = true;
		this.data = data;
		
		
		
		textField0.noTranslate=true
		textField1.noTranslate=true
		textField2.noTranslate=true
		frendViewMC.txt1.noTranslate=true
		frendViewMC.txt3.noTranslate=true
		
		mc_select_over._visible=true
		
		var boo:Boolean;
		//0:none 1:녹색 2:붉은색 3:흰색 4:와인색
		//trace ("data.typeIcon = " +data.typeIcon)
		if (data.typeIcon == undefined || data.typeIcon == "0" || data.typeIcon == "") {
			typeIcon.gotoAndStop(1);
		} else {
			typeIcon.gotoAndStop(Number(data.typeIcon)+1);
		}

		if (data.Flag == "0") {
			trace ("xxxxx1");
			this.disabled = false
			setVisible(true);

			textField0.text = data.No;
			textField1.text = data.ChannelName;
			textField2.text = "";

			//faceIcon.gotoAndStop(1);
			setGaugeValue(Number(data.StatBarNo),Number(data.FullGauge));
			mc_select_over._visible=true
		}
		
		else if (data.Flag == "1") {
			trace ("xxxxx2");
			this.disabled  = true;
			setVisible(true);
			//faceIcon.gotoAndStop(2);
			setGaugeValue(Number(-1),Number(data.FullGauge));
			textField0.text = data.No;
			textField1.text = data.ChannelName;
			textField2.text = "";
			mc_select_over._visible=true
		}
		
		else if (data.Flag == "2") {
			trace ("xxxxx3");
			this.disabled = true;
			trace("flag = "+this._name);
			setVisible(false);
			textField2.text = data.ChannelName;
			frendViewMC._visible = false;
			mc_select_over._visible=false
		}
		

		if (data.ClanFrendLength == undefined && data.FrendLength == undefined) {
			frendViewMC._visible = false;
		} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
			frendViewMC._visible = false;
		} else {
			frendViewMC._x = 344;
			frendViewMC._visible = true;

			if (data.ClanFrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt1.text = data.ClanFrendLength
			}
			if (data.FrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt1.text = data.FrendLength
			}
			if (data.ClanFrendLength != "" && data.FrendLength != "") {
				frendViewMC.gotoAndStop(2);
				frendViewMC.txt1.text = data.ClanFrendLength
				frendViewMC.txt3.text = data.FrendLength
				frendViewMC._x = 307;
			} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
				frendViewMC._visible = false;
			}
		}
	}
	private function updateAfterStateChange():Void {
		
		
		
		if (data.typeIcon == undefined || data.typeIcon == "0" || data.typeIcon == "") {
			typeIcon.gotoAndStop(1);
		} else {
			typeIcon.gotoAndStop(Number(data.typeIcon)+1);
		}

		if (data.Flag == "0") {
			trace ("xxxxx1");
			this.disabled = false
			setVisible(true);

			textField0.text = data.No;
			textField1.text = data.ChannelName;
			textField2.text = "";

			//faceIcon.gotoAndStop(1);
			setGaugeValue(Number(data.StatBarNo),Number(data.FullGauge));
			mc_select_over._visible=true
		}
		
		else if (data.Flag == "1") {
			trace ("xxxxx2");
			this.disabled  = true;
			setVisible(true);
			//faceIcon.gotoAndStop(2);
			setGaugeValue(Number(-1),Number(data.FullGauge));
			textField0.text = data.No;
			textField1.text = data.ChannelName;
			textField2.text = "";
			mc_select_over._visible=true
		}
		
		else if (data.Flag == "2") {
			trace ("xxxxx3");
			this.disabled = true;
			trace("flag = "+this._name);
			setVisible(false);
			textField2.text = data.ChannelName;
			frendViewMC._visible = false;
			mc_select_over._visible=false
		}
		

		if (data.ClanFrendLength == undefined && data.FrendLength == undefined) {
			frendViewMC._visible = false;
		} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
			frendViewMC._visible = false;
		} else {
			frendViewMC._x = 344;
			frendViewMC._visible = true;

			if (data.ClanFrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt1.text = data.ClanFrendLength
			}
			if (data.FrendLength != "") {
				frendViewMC.gotoAndStop(1);
				frendViewMC.txt1.text = data.FrendLength
			}
			if (data.ClanFrendLength != "" && data.FrendLength != "") {
				frendViewMC.gotoAndStop(2);
				frendViewMC.txt1.text = data.ClanFrendLength
				frendViewMC.txt3.text = data.FrendLength
				frendViewMC._x = 307;
			} else if (data.ClanFrendLength == "" && data.FrendLength == "") {
				frendViewMC._visible = false;
			}
		}
	}


	private function setVisible(boo:Boolean):Void {
		bg._visible = boo;
		typeIcon._visible = boo;
		//faceIcon._visible = boo;
		gaugeBar._visible = boo;
		textField0._visible = boo;
		textField1._visible = boo;
	}

	private function setGaugeValue(no:Number, full:Number):Void {		
		if (no>=0) {			
			gaugeBar.gotoAndStop(1);
			var tWid = (65/100)*no;
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