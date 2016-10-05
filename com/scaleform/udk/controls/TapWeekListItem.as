/**
 * ...
 * @author 
 */
 
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.TapWeekListItem extends ListItemRenderer 
{
	private var mcLoader:MovieClipLoader;
	private var icon_star:MovieClip	
	private var txt_clanName:TextField;
	private var txt_clanMasterName:TextField;
	private var txt_clanPoint:TextField;
	private var txt_clanRankNo:TextField;

	private var clanImg:MovieClip;
	private var clanEff:MovieClip;

    private var _icon:String;
    private var _cmark:String;
    private var _cname:String;
    private var _cmname:String;
    private var _cp:String;
    private var _cno:String;

	private var AniMarkId:String;
	private var clanmarkChk:String

	public function TapWeekListItem() {
		super();
	}	

	public function toString():String
	{
		return "[SF2_dialogWeeklyClanRank_itemRenderer_" + _name + "]";
	}	

	public function setData(data:Object):Void
	{
		// If we received null data, hide this renderer.
		if (data == undefined) {
			this._visible = false;
			return;
		}

		this.data = data;

		if(data.ClanName==null||data.ClanName==""){
			this._visible = false;
			return
		}

		invalidate();
		this._visible = true;

		_cname    = data.ClanName;
		_icon     = data.GradeIcon;
		_cmark    = data.ClanMark;		
        _cmname   = data.MasterName;
        _cp       = data.ClanPoint;
        _cno      = data.ClanGradeNo;
        AniMarkId = data.ClanEffect;

        trace ("Data ClanMark = "+_cmark)
        
        clanmarkChk = _cmark.charAt(0);
		
		UpdateTextFields()
	}

	private function UpdateTextFields()
	{		
		icon_star.gotoAndStop("grade"+_icon)
		txt_clanName.htmlText=_cname;
		txt_clanMasterName.htmlText=_cmname;
		txt_clanPoint.text=_cp;
		txt_clanRankNo.htmlText=_cno

		//==============
		//
		//==============
		if (clanmarkChk == "#")
		{
			var imgClanMarkSmallPath:String

			if (_global.gfxPlayer)
			{
				imgClanMarkSmallPath = "gfxImgSet/gfx_imgset_clanMark_small.swf";
			}
			else
			{
				imgClanMarkSmallPath = "gfx_imgset_clanMark_small.swf"
			}	

			lvLoader(imgClanMarkSmallPath,clanImg["tg"]);
		}
		else if (clanmarkChk == "" || clanmarkChk == undefined)
		{
			//
		}
		else
		{
			clanmarkChk = "@";
			lvLoader(_cmark,clanImg["tg"]);
		}

		//==============
		//
		//==============
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

			lvLoader(imgAniMarkBox,clanEff["eff"]);
		}
	}

	private function onLoadInit(mc:MovieClip)
	{
		if (mc._name == "tg")
		{
			if (clanmarkChk == "#")
			{
				var sym:String = _cmark.substr(1, 5);
				var dec:String = _cmark.substr(6, 3);
				var back:String = _cmark.substr(9, 3);
				//trace (rank+"\n" + sym+"\n"+dec+"\n"+back)
				mc.symbolMc.setSymbolPic(sym);
				mc.decoMc.setDecoPic("D" + dec);
				mc.backMc.setBackPic("B" + back);
			}
		}
	}

	private function lvLoader(path, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		mcLoader.loadClip(path,mc);
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

	private function configUI():Void
	{
		super.configUI();

		txt_clanName.verticalAlign       = "center"
		txt_clanMasterName.verticalAlign = "center"
		txt_clanPoint.verticalAlign      = "center"	
		txt_clanRankNo.verticalAlign      = "center"	

		txt_clanName.textAutoSize       = "shrink"
		txt_clanMasterName.textAutoSize = "shrink"
		txt_clanPoint.textAutoSize      = "shrink"	
		txt_clanRankNo.textAutoSize      = "shrink"
	}

	public function draw ()
	{
		super.draw ();
	}	
}