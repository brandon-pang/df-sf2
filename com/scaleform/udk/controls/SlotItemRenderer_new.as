import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.SlotItemRenderer_new extends ListItemRenderer
{
	private var classicon:MovieClip;
	private var mastericon:MovieClip;
	private var unitIcon:MovieClip;
	private var _hit:MovieClip;
	private var nonSlot:MovieClip;
	private var onSlot:MovieClip;
	private var numbericon:MovieClip;
	private var clanImg:MovieClip;
	private var codename:TextField;
	private var clan:TextField;
	private var stat:TextField;

	private var _codename:String;
	private var _clan:String;
	private var _stat:String;
	private var _lock:String;
	private var _mechk:String;

	private var _classicon:String;
	private var _mastericon:String;
	private var _uniticon:String;
	private var _sex:String;
	private var _manner:String;
	private var _clanImg:String;

	private var targetMc:MovieClip;

	private var clickValue:String;
	private var mcLoader:MovieClipLoader;
	private var clanmarkChk:String;

	private var vipIcon:MovieClip;
	private var _vip:String;
	private var switchFlag:Boolean = true;
	public var intervalId:Number;
	private var _vipTime:Number;

	private var urlPath = "";
	//private var urlPath = "gfxImgSet/";
	private var _imgPath:String = urlPath + "imgset_class.swf";
	//private var _imgPathMark:String = urlPath+"gfx_imgset_unitmark_small.swf"
	private var imgClanMarkSmallPath:String = urlPath + "gfx_imgset_clanMark_small.swf";
	private var mouseListener:Object;

	private var clanEff:MovieClip;
	private var AniMarkId:String;

	private var slotRank:MovieClip;
	private var _clanRank:String;

	// Initialization:
	public function SlotItemRenderer_new()
	{
		super();
		numbericon._visible = false;

		mouseListener = new Object();
		Mouse.addListener(mouseListener);
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
		this.data = data;
		invalidate();
		this._visible = true;
		super.setData(data);

		_lock = data.Lock;
		_mechk = data.MeChk;
		_codename = data.CodeName;
		_clan = data.ClanName;
		_stat = data.Stat;
		_classicon = data.ClassIcon;
		_mastericon = data.MasterIcon;
		_uniticon = data.UnitName;
		//_sex = data.Sex;
		_manner = data.Manner;
		_clanImg = data.ClanImg;
		_clanRank = data.ClanRankNo;
		_vip = data.Vip;
		_vipTime = data.VipTime;

		clanmarkChk = _clanImg.charAt(0);
		if (clanmarkChk == "#")
		{
			clanImg["clanBg"]._visible = false;
		}
		else if (clanmarkChk == "" || clanmarkChk == undefined)
		{
			clanImg["clanBg"]._visible = true;
		}
		else
		{
			clanmarkChk = "@";
			clanImg["clanBg"]._visible = false;
		}

		AniMarkId = data.ClanEffect;
		UpdateTextFields();
	}

	private function lvLoader(path, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(path,mc);
	}

	private function unLoader()
	{
		if (classicon._width != 16)
		{
			mcLoader.unloadClip(classicon);
		}
		else
		{
			//
		}
	}
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "classicon")
		{
			var __sex:String = _sex;
			var __manner:String = _manner;
			var lvNo:String = _classicon;
			classicon.set_level(lvNo);

			if (__manner == "4")
			{
				classicon.manner.gotoAndStop(2);
			}
			else
			{
				classicon.manner.gotoAndStop(1);
			}
			mc._y = 0;
			mc._height = 31;
		}
		else if (mc._name == "tg")
		{
			if (clanmarkChk == "#")
			{
				var sym:String = _clanImg.substr(1, 5);
				var dec:String = _clanImg.substr(6, 3);
				var back:String = _clanImg.substr(9, 3);
				//trace (rank+"\n" + sym+"\n"+dec+"\n"+back)
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
			if (_vipTime == "" || _vipTime == "0" || _vipTime == undefined)
			{
				setEndAnimation();
			}
		}
	}

	private function updateAfterStateChange():Void
	{
		// Redraw should only happen AFTER the initialization.
		if (!initialized)
		{
			return;
		}
		validateNow();// Ensure that the width/height is up to date.

		//arrow._z = -450;
		//arrow._y = -50;
		//trace (_label)
		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	// Public Methods:
	/** @exclude */
	public function toString():String
	{
		return "[Scaleform ServerItemRenderer " + _name + "]";
	}

	// Private Methods:    
	private function UpdateTextFields()
	{

		slotRank._visible = false;
		slotRank.gotoAndPlay(1);

		if (_lock == 0)
		{
			targetMc = onSlot;
			onSlot._visible = true;
			nonSlot._visible = false;

			if (_codename != "")
			{
				setVisible(true);
				mastericon.gotoAndStop(Number(_mastericon) + 1);
				//unitIcon.gotoAndStop(_uniticon);
				stat._visible = true;
				codename.htmlText = _codename;
				clan.htmlText = _clan;
				stat.text = _stat;

				if (_clanRank == "" || _clanRank == null)
				{
					slotRank._visible = false;
					slotRank.gotoAndPlay(1);
				}
				else
				{
					slotRank._visible = true;
					slotRank.gotoAndPlay("slot_rank" + _clanRank);
				}

				if (_classicon.charAt(0) == "R")
				{
					numbericon._visible = true;
					numbericon.gotoAndStop(1);
					numbericon["txtNo"].text = _classicon.substring(1);
					unLoader();

				}
				else if (_classicon.charAt(0) == "B")
				{
					numbericon._visible = true;
					numbericon.gotoAndStop(2);
					numbericon["txtNo"].text = _classicon.substring(1);
					unLoader();

				}
				else
				{
					numbericon._visible = false;
					lvLoader(_imgPath,classicon);
					//
				}
				//===========
				//
				//==============
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
				setVisible(false);

				targetMc.gotoAndPlay("out");
			}
			//

		}
		else
		{
			targetMc = nonSlot;
			onSlot._visible = false;
			nonSlot._visible = true;
			numbericon._visible = false;
			setVisible(false);
		}
		//
		var slotPoz:Object = {x:0, y:0};
		this.localToGlobal(slotPoz);
		trace(Math.ceil(slotPoz.x) + " , " + Math.ceil(slotPoz.y));
		trace(_parent._parent._parent._parent._name);
		var root = _parent._parent;
		if (_mechk == "1")
		{
			//애니메이션을 켜고 현재 이녀석에 위치값을 파악한다.
			//root["meBlurMc"].visible=true
			root["meBlurMc"]._y = (Math.ceil(slotPoz.y)) - 76;
			setTextColors(0xe7c486);
		}
		else
		{

			if (_mechk == "2")
			{
				root["meBlurMc"]._y = -100;
			}
			if (_mastericon == "0")
			{
				//mastericon.topmostLevel=true
				setTextColors(0x828282);
			}
			else
			{
				//mastericon.topmostLevel=false
				setTextColors(0xffffff);
			}
		}
		//
		var urlPath:String = "img://Imgset_";
		var imgPathCardItem:String;
		var itemName = _vip;
		var len = itemName.length;
		var chk = itemName.substr(-4, len);

		//vipIcon._alpha=0
		vipIcon._height = 0;
		switchFlag = true;
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
			setVipAnimation();
			vipIcon._visible = true;
			lvLoader(imgPathCardItem,vipIcon);
		}

		if (AniMarkId == "" || AniMarkId == null)
		{
			clanEff._visible = false;
		}
		else
		{
			clanEff._visible = true;
			var aniPos = [0, -2, 16, 32];
			//클랜 애니메이션
			var imgAniMarkBox:String;
			var aniAt = AniMarkId.charAt(0);
			var pos:String = AniMarkId.substr(1, 2);
			var img:String = AniMarkId.substr(3, 4);
			var locNo;
			trace("aasdfasdfasd====================" + pos + "," + img);

			if (_global.gfxPlayer)
			{
				imgAniMarkBox = "gfxImgSet/ClanMarkAni/A" + img + ".swf";
			}
			else
			{
				imgAniMarkBox = UDKUtils.ClanMarkAniPath + "A" + img;
			}


			if (Number(pos) < 10)
			{
				locNo = pos.charAt(1);
			}
			else
			{
				locNo = pos;
			}
			clanEff["eff"]._y = aniPos[locNo];
			trace("imgAniMarkBox ====================" + imgAniMarkBox);
			lvLoader(imgAniMarkBox,clanEff["eff"]);
		}
	}
	private function setVisible(boo:Boolean)
	{
		classicon._visible = boo;
		mastericon._visible = boo;
		clanImg._visible = boo;
		//unitIcon._visible = boo;
		codename._visible = boo;
		clan._visible = boo;
		stat._visible = boo;
		vipIcon._visible = boo;
		clanEff._visible = boo;

		setEndAnimation();
		//unitMc._visible = boo;
		//clanMc._visible = boo;
		//mannerMc._visible = boo;

		return;
	}

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		//onMouseUp = handleMouseUp;
		mouseListener.onMouseDown = Delegate.create(this, handleMouseDown);
		//---------------------------------------------- 비어있을때 안되게
		if (_codename.length > 0)
		{
			targetMc.gotoAndPlay("over");
		}

		if (_mechk == "1")
		{
			setTextColors(0xfff696);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0xdcdcdc);
			}
			else
			{
				setTextColors(0xffffff);
			}

		}
		this._parent._parent._parent._parent.rmoveRmenu();
		var clickValue = this._name.substring(4);
		//trace("onMouseOver= "+(clickValue-1));
		_global.getWaitroomItemOver(Number(clickValue) - 1);

		// Otherwise it is focused, and has no focusIndicator, so do nothing.           
		dispatchEventAndSound({type:"rollOver", mouseIndex:mouseIndex});

		/*var rnd=random(5)
		var arrays=["CAMO_MAPLE","",""]
		var array2=["#00003004001","","gfxImgSet/00001.png"]
		var array3=["card_normal","vip_normal","vip_general","vip_bronze","vip_silver","vip_gold"]
		_parent._parent._parent._parent.setIdCardOpenClass(this.index,
		   "20110323",
		   "정일우49일",
		   "1.234","0.123",
		   "99.0%","1","L86A1","0209",
		   array2[rnd],
		   arrays[rnd],
		   "매너관리 필요","38.0%",
		   1,array3[rnd]);*/
		//setIdCardOpenClass("8","20110323","정일우49일","1.234","0.123","99.0%","1","L86A1","0209","1","CAMO_MAPLE","매너관리 필요","38.0%",1); 
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		//delete onMouseUp;
		delete mouseListener.onMouseDown
		//---------------------------------------------- 비어있을때 안되게
		if (_codename.length > 0)
		{
			targetMc.gotoAndPlay("out");
		}


		if (_mechk == "1")
		{
			setTextColors(0xe7c486);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0x828282);
			}
			else
			{
				setTextColors(0xffffff);
			}
		}
		var clickValue = this._name.substring(4);
		_global.getWaitroomItemOut(Number(clickValue) - 1);
		//this._parent._parent._parent._parent.setIdCardCloseClass()
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{		
		delete mouseListener.onMouseDown
		//---------------------------------------------- 비어있을때 안되게
		if (_codename.length > 0)
		{
			targetMc.gotoAndPlay("down");
		}

		if (_mechk == "1")
		{
			setTextColors(0xfff696);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0xdcdcdc);
			}
			else
			{
				setTextColors(0xffffff);
			}
		}

	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		delete mouseListener.onMouseDown
		//---------------------------------------------- 비어있을때 안되게
		if (_codename.length > 0)
		{
			targetMc.gotoAndPlay("up");
		}

		if (_mechk == "1")
		{
			setTextColors(0xfff696);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0xdcdcdc);
			}
			else
			{
				setTextColors(0xffffff);
			}
		}

	}
	private function handleReleaseOutside(mouseIndex:Number, button:Number):Void
	{
		//delete onMouseUp;
		delete mouseListener.onMouseDown;
		targetMc.gotoAndPlay("out");
		if (_mechk == "1")
		{
			setTextColors(0xe7c486);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0x828282);
			}
			else
			{
				setTextColors(0xffffff);
			}
		}
		_global.getWaitroomItemOut(this._name.substring(4),"true");
	}
	private function handleMouseDown(button, target, idx):Void
	{
		var clickValue = this._name.substring(4);
		trace([button, clickValue]);
		if (_codename != "")
		{
			trace("Mouse Click Number: "+target+","+clickValue);		
			_global.OnSlotListPress(Number(clickValue) - 1,button);

			//this._parent._parent._parent._parent.setRightMenuDp((this.index)-1,["ID 카드보기","강퇴하기"])
		}
		else
		{
			//trace("Mouse Click None Number: "+btn+","+clickValue);
			_global.OnSlotBtnPress(Number(clickValue) - 1,button);
		}

		if (_mechk == "1")
		{
			setTextColors(0xe7c486);
		}
		else
		{
			if (_mastericon == "0")
			{
				setTextColors(0x828282);
			}
			else
			{
				setTextColors(0xffffff);
			}
		}
	}
	private function setTextColors(n:Number)
	{
		//codename.textColor = n;
		//clan.textColor = n;
		stat.textColor = n;
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
			setEndAnimation();
		}
		intervalId = setInterval(this, "executeCallback", Number(_vipTime));
	}

	public function setEndAnimation()
	{
		clearInterval(intervalId);
	}
	//
	private function setVipAnimation()
	{
		setEndAnimation();

		if (switchFlag)
		{
			vipIcon._y = 0;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:31, _y:0, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:0, _y:31, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
		else
		{
			classicon._y = 0;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:0, _y:31, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:31, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
	}
	private function onBtnShowComplete()
	{
		vipIcon._y = 0;
		classicon._y = 0;
		beginInterval();
	}
}