
import com.scaleform.udk.utils.UDKUtils;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.controls.Button;
//import com.scaleform.udk.controls.FocusItemRenderer;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import mx.transitions.easing.Strong;
import gfx.motion.Tween;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ScoreboardItemRenderer_pve extends ListItemRenderer {

	private var classicon:MovieClip;
	private var mastericon:MovieClip;

	private var numbericon:MovieClip;

	private var codename:TextField;
	private var money:TextField;
	private var kill:TextField;

	private var ping:MovieClip;
	private var pingTxt:TextField;
	private var iconMeMc:MovieClip;
	private var clanImg:MovieClip;
	
	private var _classicon:String;
	private var _mastericon:String;
    private var _clanImg:String;
	private var _codename:String;
	private var _money:String;
	private var _kill:String;
	private var _assist:String;
	private var _weak:String;
	private var _save:String;
	private var _ping:String;
	private var _pingTxt:String;
	private var _iconmemc:String;
	private var _medeath:String;
	private var mcLoader:MovieClipLoader;
	private var starMc:MovieClip;
	private var urlPath = "";
	//private var urlPath="gfxImgSet/";
	private var imgClanMarkSmallPath:String = urlPath+"gfx_imgset_clanMark_small.swf";
	private var imgPathClass:String = urlPath+"imgset_class.swf";
	private var clanmarkChk:String;
	
	private var clanEff:MovieClip;
    private var AniMarkId:String;
    private var _shooterMode:String;
	
	// Initialization:
	public function ScoreboardItemRenderer_pve() {
		super();
		numbericon._visible = false;
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}

		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);


		_medeath = data.MeDeath;
		_iconmemc = data.MeIcon;
		_classicon = data.ClassIcon;
		_mastericon = data.MasterIcon;

		_codename = data.CodeName;
		_money = data.Money;
		_kill = data.Kill;
		_assist = data.Assist;
		_weak = data.Weak;
		_save = data.Save
		_ping = data.Ping;
		_pingTxt=data.PingTxt
		_clanImg = data.ClanImg;
		_shooterMode=data.ShootEnabled;
		
		clanmarkChk = _clanImg.charAt(0);
		
		if (clanmarkChk == "#") {
			clanImg["clanBg"]._visible = false;
		} else if (clanmarkChk == "" || clanmarkChk == undefined) {
			clanImg["clanBg"]._visible = true;
		} else {
			clanmarkChk = "@";
			clanImg["clanBg"]._visible = false;
		}
		
		AniMarkId=data.ClanEffect
		
		UpdateTextFields();
	}

	private function lvLoader(target,mc) {
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(target,mc);
	}

	private function unLoader() {
		mcLoader.unloadClip(classicon);
	}

	private function onLoadInit(mc:MovieClip) {
		if (mc._name == "classicon") {
			var lvNo:String = _classicon;
			
			classicon.set_level(lvNo)		

			var apNum:Number;
			if (_medeath == "1") {
				apNum = 40;
			} else {
				apNum = 100;				
			}
			mastericon._alpha = apNum;
			classicon._alpha = apNum;
			ping._alpha = apNum;
			codename._alpha = apNum;
			money._alpha = apNum;
			kill._alpha = apNum;
			numbericon._alpha = apNum;
		} else if (mc._name == "tg") {
			if (clanmarkChk == "#") {
				var sym:String = _clanImg.substr(1, 5);
				var dec:String = _clanImg.substr(6, 3);
				var back:String = _clanImg.substr(9, 3);
				//trace (rank+"\n" + sym+"\n"+dec+"\n"+back)
				mc.symbolMc.setSymbolPic(sym)
				mc.decoMc.setDecoPic("D"+dec)
				mc.backMc.setBackPic("B"+back)
				mc._x = 4;
				mc._y = 3;
				mc._xscale = 70;
				mc._yscale = 70;
			} else if (clanmarkChk == "@") {
				mc._x = 4;
				mc._y = 3;
				mc._xscale = 70;
				mc._yscale = 70;
			}
			
			if (_medeath == "1") {
				clanImg._alpha = 40;
			} else {
				clanImg._alpha = 100;
			}
		}
	}

	// This method is fired after the state has changed to allow the component to ensure the state is up-to-date.  For instance, updating the contraints in Button.
	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}

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
		//_hit.onRollOver = Delegate.create(this, handleMouseRollOver);              
		//_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		//_hit.onPress = Delegate.create(this, handleMousePress);
		//_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.onDragOver = Delegate.create(this, handleDragOver);
		//_hit.onDragOut = Delegate.create(this, handleDragOut);
		//_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		this.disableFocus = true;

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		pingTxt.verticalAlign="center";
		pingTxt.textAutoSize="shrink";
	}

	// Private Methods:    
	private function UpdateTextFields() {
		var fontColor:String;
		var fontEnd:String = "</font>";
		var killTxt:String;
		if (_iconmemc == "1") {
			iconMeMc.gotoAndPlay("open");
		} else {
			iconMeMc.gotoAndStop(2);
		}
		if (_medeath == "1") {
			fontColor = "<font color='#cccccc' ALPHA='#90'>";
		} else {
			fontColor = "<font color='#ffffff' ALPHA='#FF'>";
		}
		mastericon.gotoAndStop(Number(_mastericon)+1);
		codename.htmlText = fontColor+_codename+fontEnd;
		money.htmlText = fontColor+_money+fontEnd;

		if (_shooterMode == null || _shooterMode == "1") {
			if (_weak == undefined || _weak == "") {
				killTxt=fontColor+_kill+" / "+_assist+" / "+_save+fontEnd;
			}else {
				killTxt=fontColor+_kill+" / "+_assist+" / "+_weak+" / "+_save+fontEnd;	
			}
			
		}else{
			killTxt=fontColor+_kill+" / "+_assist+fontEnd;			
		}

		kill.htmlText = killTxt;
		ping.gotoAndStop(Number(_ping)+1);
		if(_pingTxt==null||_pingTxt==""){
			pingTxt._visible=false;
			pingTxt.text="";
			ping._x=350;
			pingTxt._x=364;
		}else{
			pingTxt._visible=true;
			pingTxt.text=_pingTxt;
			ping._x=337;
			pingTxt._x=345;
			if(Number(_ping)==0){
				pingTxt.textColor=0xFF0101;
			}else if(Number(_ping) == 1){
				pingTxt.textColor=0xFF9C00;
			}else if(Number(_ping) >= 2){				
				pingTxt.textColor=0x24F600;
			}
		}
		var apNum:Number;
		//
		if (_classicon.charAt(0) == "R") {
			unLoader();
			numbericon._visible = true;
			numbericon.gotoAndStop(2);
			numbericon["txtNo"].text = _classicon.substring(1);
			if (_medeath == "1") {
				//this._alpha=40
				apNum = 40;		
			} else {
				//this._alpha=100
				apNum = 100;
			}
		} else if (_classicon.charAt(0) == "B") {
			unLoader();
			numbericon._visible = true;
			numbericon.gotoAndStop(3);
			numbericon["txtNo"].text = _classicon.substring(1);
			if (_medeath == "1") {
				//this._alpha=40
				apNum = 40;
			} else {
				//this._alpha=100
				apNum = 100;
			}
		} else {
			numbericon._visible = false;
			lvLoader(imgPathClass,classicon);	
		}

		mastericon._alpha = apNum;
		classicon._alpha = apNum;
		ping._alpha = apNum;
		pingTxt._alpha =apNum;
		codename._alpha = apNum;
		money._alpha = apNum;
		kill._alpha = apNum;
		numbericon._alpha = apNum;

		if(clanmarkChk=="#"){
			lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
		}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
			//
		}else{
			clanmarkChk="@";
			lvLoader(_clanImg,clanImg["tg"]);
		}						
		//
		var root = _parent._parent._parent;
		if (root.personalMode == 1) {
			starMc.gotoAndStop(this.index+2);
		} else {
			starMc.gotoAndStop(1);
		}
		
		if(AniMarkId=="" || AniMarkId==null){
			clanEff._visible=false
		}else{
			clanEff._visible=true
			//var aniPos = [0,-2, 16, 32];
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
			
			//clanEff["eff"]._y = aniPos[locNo];		
			//trace("imgAniMarkBox ====================" + imgAniMarkBox);			
			lvLoader(imgAniMarkBox,clanEff["eff"]);
		}
	}
}