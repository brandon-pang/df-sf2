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
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.controls.CheckBox;
[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.EventCheckListItem extends ListItemRenderer {

	private var urlPath:String = "";
	private var imgPathUnit:String = urlPath+"gfx_imgset_unitbox.swf";
	private var checkBox:MovieClip;
	private var imgTg1:MovieClip;
	private var imgTg2:MovieClip;
	private var imgTg3:MovieClip;
	private var imgTg4:MovieClip;
	private var imgTg1_1:MovieClip;
	private var imgTg2_2:MovieClip;
	private var imgTg3_3:MovieClip;
	private var imgTg4_4:MovieClip;
	private var _ImageURL1:String;
	private var _ImageURL2:String;
	private var _open:String;
	private var coverMask:MovieClip;
	private var coverMC:MovieClip;
	private var dayTxt:TextField;
	private var txt1:TextField;
	private var txt1_1:TextField;
	private var questionMC1:MovieClip;
	private var questionMC2:MovieClip;
	private var openMC:MovieClip;
	private var stempMC:MovieClip;
	private var bgMC:MovieClip;
	private var _itemIndex:String;
	private var _dayTxt:String;
	private var _Background:Number;
	private var _ImageView1:String;
	private var _ImageView2:String;
	private var _indexLoad1:String;
	private var _indexLoad2:String;
	private var _content1:String;
	private var _content2:String;
	private var numberMC:MovieClip;
	private var goalMC:MovieClip;
	private var _Last:String;
	private var mc1:MovieClip;
	private var mc2:MovieClip;
	private var intervalId1:Number;
	private var intervalId2:Number;
	private var intervalId3:Number;
	private var _loagImg:Number;
	private var _chk:Boolean = false;
	private var tx1:Number;
	private var tx2:Number;

	public function EventCheckListItem() {
		super();
	}
	// 기존 정보 초기화
	private function reSet() {
		openMC._visible = false;
		stempMC._visible = false;
		questionMC1._visible = false;
		questionMC2._visible = false;
		clearInterval(intervalId1);
		clearInterval(intervalId2);
		clearInterval(intervalId3);
		_loagImg = 0;
		stempMC.swapDepths(1000);
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		//아이탬 1개일때, 2개일때, 아이탬을 ? 로 표시할때
		dayTxt.text = "";
		txt1.text = "";
		txt1_1.text = "";
		_dayTxt = data.Day;
		_open = data.ItemOpen;
		_ImageURL1 = data.IconImg1;
		_ImageURL2 = data.IconImg2;
		_ImageView1 = data.ImageView1;
		_ImageView2 = data.ImageView2;
		_indexLoad1 = data.ImgSet1;
		_indexLoad2 = data.ImgSet2;
		_content1 = data.Content1;
		_content2 = data.Content2;
		_Last = data.LastImage;
		_Background = Number(this._parent._parent._parent._id)%2;
		UpdateTextFields();
	}
	
	private function lvLoader(n:String) {
		var urlPath:String = "img://Imgset_";
		var imgPathArmor:String = urlPath+"Armor."+_ImageURL1;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var len = _ImageURL1.length;
		var chk = _ImageURL1.substr(-4, len);
		if (chk == "_ani") {
			imgPathCashItem = "CashItem_Ani/"+_ImageURL1+".swf";
			imgPathWeapon = "Weapon_Ani/"+_ImageURL1+".swf";
		} else {
			imgPathCashItem = urlPath+"CashItem."+_ImageURL1
			imgPathWeapon = urlPath+"Weapon."+_ImageURL1
		}

		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.unloadClip(imgTg1);
		mcLoader.unloadClip(imgTg2);
		mcLoader.unloadClip(imgTg3);
		mcLoader.unloadClip(imgTg4);

		if (n == "0") {
			mcLoader.loadClip(imgPathArmor,imgTg1);
		} else if (n == "1") {
			mcLoader.loadClip(imgPathWeapon,imgTg2);
		} else if (n == "2") {
			mcLoader.loadClip(imgPathUnit,imgTg3);
		} else if (n == "3") {
			mcLoader.loadClip(imgPathCashItem,imgTg4);
		}
	}

	private function lvLoader2(n:String) {
		var urlPath:String = "img://Imgset_";
		var imgPathArmor:String = urlPath+"Armor."+_ImageURL2;
		var imgPathWeapon:String;
		var imgPathCashItem:String;
		var len = _ImageURL2.length;
		var chk = _ImageURL2.substr(-4, len);
		if (chk == "_ani") {
			imgPathCashItem = "CashItem_Ani/"+_ImageURL2+".swf";
			imgPathWeapon = "Weapon_Ani/"+_ImageURL2+".swf";
		} else {
			imgPathCashItem = urlPath+"CashItem."+_ImageURL2;
			imgPathWeapon = urlPath+"Weapon."+_ImageURL2;
		}

		var mcLoader2:MovieClipLoader = new MovieClipLoader();
		mcLoader2.addListener(this);
		mcLoader2.unloadClip(imgTg1_1);
		mcLoader2.unloadClip(imgTg2_2);
		mcLoader2.unloadClip(imgTg3_3);
		mcLoader2.unloadClip(imgTg4_4);
		imgTg1_1._alpha = 0;
		imgTg2_2._alpha = 0;
		imgTg3_3._alpha = 0;
		imgTg4_4._alpha = 0;

		if (n == "0") {
			mcLoader2.loadClip(imgPathArmor,imgTg1_1);
		} else if (n == "1") {
			mcLoader2.loadClip(imgPathWeapon,imgTg2_2);
		} else if (n == "2") {
			mcLoader2.loadClip(imgPathUnit,imgTg3_3);
		} else if (n == "3") {
			mcLoader2.loadClip(imgPathCashItem,imgTg4_4);
		}
	}

	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "imgTg1") {
			imgTg1._xscale = 80;
			imgTg1._yscale = 80;
		} else if (mc._name == "imgTg2") {
			imgTg2._xscale = 60;
			imgTg2._yscale = 60;
			imgTg2._x = -26;
			imgTg2._y = 12;
		} else if (mc._name == "imgTg3") {
			imgTg3.gotoAndStop(_ImageURL1);
			imgTg3.img.gotoAndStop(3);
			imgTg3._xscale = 90;
			imgTg3._yscale = 90;
		} else if (mc._name == "imgTg4") {
			imgTg4._xscale = 65;
			imgTg4._yscale = 65;
		} else if (mc._name == "imgTg1_1") {
			imgTg1_1._xscale = 80;
			imgTg1_1._yscale = 80;
		} else if (mc._name == "imgTg2_2") {
			imgTg2_2._xscale = 60;
			imgTg2_2._yscale = 60;
			imgTg2_2._x = -26;
			imgTg2_2._y = 12;
		} else if (mc._name == "imgTg3_3") {
			imgTg3_3.gotoAndStop(_ImageURL2);
			imgTg3_3.img.gotoAndStop(3);
			imgTg3_3._xscale = 90;
			imgTg3_3._yscale = 90;
		} else if (mc._name == "imgTg4_4") {
			imgTg4_4._xscale = 65;
			imgTg4_4._yscale = 65;
		}
		//감춰야 되는 이미지 감추고 ? 를 보이기 
		if (_ImageView1 == "0" && _ImageView2 == "1") {
			mc1._visible = false;
			mc2._visible = true;
			txt1._visible = false;
			txt1_1._visible = true;
			questionMC1._visible = true;
			questionMC2._visible = false;
		} else if (_ImageView1 == "1" && _ImageView2 == "0") {
			mc1._visible = true;
			mc2._visible = false;
			txt1._visible = true;
			txt1_1._visible = false;
			questionMC1._visible = false;
			questionMC2._visible = true;
		} else if (_ImageView1 == "1" && _ImageView2 == "1") {
			mc1._visible = true;
			mc2._visible = true;
			txt1._visible = true;
			txt1_1._visible = false;
			questionMC1._visible = false;
			questionMC2._visible = false;
		}
		//이미지 2개 로드됬다면 
		if (_loagImg == 2) {
			changeImageView1();
			numberMC._visible = true;

		} else if (_loagImg == 1) {
			numberMC._visible = false;
			if (_ImageView1 == "0") {
				mc1._visible = false;
				mc2._visible = false;
				txt1._visible = false;
				txt1_1._visible = false;
				questionMC1._visible = true;
				questionMC2._visible = false;
			} else {
				questionMC1._visible = false;
				questionMC2._visible = false;
			}
		}
	}

	private function changeImageView1() {
		clearInterval(intervalId2);
		if (_ImageView1 == "1" && _ImageView2 == "1") {
			TweenMax.to(mc1,1,{_x:(tx1-10), _alpha:0, ease:Cubic.easeIn});
			TweenMax.to(mc2,1,{_x:(tx2), _alpha:100, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete1)});
		} else if (_ImageView1 == "0" && _ImageView2 == "1") {
			questionMC2._visible = false;
			TweenMax.to(questionMC1,1,{_x:23, _alpha:100, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete1)});
			TweenMax.to(mc2,1,{_x:(tx2-10), _alpha:0, ease:Cubic.easeIn});
		} else if (_ImageView1 == "1" && _ImageView2 == "0") {
			questionMC1._visible = false;
			TweenMax.to(questionMC2,1,{_x:13, _alpha:0, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete1)});
			TweenMax.to(mc1,1,{_x:(tx1), _alpha:100, ease:Cubic.easeIn});
		}

	}
	private function onAlphaComplete1():Void {

		if (_ImageView1 == "0" && _ImageView2 == "1") {
			txt1._visible = false;
			txt1_1._visible = false;
		} else if (_ImageView1 == "1" && _ImageView2 == "0") {
			txt1._visible = true;
			txt1_1._visible = false;
		} else if (_ImageView1 == "1" && _ImageView2 == "1") {
			txt1._visible = false;
			txt1_1._visible = true;//
		}
		intervalId1 = setInterval(this, "changeImageView2", 3000);
	}

	private function changeImageView2() {
		clearInterval(intervalId1);
		if (_ImageView1 == "1" && _ImageView2 == "1") {
			TweenMax.to(mc1,1,{_x:(tx1), _alpha:100, ease:Cubic.easeIn});
			TweenMax.to(mc2,1,{_x:(tx2-10), _alpha:0, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete2)});
		} else if (_ImageView1 == "0" && _ImageView2 == "1") {
			questionMC2._visible = false;
			TweenMax.to(questionMC1,1,{_x:13, _alpha:0, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete2)});
			TweenMax.to(mc2,1,{_x:(tx2), _alpha:100, ease:Cubic.easeIn});

		} else if (_ImageView1 == "1" && _ImageView2 == "0") {
			questionMC1._visible = false;
			TweenMax.to(questionMC2,1,{_x:23, _alpha:100, ease:Cubic.easeIn, onComplete:Delegate.create(this, onAlphaComplete2)});
			TweenMax.to(mc1,1,{_x:(tx1-10), _alpha:0, ease:Cubic.easeIn});
		}

	}

	private function onAlphaComplete2():Void {

		if (_ImageView1 == "0" && _ImageView2 == "1") {
			txt1._visible = false;
			txt1_1._visible = true;
		} else if (_ImageView1 == "1" && _ImageView2 == "0") {
			txt1._visible = false;
			txt1_1._visible = false;
		} else if (_ImageView1 == "1" && _ImageView2 == "1") {
			txt1._visible = true;
			txt1_1._visible = false;
		}
		intervalId2 = setInterval(this, "changeImageView1", 3000);
	}

	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}
		UpdateTextFields();
		dispatchEvent({type:"stateChange", state:state});
	}
	private function UpdateTextFields() {

		reSet();
		//타이틀
		dayTxt.text = _dayTxt;
		//라인 마다 다른 배경
		if (_Background == 0) {
			bgMC.gotoAndStop(1);
		} else if (_Background == 1) {
			bgMC.gotoAndStop(3);
		}
		// 지난 아이탬, 현재 아이템, 다음 아이템, 미래 아이템 
		if (_open == "0") {
			openMC._visible = true;
			stempMC._visible = true;
			openMC.gotoAndStop(2);
			stempMC.gotoAndStop(2);
			stempMC.mc.gotoAndStop(30);//----- 모션종료상태
			coverMask.gotoAndStop(30);
			if (_Background == 0) {
				bgMC.gotoAndStop(2);
			} else if (_Background == 1) {
				bgMC.gotoAndStop(4);
			}
			questionMC1._visible = false;
			questionMC2._visible = false;
		} else if (_open == "1") {
			openMC._visible = true;
			stempMC._visible = true;
			openMC.gotoAndStop(1);
			stempMC.gotoAndStop(1);
			stempMC.mc.gotoAndPlay(2);//-------- 모션보이기
			coverMask.gotoAndStop(30);
			questionMC1._visible = false;
			questionMC2._visible = false;
		} else if (_open == "2") {
			openMC._visible = false;
			stempMC._visible = false;
			coverMask.gotoAndStop(1);
			questionMC1._visible = true;
			questionMC2._visible = false;
		}
		//마지막 이미지 
		if (_Last == "1") {
			goalMC._visible = true;
		} else {
			goalMC._visible = false;
		}

		//이미지 하나만 로드
		if (_open != "0" && _ImageURL1 == "" || _ImageURL1 != undefined || _ImageURL2 == "" || _ImageURL2 != undefined) {
			numberMC._visible = false;
		}


		if (_ImageURL1 != "" && _ImageURL1 != undefined) {

			//장비, 무기, 부대, 캐시
			if (_indexLoad1 == "0") {
				mc1 = imgTg1;
			} else if (_indexLoad1 == "1") {
				mc1 = imgTg2;
			} else if (_indexLoad1 == "2") {
				mc1 = imgTg3;
			} else if (_indexLoad1 == "3") {
				mc1 = imgTg4;
			}
			tx1 = mc1._x;
			lvLoader(_indexLoad1);

			// 캐시아이탬일때만 노멀폰트에서 보이기
			txt1.text = _content1;
			_loagImg = 1;
		}
		//두번째 이미지 로드 
		if (_ImageURL2 != "" && _ImageURL2 != undefined) {
			//장비, 무기, 부대, 캐시
			if (_indexLoad2 == "0") {
				mc2 = imgTg1_1;
			} else if (_indexLoad2 == "1") {
				mc2 = imgTg2_2;
			} else if (_indexLoad2 == "2") {
				mc2 = imgTg3_3;
			} else if (_indexLoad2 == "3") {
				mc2 = imgTg4_4;
			}
			tx2 = mc2._x;
			lvLoader2(_indexLoad2);
			// 캐시아이탬일때만 노멀폰트에서 보이기
			//물음표가 있을때는 안보이기
			txt1_1.text = _content2;
			_loagImg = 2;
		}
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
		focusTarget = owner;
		checkBox.addEventListener("press",this,"onChkHandler");
		checkBox.addEventListener("releaseOutside",this,"onChkReleaseOutside");
	}

	private function onChkHandler(e:Object) {
		if (_open == "1" && _chk == false) {
			_chk = true;
			var _id:Number = this._parent._parent._parent._id;
			var _index:Number = this.index;
			_global.OnEventItemChkData(_id,_index);
		}
	}

	private function onChkReleaseOutside(e:Object) {
		//
	}

	public function draw() {
		super.draw();
	}
}