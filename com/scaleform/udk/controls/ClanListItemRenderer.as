/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import gfx.utils.Constraints;
import gfx.controls.CoreList;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ClanListItemRenderer extends ListItemRenderer
{


	public var index:Number;
	public var owner:CoreList;
	public var selectable:Boolean = true;

	private var txt1:TextField;
	private var txt2:TextField;
	private var txt3:TextField;

	private var _CSN:String;
	private var _img:String;
	private var clanImg:MovieClip;
	private var btnType:MovieClip;
	private var _hit:MovieClip;
	private var overMC:MovieClip;
	
	private var top10Icon:MovieClip;
	
	private var clanMarkId:String;
	private var clanmarkChk:String;
	private var AniMarkId:String;
	private var clanEff:MovieClip

    //private var urlPath:String="gamedir://\\FlashMovie\\image\\imgset\\"
	//private var urlPath:String="gfxImgSet/"
	private var _imgPathClanSmall:String="gfx_imgset_clanMark.swf"
	//private var _imgPathClanSmall:String="img://Imgset_Clanmark.swf"
	public function ClanListItemRenderer ()
	{
		super ();
		//txt1.noTranslate = true;
		txt2.noTranslate = true;
		txt3.noTranslate = true;
	}

	public function setData (data:Object):Void
	{
		//trace (data);

		if (data == undefined)
		{
			this._visible = false;
			return;
		}

		this.data = data;
		invalidate ();
		this._visible = true;
		super.setData (data);

		trace ("Clan List = " + data.ClanMark)
		
		if(index % 4 == 2 || index % 4 == 3) { _hit.gotoAndStop(2); overMC.gotoAndStop(2); }
		
		txt1.htmlText =""
		txt2.text =""
		txt3.text =""
		//trace ("///////////" + data.CSN);


		_CSN = data.CSN;//클랜번호
		txt1.htmlText = data.ClanName;//클랜이름
		txt2.text = data.MasterName;//클랜마스터코드네임1

		//Type = 0 회원수로 보기. Type = 1 점수로 보기, Type = 2 날짜로 보기.
	
	//0 : 점수 1 : HOT 2 : 신규
		if (data.Type == 0)
		{
			txt3.text = data.Jumsu;
		}
		else if (data.Type == 1)
		{
			txt3.text = data.MemberCount;
		}
		else if (data.Type == 2)
		{
			txt3.text = data.ClanFoundationDay;
		}
		else if (data.Type == 3)
		{
			txt3.text = data.MemberCount;
		}
		else if (data.Type == "" || data.Type == null )
		{
			txt3.text = "-------";
		}
		
		
		trace("data.Type"+data.Type);

		//클랜가입여부
		// 클랜원레벨(0 : 대기회원, 10 : 일반, 20 : 정규, 30 : 운영진, 40 : 마스터)
		if (data.IsJoinBtn == 1)
		{
			//
			btnType.gotoAndStop (1);
			btnType.textField.text = "_clanTxt_joinBtn";
		}
		else if (data.IsJoinBtn == 0)
		{
			//
			btnType.gotoAndStop (2);
		}

		//_img = data.ClanMark;//클랜마크
		
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
		
		AniMarkId=""
		
		if(AniMarkId=="" || AniMarkId==null){
			clanEff._visible=false
		}else{
			clanEff._visible=true
			lvLoader("clanEff");
		}
		
		
		if (clanMarkId)
		{
			UpdateTextFields ();
		}
		//_take = data.Take;  
		
		//-------------------------------------------------- 상위 10 위 아이콘으로 표시하기
		if(data.Top10Icon != "0" || data.Top10Icon != 0){
			top10Icon.gotoAndStop(data.Top10Icon);
			//top10Icon.gotoAndStop(1);
		}else {
			top10Icon.gotoAndStop(11);
		}
	}
	
	public function updateAfterStateChange ():Void
	{
		
	}
	
	private function lvLoader (caseBy:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader ();
		mcLoader.addListener (this);
			
		if(caseBy=="clanImg"){	
			if(clanmarkChk=="#"){
				mcLoader.loadClip (_imgPathClanSmall,clanImg["tg"]);
			}else{
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
				
				mc._x=2
				mc._y=2;
				mc._xscale = 90
				mc._yscale = 90
				
			}else if(clanmarkChk=="@"){
				mc._x=2
				mc._y=2;
				mc._xscale = 90
				mc._yscale = 90
			}
		}else{
			
		}
	}
	
	private function UpdateTextFields ()
	{
		_CSN = data.CSN;//클랜번호
		txt1.htmlText = data.ClanName;//클랜이름
		txt2.text = data.MasterName;//클랜마스터코드네임1
		
		if (data.Type == 0)
		{
			txt3.text = data.Jumsu;
		}
		else if (data.Type == 1)
		{
			txt3.text = data.MemberCount;
		}
		else if (data.Type == 2)
		{
			txt3.text = data.ClanFoundationDay;
		}
		else if (data.Type == 3)
		{
			txt3.text = data.MemberCount;
		}
		else if (data.Type == "" || data.Type == null )
		{
			txt3.text = "-------";
		}
		
		
		if (data.IsJoinBtn == 1)
		{
			btnType.gotoAndStop (1);
			btnType.textField.text = "_clanTxt_joinBtn";
		}
		else if (data.IsJoinBtn == 0)
		{
			btnType.gotoAndStop (2);
		}
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

		btnType.onRollOver = Delegate.create (this, onChkHandler1);
		btnType.onRollOut = Delegate.create (this, onChkHandler2);
		btnType.onRelease = Delegate.create (this, onChkHandler3);
		btnType.onReleaseOutside = Delegate.create (this, onChkHandler3);
		btnType.onPress = Delegate.create (this, onChkHandler);
		_hit.onPress = Delegate.create (this, onChkHandler4);
		
		_hit.onRollOver = Delegate.create (this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create (this, handleMouseRollOut);
		_hit.onDragOver = Delegate.create (this, handleMouseRollOver);
		_hit.onDragOut = Delegate.create (this, handleMouseRollOut);
		_hit.onReleaseOutside = Delegate.create (this, handleMouseRollOut);

	}
	
	public function draw()
	{
		super.draw();

	}
	//----- 가입 버튼 클릭
	private function onChkHandler1 (e:Object)
	{
		btnType.btn.gotoAndStop("over");
	}
	private function onChkHandler2 (e:Object)
	{
		btnType.btn.gotoAndStop("up");
	}
	private function onChkHandler3 (e:Object)
	{
		btnType.btn.gotoAndStop("up");
	}
	private function onChkHandler (e:Object)
	{
		
		btnType.btn.gotoAndStop("down");
		//클랜가입여부
		if (data.IsJoinBtn == 1)
		{
			//가입안함
			_global.ClanList_ClickClanJoin (_CSN);
			trace ("----ClanList_ClickClanJoin----");
		}
		else if (data.IsJoinBtn == 0)
		{
			//가입함
			_global.ClanList_ClickClanList (_CSN);
			trace ("----ClanList_ClickClanList----");
		}
		
	}
	
	private function onChkHandler4 (e:Object)
	{
		_global.ClanList_ClickClanList (_CSN);
		trace ("----ClanList_ClickClanJoin----");
	}
	
	private function handleMouseRollOver (mouseIndex:Number, button:Number):Void
	{
		setState ("over");
	}
	private function handleMouseRollOut (mouseIndex:Number, button:Number):Void
	{
		setState ("out");
	}
}