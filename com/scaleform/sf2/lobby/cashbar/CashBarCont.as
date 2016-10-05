/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import gfx.controls.Button;

class com.scaleform.sf2.lobby.cashbar.CashBarCont extends UIComponent
{
	public var tpMC:MovieClip;
	public var cashMc:MovieClip;
	public var spMc:MovieClip;
	public var channelingVar:String;
	public var localVar:String;
	public var miconPath:String = "gfx_imgset_money.swf";
	public var tpBuyBtn:MovieClip;

	public var iconName:Array = [null, "SP", "CASH", "TP", "SP_J", "CASH_J", "CASH_NAVER", "CASH_HANGAME", "CASH_USA", "TP_USA"];
	public var MIcon:MovieClipLoader;

	public function CashBarCont()
	{
		super();
	}

	private function onLoadInit(mc:MovieClip)
	{
		trace ("_INVEN === "+ _root.ChannelIndex+"\n"+_root.LanguageIndex)
		
		if (mc._parent._name == "spMc")
		{
			channelingVar = _root.ChannelIndex;
			localVar = _root.LanguageIndex;

			if (channelingVar == "NAVER")
			{
				cashMc.spIcon.gotoAndStop(iconName[6]);
			}
			else if (channelingVar == "HANGAME")
			{
				cashMc.spIcon.gotoAndStop(iconName[7]);
			}
			else
			{
				if (localVar == "JPN")
				{
					cashMc.spIcon.gotoAndStop(iconName[5]);
				}
				else if (localVar == "USA")
				{
					cashMc.spIcon.gotoAndStop(iconName[8]);
				}
				else
				{
					cashMc.spIcon.gotoAndStop(iconName[2]);
				}
			}

			tpMC._visible = false;
			tpBuyBtn._visible = false;

			if (localVar == "KOR")
			{
				spMc.spIcon.gotoAndStop(iconName[1]);
			}
			else if (localVar == "JPN")
			{
				spMc.spIcon.gotoAndStop(iconName[4]);
			}
			else if (localVar == "CHN")
			{
				tpMC._visible = true;
				tpBuyBtn._visible = true;

				spMc.spIcon.gotoAndStop(iconName[1]);
				tpMC.spIcon.gotoAndStop(iconName[3]);
			}
			else if (localVar == "USA")
			{
				tpMC._visible = true;
				tpBuyBtn._visible = true;

				tpMC.spIcon.gotoAndStop(iconName[9]);
				spMc.spIcon.gotoAndStop(iconName[1]);
			}
		}
	}

	public function setCash(spTxt:String, cashTxt:String, tpTxt:String)
	{
		trace ("_INVEN setCash === "+ spTxt+"\n"+cashTxt)
		
		tpMC["txt"].text = tpTxt;
		cashMc["txt"].text = cashTxt;
		spMc["txt"].text = spTxt;
	}

	private function configUI():Void
	{
		super.configUI();

		MIcon = new MovieClipLoader();
		MIcon.addListener(this);

		MIcon.loadClip(miconPath,tpMC.spIcon);
		MIcon.loadClip(miconPath,cashMc.spIcon);
		MIcon.loadClip(miconPath,spMc.spIcon);
	}
}