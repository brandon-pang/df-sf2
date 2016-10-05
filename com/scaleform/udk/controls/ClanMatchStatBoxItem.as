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
 class com.scaleform.udk.controls.ClanMatchStatBoxItem extends ListItemRenderer {	
 
	private var dot:MovieClip;
	private var dot_nobg:MovieClip;
	private var txt_subject_no:MovieClip;	
	private var txt_combatNote_subject:MovieClip;
	
	// Initialization:
	public function ClanMatchStatBoxItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined || data.No == "") {
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;
		
		//Stat = 1 게임중  // Stat=0 대기중
		if(data.Stat=="1"){
		   dot.gotoAndStop(2);
		   dot_nobg.gotoAndStop(2);		 
		   txt_subject_no.textColor=0xed0808

		}else{
		   dot.gotoAndStop(1);
		   dot_nobg.gotoAndStop(1);		 
           txt_subject_no.textColor=0x98ff06

		}
		txt_combatNote_subject.text = data.Subject;		
		txt_subject_no.text = data.Value;					
	}

	private function updateAfterStateChange():Void {
		//Stat = 1 게임중  // Stat=0 대기중
		if(data.Stat=="1"){
		   dot.gotoAndStop(2);
		   dot_nobg.gotoAndStop(2);		 
		   txt_subject_no.textColor=0xed0808

		}else{
		   dot.gotoAndStop(1);
		   dot_nobg.gotoAndStop(1);		 
           txt_subject_no.textColor=0x98ff06

		}
		txt_combatNote_subject.text = data.Subject;		
		txt_subject_no.text = data.Value;					
	}	
}