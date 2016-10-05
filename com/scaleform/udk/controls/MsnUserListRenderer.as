/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.controls.Button;
import gfx.controls.CoreList;
import gfx.utils.Constraints;
import gfx.utils.Delegate;

class com.scaleform.udk.controls.MsnUserListRenderer extends ListItemRenderer {
	/*int idx     줄 번호
	    string username 이름
	    string rank     계급
	    string userimage 개인 이미지
	    int Notice     쪽지 수
	    string online     온라인 여부
	    string server     서버
	    string channel 채널
	    string room     방번호
	    string ping     핑상태*/

	//메시지를 보낼수 있는 상태인지 아닌지
	private var connectIcon:MovieClip;
	//계급
	private var imgGrade:MovieClip;
	//자기이미지
	private var imgNick:MovieClip;
	//쪽지
	private var clanImg:MovieClip;
	
	private var noticeMc:MovieClip;
	//온오프라인
	private var bg:MovieClip;
	//clan
	private var bg1:MovieClip;
	
	private var offBlack:MovieClip;

	private var btnWithArea:MovieClip;

	private var loadingIcon:MovieClip;
	
	private var blockIcon:MovieClip;

	private var txtName:TextField;
	private var txtServer:TextField;
	private var txtChannel:TextField;
	private var txtRoomNo:TextField;

	private var _imgNick:String;
	private var _imgGrade:String;
	private var _clanImg:String;
	public var _idx:String;

	private var urlPath=""
	//private var urlPath="gfxImgSet/"
	//public var userImgPath:String = urlPath+"gfx_imgset_personal_small.swf";
	public var gradeImgPath:String = urlPath+"imgset_class.swf";
    public var imgClanMarkSmallPath:String=urlPath+"gfx_imgset_clanMark_small.swf"
	private var btnWith:Button;
	private var _hit:MovieClip;

	private var _ch0:String;
	private var _ch1:String;
	private var _ch2:String;
	
	private var friendChk:MovieClip;
    private var clanmarkChk:String;
	
	private var facebookIcon:MovieClip;	
	//private var facebookNick:TextField;
	
	// Initialization:
	public function MsnUserListRenderer() {
		super();
		btnWith._visible = false;
		blockIcon._visible=false;
		facebookIcon.gotoAndStop(1);
	}

	public function setData(data:Object):Void {
		//trace(data.toString());
		if (data == undefined) {
			this._visible = false;
			return;
		}

		this._visible = true;
		this.data = data;
		
		
		txtName.noTranslate=true
		txtServer.noTranslate=true
		txtChannel.noTranslate=true
		txtRoomNo.noTranslate=true
		
		friendChk=this._parent._parent._parent._parent.friendChkFlag

		_imgNick = data.userimage;
		_imgGrade = data.rank;		
		_clanImg = data.clanImg;
		var userImgPath="img://Imgset_Personal."+data.userimage
		
		clanmarkChk=_clanImg.charAt(0)
		if(clanmarkChk=="#"){
			clanImg["clanBg"]._visible=false
		}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
			clanImg["clanBg"]._visible=true
		}else{
			clanmarkChk="@";
			clanImg["clanBg"]._visible=false
		}
		
		_idx = String(this.index);
		
		btnWith._visible = false;
		
		if (data.loading == "1") {
			//loadingIcon._visible=true
			loadingIcon.gotoAndPlay("open");
		} else {
			loadingIcon.gotoAndPlay("close");
		}

		if (data.server.length>6) {
			var sp = data.server.substring(0, 5);
			_ch0 = sp+"..";
		} else {
			_ch0 = data.server;
		}

		if (data.channel.length>6) {
			var sp = data.channel.substring(0, 5);
			_ch1 = sp+"..";
		} else {
			_ch1 = data.channel;
		}
		if (data.room.length>6) {
			var sp = data.room.substring(0, 5);
			_ch2 = sp+"..";
		} else {
			_ch2 = data.room;
		}
		
		if(friendChk){
			trace ("===== call ==== friend ===")
			offBlack.gotoAndStop(1)
			bg._visible=true
			bg1._visible=false
		}else{
			trace ("===== call ==== clan ===")
			offBlack.gotoAndStop(2);
			bg1._visible=true
			bg._visible=false
		}

		if (data.online == "0") {
			offBlack._visible = true;
			noticeMc._visible = false;
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}			
			//
			txtName.htmlText = data.username;
			txtServer.text = "";
			txtChannel.text = "";
			txtRoomNo.text = "";
			//
			connectIcon._visible = false;

			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
			btnWith.visible = false;
			
		} else if (data.online == "1") {
			offBlack._visible = false;
			if (Number(data.notice)>0) {
				noticeMc._visible = true;
				noticeMc.txt.text = data.notice;
			} else {
				noticeMc._visible = false;
			}
			if(friendChk){
				bg.gotoAndStop(1);
			}else{
				bg1.gotoAndStop(1);
			}			
			txtName.htmlText = data.username;
			txtServer.text = _ch0;
			txtChannel.text = _ch1;
			txtRoomNo.text = _ch2;
			connectIcon._visible = true;

			if (data.playwith == "1") {
				//connectIcon.gotoAndPlay("on");
				btnWith.visible = false;
			} else {
				//connectIcon.gotoAndPlay("off");
				btnWith.visible = false;
			}

			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
		}
		/*if(data.ping=="0"){
			connectIcon.gotoAndPlay("off")
		}else{
			connectIcon.gotoAndPlay("on")
		}*/
		//차단관련
		if(data.block=="0"){
			//
			blockIcon._visible=false
		}else if(data.block=="1"){
			offBlack._visible = true;
			noticeMc._visible = false;
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}			
			//
			txtName.htmlText = data.username;
			txtServer.text = "";
			txtChannel.text = "";
			txtRoomNo.text = "";
			//
			connectIcon._visible = false;
			
			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
			btnWith.visible = false;
			blockIcon._visible=true
		}
		
		if(data.FacebookCase==""||data.FacebookCase==null||data.FacebookCase=="0"){
			facebookIcon.gotoAndStop(1);
		}
		if(data.FacebookCase=="1"){
			facebookIcon.gotoAndStop(2);
		}
		if(data.FacebookCase=="2"){
			facebookIcon.gotoAndStop(3);
		}
		
	/*	if(data.FacebookName==""||data.FacebookName==null){
			facebookNick.text=""			
		}else{
			facebookNick.text=data.FacebookName
			txtServer.text=""
			txtChannel.text=""
			txtRoomNo.text=""
		}*/
		
	}


	private function updateAfterStateChange():Void {
		_imgNick = data.userimage;
		_imgGrade = data.rank;
		var userImgPath="img://Imgset_Personal."+data.userimage
		_idx = String(this.index);
		btnWith._visible = false;
		if (data.loading == "1") {
			//loadingIcon._visible=true
			loadingIcon.gotoAndPlay("open");
		} else {
			loadingIcon.gotoAndPlay("close");
		}

		if (data.server.length>6) {
			var sp = data.server.substring(0, 5);
			_ch0 = sp+"..";
		} else {
			_ch0 = data.server;
		}

		if (data.channel.length>6) {
			var sp = data.channel.substring(0, 5);
			_ch1 = sp+"..";
		} else {
			_ch1 = data.channel;
		}
		if (data.room.length>6) {
			var sp = data.room.substring(0, 5);
			_ch2 = sp+"..";
		} else {
			_ch2 = data.room;
		}

		if(friendChk){
			trace ("===== n call ==== friend ===")
			offBlack.gotoAndStop(1)
			bg._visible=true
			bg1._visible=false
		}else{
			trace ("===== n call ==== clan ===")
			offBlack.gotoAndStop(2);
			bg1._visible=true
			bg._visible=false
		}
		
		if (data.online == "0") {
			offBlack._visible = true;
			noticeMc._visible = false;
			
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}
			//
			txtName.htmlText = data.username;
			txtServer.text = "";
			txtChannel.text = "";
			txtRoomNo.text = "";
			//
			connectIcon._visible = false;
			
			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}

			btnWith.visible = false;
		} else if (data.online == "1") {
			offBlack._visible = false;
			if (Number(data.notice)>0) {
				noticeMc._visible = true;
				noticeMc.txt.text = data.notice;
			} else {
				noticeMc._visible = false;
			}
			if(friendChk){
				bg.gotoAndStop(1);
			}else{
				bg1.gotoAndStop(1);
			}
			txtName.htmlText = data.username;
			txtServer.text = _ch0;
			txtChannel.text = _ch1;
			txtRoomNo.text = _ch2;
			
			connectIcon._visible = true;

			if (data.playwith == "1") {
				//connectIcon.gotoAndPlay("on");
				btnWith.visible = false;
			} else {
				//connectIcon.gotoAndPlay("off");
				btnWith.visible = false;
			}
			
			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}
		}
		/*if(data.ping=="0"){
			connectIcon.gotoAndPlay("off")
		}else{
			connectIcon.gotoAndPlay("on")
		}*/
		//차단관련
		if(data.block=="0"){
			blockIcon._visible=false			
		}else if(data.block=="1"){
			offBlack._visible = true;
			noticeMc._visible = false;
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}			
			//
			txtName.htmlText = data.username;
			txtServer.text = "";
			txtChannel.text = "";
			txtRoomNo.text = "";
			//
			connectIcon._visible = false;

			lvLoader(userImgPath,imgNick);
			lvLoader(gradeImgPath,imgGrade);
			if(clanmarkChk=="#"){
				lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
			}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
				//
			}else{
				clanmarkChk="@";
				lvLoader(_clanImg,clanImg["tg"]);
			}

			btnWith.visible = false;
			blockIcon._visible=true
		}
		
		if(data.FacebookCase==""||data.FacebookCase==null||data.FacebookCase=="0"){
			facebookIcon.gotoAndStop(1);
		}
		if(data.FacebookCase=="1"){
			facebookIcon.gotoAndStop(2);
		}
		if(data.FacebookCase=="2"){
			facebookIcon.gotoAndStop(3);
		}
		
		/*if(data.FacebookName==""||data.FacebookName==null){
			facebookNick.text=""			
		}else{
			facebookNick.text=data.FacebookName
			txtServer.text=""
			txtChannel.text=""
			txtRoomNo.text=""
		}*/
	}

	private function lvLoader(imgPath:String, imgMc:MovieClip) {
		var ImgMc = imgMc;
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPath,imgMc);
	}

	private function onLoadInit(mc:MovieClip) {
		//trace(mc._name);
		if (mc._name == "imgNick") {
			//mc._width=mc._height=64
		} else if (mc._name == "imgGrade") {
			mc.set_level(_imgGrade)
			mc._xscale = 80;
			mc._yscale = 80;
		}else if(mc._name=="tg"){
			if(clanmarkChk=="#"){
				var sym:String = _clanImg.substr(1,5);
				var dec:String = _clanImg.substr(6,3);
				var back:String = _clanImg.substr(9,3);
				//trace (rank+"\n" + sym+"\n"+dec+"\n"+back)	
				mc.symbolMc.setSymbolPic(sym);
				mc.decoMc.setDecoPic("D"+dec);
				mc.backMc.setBackPic("B"+back);	
				mc._x=2;
				mc._y=5;
				mc._xscale = 70;
				mc._yscale = 70;
			}else if(clanmarkChk=="@"){
				mc._x=2
				mc._y=5;
				mc._xscale = 70
				mc._yscale = 70
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

		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.addEventListener("itemDoubleClick",this,"onMsnDblClick");

		/*
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		*/
		btnWith.visible = false;
		btnWith.addEventListener("click",this,"onWithClickButton");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}

		focusTarget = owner;
	}



	public function draw() {
		super.draw();

	}

	private function onWithClickButton(e:Object) {
		_global.messenger_OnClickPlayWith(this.index);
	}

	/*
	private function onMsnDblClick(e:Object){
	trace("dbl = "+_idx);
	_global.messenger_OnDoubleClickFriend(_idx);
	}
	*/

	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {
		//
		var root:MovieClip = _parent._parent._parent._parent;
		//trace(root._name);
		root.resetBtnWith();
		root.listIdx = _idx;
		/*if (root.cbList)
		{
		root.messenger_ClosePopup();
		}*/
		root.listPozY = this._y;
		root.listItemPozY = this._parent._y;
		_global.messenger_OnRolloverFriendsList(_idx);
		if (data.online != "0") {
			if(friendChk){
				bg.gotoAndStop(2);
			}else{
				bg1.gotoAndStop(2);
			}
		} else {
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}			
		}
		if (data.online == "1") {
			if (data.playwith == "1") {
				btnWith.visible = true;
			} else {
				btnWith.visible = false;
			}
		} else {
			btnWith.visible = false;
		}
	}

	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		var root:MovieClip = _parent._parent._parent._parent;
		//root.resetBtnWith()
		//trace ("listPozY : "+this.index)
		/*var root:MovieClip = _parent._parent._parent._parent._parent._parent
		root.listIdx = _idx;*/
		if (data.online != "0") {
			if(friendChk){
				bg.gotoAndStop(1);
			}else{
				bg1.gotoAndStop(1);
			}
		} else {
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}	
		}

	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		var root:MovieClip = _parent._parent._parent._parent;
		root.listPozY = this._y;
		root.listIdx = _idx;

		if (data.online != "0") {
			if(friendChk){
				bg.gotoAndStop(2);
			}else{
				bg1.gotoAndStop(2);
			}
		} else {
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}	
		}
	}

	private function handleMouseRelease(mouseIndex:Number, button:Number):Void {
		if (data.online != "0") {
			if(friendChk){
				bg.gotoAndStop(2);
			}else{
				bg1.gotoAndStop(2);
			}
		} else {
			if(friendChk){
				bg.gotoAndStop(3);
			}else{
				bg1.gotoAndStop(3);
			}			
		}

		if (_disabled) {
			return;
		}
		clearInterval(buttonRepeatInterval);
		delete buttonRepeatInterval;

		if (doubleClickEnabled) {
			if (doubleClickInterval == null) {
				doubleClickInterval = setInterval(this, "doubleClickExpired", doubleClickDuration);
				//trace("yyyy");
			} else {
				doubleClickExpired();
				//dispatchEventAndSound({type:"doubleClick", controllerIdx:controllerIdx, button:button});
				setState("release");
				_global.messenger_OnDoubleClickFriend(_idx);
				return;
			}
		}
	}
}