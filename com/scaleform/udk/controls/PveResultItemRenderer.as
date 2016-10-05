import com.scaleform.udk.controls.PveResultItemReward;
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
class com.scaleform.udk.controls.PveResultItemRenderer extends ListItemRenderer {

	public var meBox:MovieClip;
	//public var reward:PveResultItemReward;
	public var rewardIcon:MovieClip;
	public var txtX:TextField;
	public var txtNo:TextField;
	
	private var num0:Number = 0;
	private var num1:Number = 0;
	private var num2:Number = 0;
	private var num3:Number = 0;
	private var num4:Number = 0;
	private var num5:Number = 0;
	
	private var targetNum0:Number;
	private var targetNum1:Number;
	private var targetNum2:Number;
	private var targetNum3:Number;
	private var targetNum4:Number;
	private var targetNum5:Number;
	
	private var intervalId0:Number;
	private var intervalId1:Number;
	private var intervalId2:Number;
	private var intervalId3:Number;
	private var intervalId4:Number;
	private var intervalId5:Number;
	
	private var classicon:MovieClip;
	private var bg:MovieClip;
	private var numbericon:MovieClip;
	
	private var killSetTitleTxt:TextField;
	private var expTitleTxt:TextField;
	private var scoreTitleTxt:TextField;
	
	private var codename:TextField;
	private var killsetTxt:TextField;
	private var exp:TextField;
	//private var score:TextField;
	private var score0:TextField;
	private var score1:TextField;
	private var score2:TextField;
	private var score3:TextField;
	private var score4:TextField;
	private var score5:TextField;
	private var btnAddFriend:Button;

	private var _rewardImg:String;
	private var _rewardNum:Number;
	private var _mechk:Boolean;
	private var _classicon:String;
	private var _codename:String;
	private var _kill:String;
	private var _assist:String;
	private var _weak:String;
	private var _save:String;
	private var _exp:String;

	private var _toolTipAni:MovieClip;

	private var pcroomIcon:MovieClip;
	private var eventIcon:MovieClip;
	private var expIcon:MovieClip;
	private var spUpIcon:MovieClip;
	
	private var clanImg:MovieClip;
	private var _clanImg:String;
	//private var iconTxArr:Array = [177,210,234,260];
	private var iconTxArr:Array = [230,263,287,313];
	
	private var urlPath = "";
	//private var urlPath="gfxImgSet/";
	private var imgClanMarkSmallPath:String = urlPath+"gfx_imgset_clanMark_small.swf";
	private var imgPathClass:String = urlPath+"imgset_class.swf";
	//private var imgPathCashItem:String = urlPath+"gfx_imgset_cashItem.swf";
    private var clanmarkChk:String;
	private var mcLoader:MovieClipLoader;
	//private var _flag:Number;
	
	private var isDataSet:Boolean = false;
	
	private var vipIcon:MovieClip;
	private var _vip:String;
	private var switchFlag:Boolean = true;
	public var intervalId6:Number;
	private var _vipTime:String;
	
	private var clanEff:MovieClip;
    private var AniMarkId:String;

    private var rewardBallSet:MovieClip;

	// Initialization:
	public function PveResultItemRenderer()
	{
		super();
		numbericon._visible = false;
		meBox._visible = false;
		rewardBallSet.txtNo.textAutoSize="shrink";

		rewardBallSet.txtNo.noTranslate=true
		rewardBallSet.txtX.noTranslate=true
	}

	public function removeInterval():Void
	{
		clearInterval(intervalId0);
		clearInterval(intervalId1);
		clearInterval(intervalId2);
		clearInterval(intervalId3);
		clearInterval(intervalId4);
		clearInterval(intervalId5);
		
		isDataSet = false;
	}
	
	public function setData(data:Object):Void
	{
		initListItem();
		
		if (data == undefined) {
			bg.gotoAndStop(2);
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);
			setEndAnimation();
			//this._visible = false;
			return;
		}
		bg.gotoAndStop(1);
		this._visible = true;
		this.data = data;

		invalidate();
		
		meBox._visible = false;
		
		killSetTitleTxt._visible = true;
		expTitleTxt._visible = true;
		scoreTitleTxt._visible = true;
		
		_rewardImg = data.RewardImg;
		_rewardNum = data.RewardNum;
		_vip = data.Vip;
		_vipTime = data.VipTime;
		
		
		if(_rewardImg!="" && _rewardImg!=null){
			rewardBallSet._visible = true;
			var imgPathCashItem="img://Imgset_CashItem."+_rewardImg
			lvLoader(imgPathCashItem, rewardBallSet.rewardIcon);	
		}else{
			rewardBallSet._visible = false;			
		}
		
		codename.htmlText = data.CodeName;
		_codename = data.CodeName;

		killsetTxt.text = ""+data.Kill+" / "+data.Assist+" / "+data.Weak+" / "+data.Save;
		exp.text = data.Exp;
		setScore(data.Score);
		_classicon = data.ClassIcon;
		_clanImg = data.ClanImg;
		
		clanmarkChk = _clanImg.charAt(0);
		//_flag = data.TeamColorIndex;TeamColorIndex
		//
		
		btnAddFriend._visible = data.AddFriend;
		
		pcroomIcon._x = 336;
		eventIcon._x = 336;
		expIcon._x = 336;
		spUpIcon._x = 336;
		
		/*if (data.PcRoomConnect == 1) {
			pcroomIcon._visible = true;
		} else {
			pcroomIcon._visible = false;
		}*/
		//피씨방 국가별로 구분하기 위해 수정 2012-03-05
		if(data.PcRoomConnect != ""){
			pcroomIcon._visible = true;
			pcroomIcon.gotoAndStop(data.PcRoomConnect);
		}else{
			pcroomIcon._visible = false;
		}
		if(data.EventConnect != ""){
			eventIcon._visible = true;
			eventIcon.gotoAndStop(data.EventConnect);
		}else{
			eventIcon._visible = false;
		}
		expIcon._visible = data.ExpConnect;
		spUpIcon._visible = data.spUpConnect;
		
		// 1 1 1 1
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect && data.spUpConnect) {
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
		if (data.PcRoomConnect != "" && data.EventConnect != "" && data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}	 
		if (data.PcRoomConnect != "" && data.EventConnect != "" && !data.ExpConnect && data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect && data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[2]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect && data.spUpConnect) {
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
		if (data.PcRoomConnect != "" && data.EventConnect != "" && !data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			eventIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && data.ExpConnect && data.spUpConnect) {
			Tween.init();
			expIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}
		if (data.PcRoomConnect != "" && data.EventConnect == "" && !data.ExpConnect && data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}	
		
		if (data.PcRoomConnect != "" && data.EventConnect == "" && data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
			expIcon.tweenTo(0.2,{_x:iconTxArr[1]},Strong.easeOut);
		}	
		
		if (data.PcRoomConnect == "" && data.EventConnect != "" && !data.ExpConnect && data.spUpConnect) {
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
		if (data.PcRoomConnect != "" && data.EventConnect == "" && !data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			pcroomIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect != "" && !data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			eventIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && data.ExpConnect && !data.spUpConnect) {
			Tween.init();
			expIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		if (data.PcRoomConnect == "" && data.EventConnect == "" && !data.ExpConnect && data.spUpConnect) {
			Tween.init();
			spUpIcon.tweenTo(0.2,{_x:iconTxArr[0]},Strong.easeOut);
		}
		
		
		if (data.MeChk)
		{
			pcroomIcon._alpha = 100;
			eventIcon._alpha = 100;
			expIcon.gotoAndStop(1);
			spUpIcon.gotoAndStop(1);
			meBox._visible = true;
		}
		else
		{
			pcroomIcon._alpha = 40;
			eventIcon._alpha = 40;
			expIcon.gotoAndStop(2);
			spUpIcon.gotoAndStop(2);
			meBox._visible = false;
		}
				
		if (_classicon.charAt(0) == "R") {
			numbericon._visible = true;
			numbericon.gotoAndStop(1);
			numbericon["txtNo"].text = _classicon.substring(1);
			unLoader();
			if(clanmarkChk=="#"){
				clanImg._visible = true;
				lvLoader(imgClanMarkSmallPath,clanImg);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				clanImg._visible = true;
				lvLoader(_clanImg,clanImg);
			}		

		} else if (_classicon.charAt(0) == "B") {
			numbericon._visible = true;
			numbericon.gotoAndStop(2);
			numbericon["txtNo"].text = _classicon.substring(1);
			unLoader();
			if(clanmarkChk=="#"){
				clanImg._visible = true;
				lvLoader(imgClanMarkSmallPath,clanImg);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				clanImg._visible = true;
				lvLoader(_clanImg,clanImg);
			}		

		} else {
			numbericon._visible = false;
			classicon._visible = true;			
			lvLoader(imgPathClass,classicon);				
			if(clanmarkChk=="#"){
				clanImg._visible = true;
				lvLoader(imgClanMarkSmallPath,clanImg);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				clanImg._visible = true;
				lvLoader(_clanImg,clanImg);
			}		
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
	
	private function initListItem():Void
	{
		btnAddFriend._visible = false;
		classicon._visible = false;
		clanImg._visible = false;
		codename.text = "";
		killSetTitleTxt._visible = false;
		expTitleTxt._visible = false;
		scoreTitleTxt._visible = false;
		killsetTxt.text = "";
		exp.text = "";
		score0.text = "";
		score1.text = "";
		score2.text = "";
		score3.text = "";
		score4.text = "";
		score5.text = "";
		pcroomIcon._visible = false;
		eventIcon._visible = false;
		expIcon._visible = false;
		spUpIcon._visible = false;		
		rewardBallSet._visible = false;
		rewardBallSet.txtNo.text = "";
	}
	
	private function setScore(value:Number):Void
	{
		var numStr:String = value.toString();
		var numArr:Array = numStr.split("");
		numArr.reverse();
		if (isDataSet)
		{
			for (var i:Number=0; i<numArr.length; i++)
			{
				this["score"+i].text = numArr[i].toString();
			}
		}
		else
		{
			for (var i:Number=0; i<numArr.length; i++)
			{
				this["num"+i] = 0;
				this["targetNum"+i] = Number(numArr[i]) + ((i*10)+10);
				this["intervalId"+i] = setInterval(this, "setScoreInterval", 40, [i]);
			}
		}
		isDataSet = true;
	}
	
	private function setScoreInterval(index:Number):Void
	{
		this["score"+index].text = (this["num"+index]%10).toString();
		if (this["num"+index] == this["targetNum"+index]) { clearInterval(this["intervalId"+index]); }
		this["num"+index]++;
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
	private function lvLoader(target,mc) {
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(target,mc);
	}
	private function unLoader() {
		mcLoader.unloadClip(classicon);		
		//mcLoader.unloadClip(clanImg["tg"]);		
	}

	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "classicon") {
			var lvNo:String = _classicon;			
			mc.set_level(lvNo)
			mc._y = 31;
			mc._height=32
			
		}else if (mc._name == "clanImg") {
			if (clanmarkChk == "#") {
				var sym:String = _clanImg.substr(1, 5);
				var dec:String = _clanImg.substr(6, 3);
				var back:String = _clanImg.substr(9, 3);
				mc.symbolMc.setSymbolPic(sym)
				mc.decoMc.setDecoPic("D"+dec)
				mc.backMc.setBackPic("B"+back)
			} else if (clanmarkChk == "@") {
				//
			}
		}
		else if (mc._name == "rewardIcon")
		{
			rewardBallSet.txtNo.text = _rewardNum.toString();
		}
		else if (mc._name == "vipIcon")
		{
			mc._y = 31;
			mc._height=0
			
			if(_vipTime==""||_vipTime=="0"||_vipTime==undefined){
				setEndAnimation()
			}else{
				setVipAnimation();
			}
		}
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
		
		var format1:TextFormat = new TextFormat();
		format1.italic = true;
		
		killSetTitleTxt.setTextFormat(format1);
		expTitleTxt.setTextFormat(format1);
		scoreTitleTxt.setTextFormat(format1);
		
		exp.setNewTextFormat(format1);
		killsetTxt.setNewTextFormat(format1);
		killSetTitleTxt.setNewTextFormat(format1);
		expTitleTxt.setNewTextFormat(format1);
		scoreTitleTxt.setNewTextFormat(format1);

		score0.verticalAlign = "center";
		score1.verticalAlign = "center";
		score2.verticalAlign = "center";
		score3.verticalAlign = "center";
		score4.verticalAlign = "center";
		score5.verticalAlign = "center";
		
		rewardBallSet.txtX.verticalAlign = "center";
		rewardBallSet.txtNo.verticalAlign = "center";

		score0.textAutoSize = "shrink";
		score1.textAutoSize = "shrink";
		score2.textAutoSize = "shrink";
		score3.textAutoSize = "shrink";
		score4.textAutoSize = "shrink";
		score5.textAutoSize = "shrink";
		
		rewardBallSet.txtX.textAutoSize = "shrink";
		rewardBallSet.txtNo.textAutoSize = "shrink";
		
		initListItem();
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

	public function draw()
	{
		super.draw();
		btnAddFriend._visible = data.AddFriend;
	}
	
	public function onClickButton(p_event:Object):Void {
		//trace("p_event.target._name:  " + p_event.target._parent._name);
		trace("p_event.target._name:  " + codename.text);
		_global.onAddFriendBtnPress(codename.text);
	}

	public function onOverButton(p_event:Object):Void {

		//toolTipAni._visible = true;
		_toolTipAni = this._parent.attachMovie("toolTipAni", "toolTipAni", 1);
		_toolTipAni._x = this._x-88;
		_toolTipAni._y = this._y+65;

		//trace(this._y);
	}
	public function onOutButton(p_event:Object):Void {
		//toolTipAni._visible = false;
		_toolTipAni.removeMovieClip();
	}

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
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
		if (intervalId6 != null)
		{
			//trace("clearInterval");
			clearInterval(intervalId6);
		}
		intervalId6 = setInterval(this, "executeCallback", Number(_vipTime));
	}

	public function setEndAnimation()
	{
		clearInterval(intervalId6);
		delete intervalId6;
	}
	//
	private function setVipAnimation()
	{
		setEndAnimation()
		
		if (switchFlag)
		{
			vipIcon._y = 31;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:32, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:0, _y:63, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
		else
		{
			classicon._y = 31;
			TweenMax.killTweensOf(vipIcon);
			TweenMax.killTweensOf(classicon);

			TweenMax.to(vipIcon,0.5,{_height:0, _y:63, ease:Cubic.easeIn});
			TweenMax.to(classicon,0.5,{_height:32, ease:Cubic.easeIn, onComplete:Delegate.create(this, onBtnShowComplete)});

		}
	}
	private function onBtnShowComplete()
	{
		vipIcon._y = 31;
		classicon._y = 31;
		beginInterval();
	}
}