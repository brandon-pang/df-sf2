/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import flash.external.ExternalInterface;
[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.GetTpListItem extends ListItemRenderer {
     
	private var cashBtn:MovieClip; //캐시버튼
	private var tpItemPriceMC:MovieClip; //티비아이콘
	private var tpEventMC:MovieClip; //이벤트
	private var btnNameMC:MovieClip; //이름
	private var priceMC:MovieClip; //가격
	
	public function GetTpListItem() {
		super();
	}

	public function setData(data:Object):Void {

		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		//tp 가격
		//_root.LanguageIndex
		tpItemPriceMC["moneyIcon"].gotoAndStop(_root.LanguageIndex)
		tpItemPriceMC["moneyCI"].gotoAndStop(_root.LanguageIndex)
		
		tpItemPriceMC.textField.text = data.TP;		
		//이벤트 가격
		if(data.EventTP != "" && data.EventTP != undefined) {
			tpEventMC._visible = true;
			tpEventMC.textField.text = data.EventTP;
		}else{
			tpEventMC._visible = false;
		}
		//캐시 가격
		priceMC.textField.text = data.Cash;		
		btnNameMC.textField.text = "_simplebuy_buy";		
		//선택유무
		if(data.SelectOn == "1"){			
			btnNameMC._visible = true;
			priceMC._visible = false;
			cashBtn.selected=true			
		}else if(data.SelectOn == "0"){			
			btnNameMC._visible = false;
			priceMC._visible = true;
			cashBtn.selected=false
			cashBtn.setState("up");
		}			
	}	
	
	private function updateAfterStateChange():Void {		
		if (!initialized) {
			return;
		}
		//선택유무만 업데이트함
		if(data.SelectOn == "1"){			
			btnNameMC._visible = true;
			priceMC._visible = false;
			cashBtn.selected=true			
		}else if(data.SelectOn == "0"){			
			btnNameMC._visible = false;
			priceMC._visible = true;
			cashBtn.selected=false
			cashBtn.setState("up");
		}		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void {
		super.configUI();
		delete onRollOver;
		delete onRollOut;
		delete onPress;
		delete onRelease;
		delete onReleaseOutside;
		delete onDragOver;
		delete onDragOut;		
		cashBtn.addEventListener ("click",this,"onClickButton");
		cashBtn.addEventListener ("releaseOutside",this,"onOutButton");
		focusTarget = owner;
	}
	
	private function onClickButton (e:Object):Void
	{
		_global.OnTPExchangeBuyBtnClick(this.index);
	}
	
	private function onOutButton (e:Object):Void
	{
		cashBtn.setState("up");
	}
	
	public function draw() {
		super.draw();
	}

}