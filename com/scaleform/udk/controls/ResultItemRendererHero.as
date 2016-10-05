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
class com.scaleform.udk.controls.ResultItemRendererHero extends ListItemRenderer
{
	private var imgIcon:MovieClip;
	private var bg:MovieClip;
	private var codename:TextField;
	
	private var killsetTxt:TextField;
	private var defence:TextField;
	private var offense:TextField;
	private var movement:TextField;
	private var beastKill:TextField;
	private var money:TextField;
	private var exp:TextField;
	private var btnAddFriend:Button;
	
	private var _toolTipAni:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	//private var _imgPathPersonal:String = "gfxImgSet/Personal/";
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	
	private var vipIcon:MovieClip;
	private var _vip:String;
	private var switchFlag:Boolean = true;
	public var intervalId:Number;
	private var _vipTime:String;
	

	public function ResultItemRendererHero()
	{		
		super();
		
		mcLoader = new MovieClipLoader();
	}
	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(imgIcon);
			setEndAnimation();
			return;
		}
		this._visible = true;
		this.data = data;
		invalidate();
		
		mcLoader.loadClip(_imgPathPersonal+data.ImgSet, imgIcon);
		
		_vip = data.Vip;
		_vipTime = data.VipTime;
		
		codename.htmlText = data.CodeName;
		killsetTxt.text = data.Kill+" / "+data.Assist+" / "+data.Death;
		defence.text = data.Defence;
		offense.text = data.Offense;
		movement.text = data.Movement;
		beastKill.text = data.BeastKill;
		money.text = data.Money;
		exp.text = data.Exp;
			
		if (data.AddFriend == "0") {
			btnAddFriend._visible = false;
		} else {
			btnAddFriend._visible = true;
		}
		
		
		//1이 내팀 0이 다른팀 
		if (data.TeamColorIndex == "1") {
			if (data.MeChk == "1") {
				//나만 바꾸기
				killsetTxt.textColor = 0xbea270;
				defence.textColor = 0xbea270;
				offense.textColor = 0xbea270;
				movement.textColor = 0xbea270;
				beastKill.textColor = 0xbea270;
				money.textColor = 0xbea270;
				exp.textColor = 0xbea270;
			} else {
				//나 말고 다른사람들
				killsetTxt.textColor = 0xADADAD;
				defence.textColor = 0xADADAD;
				offense.textColor = 0xADADAD;
				movement.textColor = 0xADADAD;
				beastKill.textColor = 0xADADAD;
				money.textColor = 0xADADAD;
				exp.textColor = 0xADADAD;
			}

		} else if (data.TeamColorIndex == "0") {
			//우리팀 아닌사람들
			if (data.MeChk == "1") {
				//나만 바꾸기
				killsetTxt.textColor = 0xbea270;
				defence.textColor = 0xbea270;
				offense.textColor = 0xbea270;
				movement.textColor = 0xbea270;
				beastKill.textColor = 0xbea270;
				money.textColor = 0xbea270;
				exp.textColor = 0xbea270;
			}else{
				killsetTxt.textColor = 0x575757;
				defence.textColor = 0x575757;
				offense.textColor = 0x575757;
				movement.textColor = 0x575757;
				beastKill.textColor = 0x575757;
				money.textColor = 0x575757;
				exp.textColor = 0x575757;
			}			
		} else if (data.TeamColorIndex == undefined) {
			killsetTxt.textColor = 0x575757;
				defence.textColor = 0x575757;
				offense.textColor = 0x575757;
				movement.textColor = 0x575757;
				beastKill.textColor = 0x575757;
				money.textColor = 0x575757;
				exp.textColor = 0x575757;
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
		TweenMax.killTweensOf(imgIcon);
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
				imgPathCardItem = "gfxImgSet/vip/class/big/" + itemName + ".png";
			}
			else
			{
				if (chk == "_ani")
				{
					imgPathCardItem = "VipCards_Ani/" + itemName + ".swf";
				}
				else
				{
					imgPathCardItem = urlPath + "VipClass.big." + itemName;
				}
			}
			vipIcon._visible = true;			
			mcLoader.loadClip(imgPathCardItem,vipIcon);
		}
		
		mcLoader.addListener(this);
		
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "vipIcon")
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
	
	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}
		validateNow();
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	
	private function configUI():Void {
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		if (!_autoSize) {
			sizeIsInvalid = true;
		}
		btnAddFriend.addEventListener("click",this,"onClickButton");
		btnAddFriend.addEventListener("rollOver",this,"onOverButton");
		btnAddFriend.addEventListener("rollOut",this,"onOutButton");
		btnAddFriend.addEventListener("releaseOutside",this,"onOutButton");
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
	}
	public function handleInput(details:InputDetails, pathToFocus:Array):Boolean {
		var nextItem:MovieClip = MovieClip(pathToFocus.shift());
		var handled:Boolean;
		if (nextItem != null) {
			handled = nextItem.handleInput(details, pathToFocus);
			if (handled) {
				return true;
			}
		}
		if (details.navEquivalent == "enter") {
			handled = false;
			if (handled) {
				return true;
			}
		}
		if (details.navEquivalent == "left") {
			handled = false;
			if (handled) {
				return true;
			}
		}
		return false;// or true if handled
	}
	public function draw() {
		super.draw();
		if (data.AddFriend == "0") {
			btnAddFriend._visible = false;
		} else {
			btnAddFriend._visible = true;
		}
	}
	public function onClickButton(p_event:Object):Void {
		_global.onAddFriendBtnPress(codename.text);
	}
	
	public function onOverButton(p_event:Object):Void {
		_toolTipAni = this._parent.attachMovie("toolTipAni", "toolTipAni", 1);
		_toolTipAni._x = this._x-55;
		_toolTipAni._y = this._y+25;
	}
	public function onOutButton(p_event:Object):Void {
		_toolTipAni.removeMovieClip();
	}
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		setState("down");
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void {
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
			vipIcon._y = 0;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(imgIcon);

			TweenMax.to(vipIcon,0.5,{_height:44, ease:Cubic.easeIn});
			TweenMax.to(imgIcon,0.5,{_height:0, _y:44, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
		else
		{
			imgIcon._y = 0;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(imgIcon);

			TweenMax.to(vipIcon,0.5,{_height:0, _y:44, ease:Cubic.easeIn});
			TweenMax.to(imgIcon,0.5,{_height:44, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
	}
	private function onBtnShowComplete()
	{
		vipIcon._y = 0;
		imgIcon._y = 0;
		beginInterval();
	}
}