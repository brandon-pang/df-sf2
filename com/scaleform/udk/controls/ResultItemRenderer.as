import gfx.controls.Button;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.motion.Tween;
import mx.transitions.easing.*;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import com.scaleform.udk.utils.UDKUtils;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ResultItemRenderer extends ListItemRenderer
{
	private var classicon:MovieClip;
	private var bg:MovieClip;
	private var numbericon:MovieClip;
	private var codename:TextField;
	private var score:TextField;
	private var killsetTxt:TextField;
	private var Bonus:TextField;
	private var exp:TextField;
	private var btnAddFriend:Button;
	private var _mechk:String;
	private var _classicon:String;
	private var _codename:String;
	private var _score:String;
	private var _kill:String;
	private var _assist:String;
	private var _death:String;
	private var _exp:String;
	private var _addbtn:String;
	private var _Bonus:String;
	private var _hit:MovieClip;
	private var _toolTipAni:MovieClip;
	private var pcroomIcon:MovieClip;
	private var eventIcon:MovieClip;
	private var expIcon:MovieClip;
	private var spUpIcon:MovieClip;
	private var starMc:MovieClip;
	private var clanImg:MovieClip;
	private var _clanImg:String;
	private var iconTxArr:Array = [394, 427, 451, 477];
	
	private var urlPath = "";	
	//private var urlPath = "gfxImgSet/";
	
	private var imgClanMarkSmallPath:String = urlPath + "gfx_imgset_clanMark_small.swf";
	private var imgPathClass:String = urlPath + "imgset_class.swf";
	private var clanmarkChk:String;
	private var mcLoader:MovieClipLoader;
	
	private var vipIcon:MovieClip;
	private var _vip:String;
	private var switchFlag:Boolean = true;
	public var intervalId:Number;
	private var _vipTime:String;

	private var clanEff:MovieClip;
    private var AniMarkId:String;
	
	public function ResultItemRenderer()
	{
		super();
		numbericon._visible = false;
	}
	public function setData(data:Object):Void
	{
		if (data == undefined)
		{
			this._visible = false;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);
			setEndAnimation();
			return;
		}
		this._visible = true;
		this.data = data;
		invalidate();

		codename.htmlText = data.CodeName;
		_codename = data.CodeName;
		score.text = data.Score;
		killsetTxt.text = data.Kill + " / " + data.Assist + " / " + data.Death;
		exp.text = data.Exp;
		_classicon = data.ClassIcon;
		_clanImg = data.ClanImg;
		clanmarkChk = _clanImg.charAt(0);
		
		_vip = data.Vip;
		_vipTime = data.VipTime;
		
		if (data.AddFriend == "0")
		{
			btnAddFriend._visible = false;
		}
		else
		{
			btnAddFriend._visible = true;
		}
		if (data.Bonus != "")
		{
			Bonus.text = _Bonus;
		}
		pcroomIcon._x = 500;
		eventIcon._x = 500;
		expIcon._x = 500;
		spUpIcon._x = 500;
		//피씨방 국가별로 구분하기 위해 수정 2012-03-05
		if (data.PcRoomConnect != "")
		{
			pcroomIcon._visible = true;
			pcroomIcon.gotoAndStop(data.PcRoomConnect);
		}
		else
		{
			pcroomIcon._visible = false;
		}
		if (data.EventConnect != "")
		{
			eventIcon._visible = true;
			eventIcon.gotoAndStop(data.EventConnect);
		}
		else
		{
			eventIcon._visible = false;
		}
		if (data.ExpConnect == 1)
		{
			expIcon._visible = true;
		}
		else
		{
			expIcon._visible = false;
		}
		if (data.spUpConnect == 1)
		{
			spUpIcon._visible = true;
		}
		else
		{
			spUpIcon._visible = false;
		}
		// 1 1 1 1
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect == 1 && data.spUpConnect == 1)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[3]},Strong.easeOut);
		}
		/*
		1 1 1 0
		1 1 0 1
		1 0 1 1
		0 1 1 1
		*/ 
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect == 1 && data.spUpConnect == 0)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect == 0 && data.spUpConnect == 1)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect == 1 && data.spUpConnect == 1)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect == 1 && data.spUpConnect == 1)
		{
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		/*
		1 1 0 0
		0 1 1 0
		0 0 1 1
		1 0 0 1
		0 1 0 1
		1 0 1 0
		*/ 
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect == 0 && data.spUpConnect == 0)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect == 1 && data.spUpConnect == 0)
		{
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && data.ExpConnect == 1 && data.spUpConnect == 1)
		{
			Tween.init();
			expIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect == 0 && data.spUpConnect == 1)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}

		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect == 1 && data.spUpConnect == 0)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}

		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect == 0 && data.spUpConnect == 1)
		{
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		/*
		1 0 0 0
		0 1 0 0
		0 0 1 0
		0 0 0 1
		*/ 
		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect == 0 && data.spUpConnect == 0)
		{
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect == 0 && data.spUpConnect == 0)
		{
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && data.ExpConnect == 1 && data.spUpConnect == 0)
		{
			Tween.init();
			expIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && data.ExpConnect == 0 && data.spUpConnect == 1)
		{
			Tween.init();
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		//1이 내팀 0이 다른팀  
		if (data.TeamColorIndex == "1")
		{
			if (data.MeChk == "1")
			{
				//나만 바꾸기
				score.textColor = 0xbea270;
				killsetTxt.textColor = 0xbea270;
				exp.textColor = 0xbea270;
				pcroomIcon._alpha = 100;
				eventIcon._alpha = 100;
				//eventIcon.gotoAndStop(1);
				expIcon.gotoAndStop(1);
				spUpIcon.gotoAndStop(1);
			}
			else
			{
				//나 말고 다른사람들
				score.textColor = 0xADADAD;
				killsetTxt.textColor = 0xADADAD;
				exp.textColor = 0xADADAD;
				pcroomIcon._alpha = 40;
				eventIcon._alpha = 40;
				//eventIcon.gotoAndStop(2);
				expIcon.gotoAndStop(2);
				spUpIcon.gotoAndStop(2);
			}

		}
		else if (data.TeamColorIndex == "0")
		{
			//우리팀 아닌사람들
			if (data.MeChk == "1")
			{
				//나만 바꾸기
				score.textColor = 0xbea270;
				killsetTxt.textColor = 0xbea270;
				exp.textColor = 0xbea270;
				pcroomIcon._alpha = 100;
				eventIcon._alpha = 100;
				//eventIcon.gotoAndStop(1);
				expIcon.gotoAndStop(1);
				spUpIcon.gotoAndStop(1);
			}
			else
			{
				score.textColor = 0x575757;
				killsetTxt.textColor = 0x575757;
				exp.textColor = 0x575757;
				pcroomIcon._alpha = 40;
				eventIcon._alpha = 40;
				//eventIcon.gotoAndStop(2);
				expIcon.gotoAndStop(2);
				spUpIcon.gotoAndStop(2);
			}
		}
		else if (data.TeamColorIndex == undefined)
		{
			score.textColor = 0x575757;
			killsetTxt.textColor = 0x575757;
			exp.textColor = 0x575757;

		}
		if (_classicon.charAt(0) == "R")
		{
			numbericon._visible = true;
			numbericon.gotoAndStop(1);
			numbericon["txtNo"].text = _classicon.substring(1);
			unLoader();
			if (clanmarkChk == "#")
			{
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}
			else if (clanmarkChk == "" || clanmarkChk == undefined)
			{
				//
			}
			else
			{
				clanmarkChk = "@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
		}
		else if (_classicon.charAt(0) == "B")
		{
			numbericon._visible = true;
			numbericon.gotoAndStop(2);
			numbericon["txtNo"].text = _classicon.substring(1);
			unLoader();
			if (clanmarkChk == "#")
			{
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}
			else if (clanmarkChk == "" || clanmarkChk == undefined)
			{
				//
			}
			else
			{
				clanmarkChk = "@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
		}
		else
		{
			numbericon._visible = false;
			lvLoader(imgPathClass,classicon);
			if (clanmarkChk == "#")
			{
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}
			else if (clanmarkChk == "" || clanmarkChk == undefined)
			{
				//
			}
			else
			{
				clanmarkChk = "@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
		}
		var root = _parent._parent._parent._parent._parent;
		if (root.personalMode == 1)
		{
			starMc.gotoAndStop(this.index + 2);
		}
		// 
		var urlPath:String = "img://Imgset_";
		var imgPathCardItem:String;
		var itemName =_vip
		var len = itemName.length;
		var chk = itemName.substr(-4, len);

		vipIcon._height = 0;
		switchFlag=true
		TweenMax.killTweensOf(vipIcon);
		TweenMax.killTweensOf(classicon);
		setEndAnimation();
		
		//VIPIMG
		if (itemName == "" || itemName == undefined)
		{
			vipIcon._visible = false;
		}
		else
		{
			if (_global.gfxPlayer)
			{
				imgPathCardItem = "gfxImgSet/vip/class/small/" + itemName + ".png";
			}
			else
			{
				if (chk == "_ani")
				{
					imgPathCardItem = "VipCards_Ani/" + itemName + ".swf";
				}
				else
				{
					imgPathCardItem = urlPath + "VipClass.small." + itemName;
				}
			}
			vipIcon._visible = true;
			lvLoader(imgPathCardItem,vipIcon);
		}
		
		AniMarkId=data.ClanEffect
		
		if(AniMarkId=="" || AniMarkId==null){
			clanEff._visible=false
		}else{
			clanEff._visible=true
			var aniPos = [0,-2, 16, 32];
			//클랜 애니메이션
			var imgAniMarkBox:String;
			var aniAt = AniMarkId.charAt(0);
			var pos:String = AniMarkId.substr(1, 2);
			var img:String = AniMarkId.substr(3, 4);
			var locNo
			trace("aasdfasdfasd===================="+ pos + "," + img);
			
			if (_global.gfxPlayer)
			{
				imgAniMarkBox = "gfxImgSet/ClanMarkAni/A" + img + ".swf";
			}
			else
			{
				imgAniMarkBox = UDKUtils.ClanMarkAniPath+"A"+ img
			}
			
	
			if (Number(pos) < 10)
			{
				locNo = pos.charAt(1)
			}
			else
			{
				locNo = pos
			}			
			clanEff["eff"]._y = aniPos[locNo];		
			trace("imgAniMarkBox ====================" + imgAniMarkBox);			
			lvLoader(imgAniMarkBox,clanEff["eff"]);
		}
	}
	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}
		validateNow();
		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	private function lvLoader(target, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(target,mc);
	}
	private function unLoader()
	{
		mcLoader.unloadClip(classicon);
	}
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classicon")
		{
			var lvNo:String = _classicon;
			/*var KD:String = lvNo.charAt(0);
			var LV:String = lvNo.charAt(1);
			var chkCl:String = lvNo.substr(2, 3);
			var CL:String;
			if (chkCl.charAt(0) == "0")
			{
				CL = chkCl.charAt(1);
			}
			else
			{
				CL = chkCl;
			}
			classicon.lv0.gotoAndStop(Number(CL) + 1);
			classicon.lv1.gotoAndStop(Number(LV) + 1);
			classicon.lv2.gotoAndStop(Number(KD) + 1);*/
			mc.set_level(lvNo);
			mc._y = 0;
			mc._height=32
		}
		else if (mc._name == "tg")
		{
			if (clanmarkChk == "#")
			{
				var sym:String = _clanImg.substr(1, 5);
				var dec:String = _clanImg.substr(6, 3);
				var back:String = _clanImg.substr(9, 3);
				mc.symbolMc.setSymbolPic(sym);
				mc.decoMc.setDecoPic("D" + dec);
				mc.backMc.setBackPic("B" + back);
				mc._x = 4;
				mc._y = 3;
				mc._xscale = 70;
				mc._yscale = 70;
			}
			else if (clanmarkChk == "@")
			{
				mc._x = 4;
				mc._y = 3;
				mc._xscale = 70;
				mc._yscale = 70;
			}
		}
		else if (mc._name == "vipIcon")
		{
			mc._y = 0;
			mc._height=0
			
			if(_vipTime==""||_vipTime=="0"||_vipTime==undefined){
				setEndAnimation()
			}else{
				setVipAnimation();
			}
		}
	}
	private function configUI():Void
	{
		constraints = new Constraints(this, true);
		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		btnAddFriend.addEventListener("click",this,"onClickButton");
		btnAddFriend.addEventListener("rollOver",this,"onOverButton");
		btnAddFriend.addEventListener("rollOut",this,"onOutButton");
		btnAddFriend.addEventListener("releaseOutside",this,"onOutButton");
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}
	public function handleInput(details:InputDetails, pathToFocus:Array):Boolean
	{
		var nextItem:MovieClip = MovieClip(pathToFocus.shift());
		var handled:Boolean;
		if (nextItem != null)
		{
			handled = nextItem.handleInput(details, pathToFocus);
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
	public function draw()
	{
		super.draw();
		if (data.AddFriend == "0")
		{
			btnAddFriend._visible = false;
		}
		else
		{
			btnAddFriend._visible = true;
		}
	}
	public function onClickButton(p_event:Object):Void
	{
		_global.onAddFriendBtnPress(codename.text);
	}
	public function onOverButton(p_event:Object):Void
	{
		_toolTipAni = this._parent.attachMovie("toolTipAni", "toolTipAni", 1);
		_toolTipAni._x = this._x - 55;
		_toolTipAni._y = this._y + 25;
	}
	public function onOutButton(p_event:Object):Void
	{
		_toolTipAni.removeMovieClip();
	}
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		setState("down");
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		setState("release");
		handleClick(mouseIndex,button);
	}

	private function executeCallback():Void
	{
		//trace("executeCallback intervalId: " + intervalId);
		switchFlag = !switchFlag;
		setEndAnimation();

		setVipAnimation();
	}

	private function beginInterval():Void
	{
		if (intervalId != null)
		{
			//trace("clearInterval");
			clearInterval(intervalId);
		}
		intervalId = setInterval(this, "executeCallback", Number(_vipTime));
	}

	public function setEndAnimation()
	{
		clearInterval(intervalId);
		delete intervalId;
	}
	//
	private function setVipAnimation()
	{
		setEndAnimation()
		
		if (switchFlag)
		{
			vipIcon._y = -4;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:32, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:0, _y:27, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
		else
		{
			classicon._y = -4;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:0, _y:27, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:32, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
	}
	private function onBtnShowComplete()
	{
		vipIcon._y = -4;
		classicon._y = -4;
		beginInterval();
	}
}