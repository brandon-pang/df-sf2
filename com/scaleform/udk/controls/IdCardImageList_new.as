/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.Button;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.IdCardImageList_new extends ListItemRenderer
{

	private var imgTg:MovieClip;//이미지로드타겟
	private var imgTg2:MovieClip;//스프레이통
	private var imgItemBtn:MovieClip;//
	private var _infoImg:Number;
	private var _cardHitBtn:MovieClip;
	private var _AlarmDay:String;
	private var selectMC:MovieClip;
	private var _PCIndex:String;
	private var _bAvailable:Boolean;
	private var buyBtn:MovieClip;
	private var useBtn:MovieClip;
	private var txtDayBg:MovieClip;
	private var _NotUsed:String;
	private var _Buy:String;
	private var _EmblemType:String;
	private var _ToolTip:String;
	private var emptyItem:MovieClip;
	private var _tooltipView:Boolean;

	public function IdCardImageList_new()
	{
		super();
		
	}

	public function setData(data:Object):Void
	{
		//----------------------------- 기본 빈슬롯 보이기
		if (data == undefined)
		{
			emptyItem._visible = true;
			selectMC._visible = false;
			imgTg._visible = false;
			imgTg2._visible = false;
			useBtn._visible = false;
			buyBtn._visible = false;
			_tooltipView = false;
			_bAvailable = false;			
			return;
		}
		this.data = data;		
		
		selectMC._visible = false;
		emptyItem._visible = false;
		_tooltipView = true;
		_infoImg = data.IdCardImgs;//이미지 프레임 번호
		lvLoaderCard();
		if (data.Chk == "1")
		{
			selectMC._visible = true;
		}
		else
		{
			selectMC._visible = false;
		}
		//중국용 고급 피시방 구분 (선택태두리 색상적용)
		_PCIndex = data.PCIndex;
		if (_PCIndex != "" && _PCIndex != undefined)
		{
			selectMC.gotoAndStop(_PCIndex);
		}
		else
		{
			selectMC.gotoAndStop(1);
		}
		//아이탬 활성, 비활성 설정 변수
		_bAvailable = data.bAvailable;
		if (!_bAvailable)
		{
			imgTg._alpha = 40;
			imgTg2._alpha = 40;
		}
		else
		{
			imgTg._alpha = 100;
			imgTg2._alpha = 100;
		}
		//아이템 사용가능여부
		_NotUsed = data.NotUsed;
		useBtn._visible = false;
		buyBtn._visible = false;
		//구입버튼 노출
		_Buy = data.Buy;
		_AlarmDay = data.AlarmDay;
		//아이템 사용기간 3일 이하일 경우 표시
		if (data.AlarmDay == "1")
		{
			txtDayBg._visible = true;
			txtDayBg.dayNo.text = data.Day;
			txtDayBg.gotoAndStop(3);
		}
		else
		{
			txtDayBg._visible = false;
		}
		_EmblemType = data.EmblemType;
		_ToolTip = data.ToolTip;
	}

	private function lvLoaderCard()
	{
		var _imgPathPerSmall:String;
		//var _imgPathwallSpray = "gfx_imgset_cashItem_wallSpray.swf";

		var mcLoaderCard:MovieClipLoader = new MovieClipLoader();
		mcLoaderCard.addListener(this);

		var rank:String = data.IdCardImgs.charAt(0);

		if (data.IdCardImgs.charAt(0) == "#")
		{
			_imgPathPerSmall = "gfx_imgset_clanMark.swf";
		}
		else if (data.IdCardImgs.charAt(3) == ":")
		{
			_imgPathPerSmall = data.IdCardImgs;
		}
		else
		{
			_imgPathPerSmall = "img://Imgset_Personal." + data.IdCardImgs;
		}

		mcLoaderCard.loadClip(_imgPathPerSmall,imgTg);
		//mcLoaderCard.loadClip(_imgPathwallSpray,imgTg2);


	}

	private function onLoadInit(mc:MovieClip)
	{
		//모션실행
		if (data.IdCardImgs.charAt(0) == "#")
		{
			var cm = data.IdCardImgs;
			var sym:String = cm.substr(1, 5);
			var dec:String = cm.substr(6, 3);
			var back:String = cm.substr(9, 3);

			mc.symbolMc.setSymbolPic(sym);
			mc.decoMc.setDecoPic("D" + dec);
			mc.backMc.setBackPic("B" + back);
		}
		else
		{
			if(mc._name=="imgTg"){
				mc._width=mc._height=58
			}
		}
	}

	private function updateAfterStateChange():Void
	{
		if (data == undefined)
		{
			emptyItem._visible = true;
			selectMC._visible = false;
			imgTg._visible = false;
			imgTg2._visible = false;
			useBtn._visible = false;
			buyBtn._visible = false;
			_tooltipView = false;
			_bAvailable = false;			
			return;
		}
		_tooltipView = true;
		emptyItem._visible = false;
		_infoImg = data.IdCardImgs;//이미지 프레임 번호
		
		if (data.Chk == "1")
		{
			selectMC._visible = true;
		}
		else
		{
			selectMC._visible = false;
		}
		//중국용 고급 피시방 구분 (선택태두리 색상적용)
		_PCIndex = data.PCIndex;
		if (_PCIndex != "" && _PCIndex != undefined)
		{
			selectMC.gotoAndStop(_PCIndex);
		}
		else
		{
			selectMC.gotoAndStop(1);
		}
		//아이탬 활성, 비활성 설정 변수
		_bAvailable = data.bAvailable;
		if (!_bAvailable)
		{
			imgTg._alpha = 40;
			imgTg2._alpha = 40;
		}
		else
		{
			imgTg._alpha = 100;
			imgTg2._alpha = 100;
		}
		//아이템 사용가능여부
		_NotUsed = data.NotUsed;
		useBtn._visible = false;
		buyBtn._visible = false;
		//구입버튼 노출
		_Buy = data.Buy;
		_AlarmDay = data.AlarmDay;
		//아이템 사용기간 3일 이하일 경우 표시
		if (data.AlarmDay == "1")
		{
			txtDayBg._visible = true;
			txtDayBg.dayNo.text = data.Day;
			txtDayBg.gotoAndStop(3);
		}
		else
		{
			txtDayBg._visible = false;
		}
		_EmblemType = data.EmblemType;
		_ToolTip = data.ToolTip;
		
		// Redraw should only happen AFTER the initialization. 
		if (!initialized)
		{
			return;
		}
		validateNow();// Ensure that the width/height is up to date.


		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void
	{
		super.configUI();

		delete onRollOver;
		delete onRollOut;
		delete onPress;
		delete onRelease;
		delete onReleaseOutside;
		delete onDragOver;
		delete onDragOut;

		_cardHitBtn.onPress = Delegate.create(this, handleMousePress);
		_cardHitBtn.onRollOver = Delegate.create(this, handleMouseOver);
		_cardHitBtn.onRollOut = Delegate.create(this, handleMouseOut);
		_cardHitBtn.onReleaseOutside = Delegate.create(this, handleMouseOut);
		focusTarget = owner;

		useBtn._visible = false;
		buyBtn._visible = false;
	}

	private function draw()
	{
		super.draw();
	}

	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{

		//사용하기 버튼 있을때 
		if (_NotUsed != "0" && _NotUsed != undefined)
		{
			_global.OnEmblemItemUseBtnPress(this._parent._parent._parent._id,this.index);
		}
		else
		{
			//구입하기 버튼 있을때
			if (_Buy == "1")
			{
				_global.OnEmblemItemBuyBtnClick(this._parent._parent._parent._id,this.index);
			}
			else
			{
				//엠블럼 변경하기
				if (_bAvailable != false && _bAvailable != undefined && _bAvailable != null)
				{
					_global.onIdCardImgChangePress(this._parent._parent._parent._id,this.index);
				}
			}
		}
	}
	private function handleMouseOver(mouseIndex:Number, button:Number):Void
	{
		var arrowPoz:Object = {x:0, y:0};
		this.localToGlobal(arrowPoz);
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		
		if (_tooltipView == true)
		{
			if(_ToolTip==""||_ToolTip==null){
				
			}else{
				_level0.setSelectToolTipView(arrowPoz.x,arrowPoz.y,_EmblemType,_ToolTip);
			}
			
		}
		
		//-- 사용하기 버튼 노출유무    
		if (_NotUsed != "0" && _NotUsed != undefined)
		{
			useBtn._visible = true;
		}
		else
		{
			useBtn._visible = false;
		}
		//-- 구입버튼 노출유무
		if (_Buy != "0" && _Buy != undefined)
		{
			buyBtn._visible = true;
		}
		else
		{
			buyBtn._visible = false
		}
	}

	private function handleMouseOut(mouseIndex:Number, button:Number):Void
	{
		var _level0 = _parent._parent._parent._parent._parent._parent._parent._parent._parent._parent;
		if (_PCIndex != "" && _PCIndex != undefined)
		{
			_level0.setSelectToolTipHide();
		}
		//------- 도전과제, 스프레이 아이템에 툴팁노출    
		if (_EmblemType == "challenge" || _EmblemType == "spray" || _EmblemType == "vip")
		{
			_level0.setSelectToolTipHide();
		}
		buyBtn._visible = false;
		useBtn._visible = false;
	}

}