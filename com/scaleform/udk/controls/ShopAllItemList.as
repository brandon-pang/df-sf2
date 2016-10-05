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
import gfx.controls.CheckBox;
import gfx.controls.DropdownMenu;


[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ShopAllItemList extends ListItemRenderer
{
	private var modeIcon:MovieClip;
	private var txtName:TextField;

	private var shopall_icons:MovieClip;

	private var checkBox:CheckBox;
	private var dropList:DropdownMenu;

	private var typeIcons:MovieClip;// sp냐 cash 냐 구분
	private var blockIcon:MovieClip;// 계급별 구입불가 
	private var NewRankTg:MovieClip;// 계급로드 타겟
	private var armorTg:MovieClip;//장비로드 타겟
	
	private var _txt:String;
	private var _imgPath:String;
	private var _enable:String;
	private var _armorImg:String;//장비경로
	private var _classImg:String;//계급값
	private var _limited:String;//구입제한
	private var _buyType:String;//케시냐sp냐
	private var _check:String;
	private var _SelectedDay:Number;
	
	private var remainderMC:MovieClip;//남은기간표시
	
	//private var bonusSpMC:MovieClip;//추가 sp
	
	private var addspIcon:MovieClip;//추가sp 아이콘
	
	
	private var _imgPathArmor:String="gamedir://\\FlashMovie\\image\\imgset\\gfx_imgset_armor.swf"
	private var _imgPathClass:String="gamedir://\\FlashMovie\\image\\imgset\\imgset_class.swf"
	
	//private var _dataProvider:DataProvider;




	public function ShopAllItemList ()
	{
		super ();
	}

	public function setData (data:Object):Void
	{
		trace (data.toString ());
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;
		super.setData (data);
		trace ("ArmorImg" + data.ArmorImg);
		trace ("ClassImg" + data.ClassImg);
		trace ("Limited" + data.Limited);
		trace ("BuyType" + data.BuyType);
		trace ("Chk" + data.Chk);
		trace ("dataProvider" + data.dataProvider);

		_armorImg = data.ArmorImg;
		_classImg = data.ClassImg;
		_limited = data.Limited;
		_buyType = data.BuyType;
		_check = data.Chk;
		
		_SelectedDay = data.SelectedDay;


		//_dataProvider = data.DataProvider;
		dropList.dataProvider = data.dataProvider;
		if(_SelectedDay){
			dropList.selectedIndex = _SelectedDay;
		}
		//6글자 이상이면 ... 으로
		if(data.WeaponName.length > 7){
			checkBox.label = data.WeaponName.substring(0,7);
			checkBox.label += "...";
		}else{
			checkBox.label = data.WeaponName;
		}
		

		//trace(this.index); 배경아이콘 프레임 설정
		shopall_icons.gotoAndStop (Number (this.index) + 1);


		//데이타가 모두 공백이면 배경을 제외한 나머지 안보이게
		if (data.ArmorImg == "" && data.ClassImg == "" && data.Limited == "" && data.BuyType == "" && data.Chk == "")
		{
			blockIcon._visible = false;
			NewRankTg._visible = false;
			typeIcons._visible = false;
			checkBox._visible = false;
			armorTg._visible = false;

		}
		else
		{

			blockIcon._visible = true;
			NewRankTg._visible = true;
			typeIcons._visible = true;
			checkBox._visible = true;
			armorTg._visible = true;
		}

		//장비나 무기가 있다면 이미지 불러오기
		if (_armorImg != "")
		{
			lvLoader ("armor");
			shopall_icons._visible = false;
		}
		else
		{
			shopall_icons._visible = true;
		}
		/*//체크박스에 값이 있으면 선택체크 없으면 해제 
		if (data.Chk == "1")
		{
		checkBox.selected = true;
		}
		else
		{
		checkBox.selected = false;
		}*/
		//캐시 또는 SP 구분하기
		if (_buyType == "1")
		{
			typeIcons.gotoAndStop (2);
		}
		else
		{
			typeIcons.gotoAndStop (1);
		}

		//구입가능 여부 체크 구입할수 있다면 블럭 
		if (_limited == "1")
		{
			if (_armorImg != "")
			{
				lvLoader ("armor");
			}
			armorTg._visible = true;
			
			blockIcon._visible = true;
			NewRankTg._visible = true;
			//계급불러오기
			if (_classImg != "" && _classImg != "0000")
			{
				lvLoader ("class");
			}
			
			//------------------------체크박스 , 리스트 버튼 못누르게

			checkBox.disabled = true;
			dropList.disabled = true;

		}
		else
		{
			NewRankTg._visible = false;
			checkBox.selected = false;
			blockIcon._visible = false;
			checkBox.disabled = false;
			dropList.disabled = false;
			


		}

		//체크박스에 값이 있으면 선택체크 없으면 해제 
		if (data.Chk == "1")
		{
			checkBox.selected = true;
		}
		else
		{
			checkBox.selected = false;
		}
		
		//남은 기간 표시		
		//remainderMC.textField.text = "1일 남음"
		//remainderMC.gotoAndStop(2);		
		remainderMC._visible = false;
		if(data.remainderDayText != "" && data.remainderDayText != undefined){			
			remainderMC._visible = true;
			remainderMC.textField.text = data.remainderDayText;			
			if(data.remainderDayBg == 0){
				remainderMC.gotoAndStop(1);
			}else{
				remainderMC.gotoAndStop(2);
			}
		}
		
		//------------------------------------------ 추가 sp
		if(data.BonusSP == "1"){
			addspIcon._visible = true;
		}else{
			addspIcon._visible = false;
		}

	}

	private function updateAfterStateChange ():Void
	{
		if (!initialized)
		{
			return;
		}
		validateNow ();

		if (constraints != null)
		{
			constraints.update (width,height);
		}
		dispatchEvent ({type:"stateChange", state:state});
	}

	private function lvLoader (caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);



		if (caseBy == "armor")
		{
			//mcLoader.unloadClip (NewRankTg);
			mcLoader.loadClip (_imgPathArmor,armorTg);
			
		}
		if (caseBy == "class")
		{
			//mcLoader.unloadClip (armorTg);
			mcLoader.loadClip (_imgPathClass,NewRankTg);
		}

	}


	private function onLoadInit (mc:MovieClip)
	{
		if (mc._name == "armorTg")
		{
			armorTg._xscale = 84;
			armorTg._yscale = 84;
			armorTg.gotoAndStop (_armorImg);
			//trace (_armorImg);
		}



		if (mc._name == "NewRankTg")
		{
			var lvNo;
			lvNo = _classImg;

			var KD:String = lvNo.charAt (0);
			var LV:String = lvNo.charAt (1);
			var chkCl:String = lvNo.substr (2, 3);
			var CL:String;
			if (chkCl.charAt (0) == "0")
			{
				CL = chkCl.charAt (1);
			}
			else
			{
				CL = chkCl;
			}
			var rIndex1:Number;
			var rIndex2:Number;
			rIndex1 = Number (CL) + 1;
			rIndex2 = Number (LV) + 1;
			NewRankTg.lv0.gotoAndStop (rIndex1);
			NewRankTg.lv1.gotoAndStop (rIndex2);

			trace ("NewRankTg---1--" + CL);
			trace ("NewRankTg---2--" + LV);
			trace ("NewRankTg---frame--" + NewRankTg.lv0._currentframe);
			trace ("NewRankTg---frame--" + NewRankTg.lv1._currentframe);
			trace ("NewRankTg---frame--" + NewRankTg.lv0._name + " = " + rIndex1);
			trace ("NewRankTg---frame--" + NewRankTg.lv1._name + " = " + rIndex2);
		}
	}
	private function configUI ():Void
	{

		constraints = new Constraints (this, true);

		if (!_disableConstraints)
		{
			constraints.addElement (textField,Constraints.ALL);
		}

		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		//_hit.onRollOver = Delegate.create(this, handleMouseRollOver);     
		//_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		//_hit.onPress = Delegate.create(this, handleMousePress);
		//_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.onDragOver = Delegate.create(this, handleDragOver);
		//_hit.onDragOut = Delegate.create(this, handleDragOut);
		//_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

		//btnAddFriend.addEventListener("click",this,"onClickButton");
		checkBox.addEventListener ("select",this,"onCheckClick");
		dropList.addEventListener ("select",this,"onDropDownChg");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}

	public function handleInput (details:InputDetails, pathToFocus:Array):Boolean
	{
		var nextItem:MovieClip = MovieClip (pathToFocus.shift ());

		var handled:Boolean;
		if (nextItem != null)
		{
			handled = nextItem.handleInput (details, pathToFocus);
			if (handled)
			{
				return true;
			}
		}

		if (details.navEquivalent == "enter")
		{
			handled = false;
			if (handled)
			{
				return true;
			}
		}

		if (details.navEquivalent == "left")
		{
			handled = false;
			if (handled)
			{
				return true;
			}
		}
		return false;// or true if handled
	}

	public function draw ()
	{
		super.draw ();
	}

	public function onCheckClick (e:Object):Void
	{
		//trace("e.target._name:  " + e.target._parent._name);

		trace ("------------------  " + e.target._parent._name.substring (4));
		trace ("===============  " + e.target.selected);

		_global.onShopAllItemCheckBtnPress (e.target._parent._name.substring (4),e.target.selected);//

	}
	public function onDropDownChg (e:Object):Void
	{
		//trace("e.target._name:  " + e.target.selectedIndex);
		//trace("p_event.target._name:  " + _root.listArray[1]);
		_global.onShopAllItemDropDownBtnPress (this.index,e.target.selectedIndex);

	}

	private function handleMouseRollOver (mouseIndex:Number, button:Number):Void
	{
		setState ("over");
	}
	private function handleMouseRollOut (mouseIndex:Number, button:Number):Void
	{
		setState ("out");
	}
	private function handleMousePress (mouseIndex:Number, button:Number):Void
	{
		setState ("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent ({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease (mouseIndex:Number, button:Number):Void
	{
		setState ("release");
		handleClick (mouseIndex,button);
	}

}