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
import gfx.controls.Button;
import flash.external.ExternalInterface;

class com.scaleform.sf2.lobby.clanlist.ClanListInviteListItem extends ListItemRenderer {
	private var txt_name:TextField;	
	private var txt_master:TextField;
	private var txt_recom:TextField;
	private var txt_day:TextField;
	private var imgBox:MovieClip;
	private var btnJoin:Button;
	private var btnRefuse:Button;
	private var _hit:MovieClip;	

	private var _cname:String;
	private var _cmaster:String;
	private var _rname:String;
	private var _rday:String;

	private var mcArray=["txt_name","txt_master","txt_recom","txt_day"]

	private var clanImg:MovieClip;
	private var clanMarkId:String;
	private var clanmarkChk:String;
	private var AniMarkId:String;
	private var clanEff:MovieClip;
	private var bg:MovieClip;

	private var _imgPathClanSmall:String="gfx_imgset_clanMark.swf"
	

	public function ClanListInviteListItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		this._visible = true;
		super.setData(data);

		//trace("sdxf = "+index % 2)
		if(index % 2 == 1){
			bg.gotoAndStop(2)
		}else{
			bg.gotoAndStop(1)
		}

		_cname  = data.Cname
		_cmaster = data.Cmaster
		_rname  = data.RecomName
		_rday   = data.RecomDay

		UpdateTextFields();
	}

	private function lvLoader (caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);
			
		if(caseBy=="clanImg"){	
			if(clanmarkChk=="#"){
				mcLoader.loadClip (_imgPathClanSmall,clanImg["tg"]);
			}else{
				if (_global.gfxPlayer)
				{
					clanMarkId = "gfxImgSet/" + clanMarkId + ".png";
				}else{
					clanMarkId = clanMarkId;
				}

				mcLoader.loadClip (clanMarkId,clanImg["tg"]);
			}			
		}
		
		if(caseBy=="clanEff"){
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
				imgAniMarkBox = "ClanMarkAni/A" + img + ".swf";
			}
			trace("imgAniMarkBox ====================" + imgAniMarkBox);
			mcLoader.loadClip(imgAniMarkBox,clanEff["eff"]);
	
			if (Number(pos) < 10)
			{
				locNo = pos.charAt(1)
			}
			else
			{
				locNo = pos
			}			
			clanEff["eff"]._y = aniPos[locNo];				
		}
	}
	private function onLoadInit (mc:MovieClip)
	{
		if(mc._name="tg")
		{
			if(clanmarkChk=="#"){
				var sym:String = clanMarkId.substr(1,5)
				var dec:String = clanMarkId.substr(6,3);
				var back:String = clanMarkId.substr(9,3);
				//trace (rank+"\n" + sym+"\n"+dec+"\n"+back)	
				
				mc.symbolMc.setSymbolPic(sym)
				mc.decoMc.setDecoPic("D"+dec)
				mc.backMc.setBackPic("B"+back)				
			}else if(clanmarkChk=="@"){
				
			}
			mc._xscale=mc._yscale=90;
		}else{
			
		}
	}
	

	public function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}
		validateNow();
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function UpdateTextFields()
	{	
		txt_name.htmlText=_cname;
		txt_master.htmlText=_cmaster;
		txt_recom.htmlText=_rname;
		txt_day.text=_rday;

		clanMarkId = data.ClanMark;//클랜마크"100001000004"//
		clanmarkChk=clanMarkId.charAt(0)
		
		if(clanmarkChk=="#"){
			clanImg["clanBg"]._visible=false
			lvLoader("clanImg");
		}else if(clanmarkChk=="" ||clanmarkChk==undefined ){
			clanImg["clanBg"]._visible=true
		}else{
			clanmarkChk="@";
			clanImg["clanBg"]._visible=false			
			lvLoader("clanImg");
		}	
		
		
		if(AniMarkId=="" || AniMarkId==null){
			clanEff._visible=false
		}else{
			clanEff._visible=true
			lvLoader("clanEff");
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
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

		btnJoin.addEventListener("click",this,"joinClickHandler");
		btnRefuse.addEventListener("click",this,"refuseClickHandler");
	
		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;

		for(var i:Number=0;i<mcArray.length;i++){
			this[mcArray[i]].textAutoSize="shrink"
			this[mcArray[i]].verticalAlign="center"
			this[mcArray[i]].noTranslate=true
		}
		btnJoin.label="_clanInvite_join";
		btnRefuse.label="_clanInvite_refuse";
	}

	public function draw() {
		super.draw();

	}
	private function joinClickHandler(e:Object):Void{
		ExternalInterface.call("clanInvite_JoinClicked",this.index)
	}
	private function refuseClickHandler(e:Object):Void {
		ExternalInterface.call("clanInvite_refuseClick",this.index)
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
}