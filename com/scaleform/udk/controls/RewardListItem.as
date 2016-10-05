import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.RewardListItem extends ListItemRenderer
{

	private var txtConWeapon:MovieClip;
	private var imgBox:MovieClip;
	private var _ItemImg:String;
	private var _index:String;
	private var textEvent:MovieClip;
	private var mcLoader:MovieClipLoader;
	private var urlPath:String = "";
	private var imgPathUnit:String = urlPath + "gfx_imgset_unitbox.swf";
	private var imgPathImageSet:String = urlPath + "imgset_class.swf";
	private var markMC:MovieClip;
	private var RankTg:MovieClip;
	private var _Rank:String;
	private var _cash:String;
	private var _itemLength:String;
	private var numberTxt:MovieClip;

	public function RewardListItem()
	{
		super();
		textEvent._visible = false;
	}

	public function setData(data:Object):Void
	{

		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();
		this._visible = true;
		super.setData(data);

		_ItemImg = data.ImageURL;
		_index = data.Index;
		_cash = data.IconName;
		_itemLength = data.ItemLength;
		//인덱스 data.Index
		//이름 data.ItemImg
		//설명 data.ItemName
		//럭키포인트 data.ItemDay
		RankTg._visible = false;
		textEvent._visible = false;
		imgBox._visible = false;

		var cashIcon:String;
		var loc:String = _root.LanguageIndex;
		var channel:String = _root.ChannelIndex;
		if (_cash == "" || _cash == null)
		{
			txtConWeapon["txtName"].htmlText = data.Label;
		}
		else
		{
			//SP CASH TP
			if (loc == "KOR")
			{
				if (_cash == "CASH")
				{
					if (channel == "NAVER")
					{
						cashIcon = "<img src='SHOP_" + _cash + "_"+channel+"' vspace='-5'>";
					}
					else if (channel == "HANGAME")
					{
						cashIcon = "<img src='SHOP_" + _cash + "_"+channel+"' vspace='-5'>";
					}
					else
					{
						cashIcon = "<img src='SHOP_" + _cash + "' vspace='-5'>";
					}
				}else{
					cashIcon = "<img src='SHOP_" + _cash + "'vspace='-5'>";
				}
			}
			if(loc == "JPN"){
				cashIcon = "<img src='SHOP_" + _cash + "_" + loc + "' vspace='-5'>";
			}
			if(loc == "CHN"){
				cashIcon = "<img src='SHOP_" + _cash + "' vspace='-5'>";
			}
			if(loc == "USA"){
				if(_cash!="SP"){
					cashIcon = "<img src='SHOP_" + _cash + "_" + loc + "' vspace='-5'>";
				}else{
					cashIcon = "<img src='SHOP_" + _cash + "' vspace='-5'>";
				}
			}else{
				cashIcon = "<img src='SHOP_" + _cash + "' vspace='-5'>";
			}
			txtConWeapon["txtName"].htmlText = cashIcon + data.Label;
		}



		if (data.ItemInfo == "" || data.ItemInfo == "0" || data.ItemInfo == null)
		{
			txtConWeapon["txtDay"].htmlText = "";
		}
		else
		{
			txtConWeapon["txtDay"].htmlText = data.ItemInfo;
		}

		if (data.Index == "5")
		{
			textEvent._visible = true;
			textEvent["txt"].text = data.Label;
		}
		else
		{
			lvLoader(data.Index);
		}
		if (data.Rank == "0000" || data.Rank == "" || data.Rank == undefined)
		{
			RankTg._visible = false;
			if (mcLoader.loadClip(imgPathImageSet, RankTg))
			{
				mcLoader.unloadClip(RankTg);
			}
		}
		else
		{
			_Rank = data.Rank;
			RankTg._visible = true;
			lvLoader("00");
		}
		
		//-- 아이템 보유겟수 표시
		if (_itemLength == "" || _itemLength == "0") {
			numberTxt._visible = false;
		} else {
			numberTxt._visible = true;
			numberTxt.text = _itemLength;
		}

	}
	private function lvLoader(n:String)
	{
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);

		if (n == "00")
		{
			mcLoader.loadClip(imgPathImageSet,RankTg);
		}
		else
		{
			var imgPathArmor:String = UDKUtils.ArmorImgPath+ _ItemImg;
			var imgPathWeapon:String;
			var imgPathCashItem:String;
			var imgPathUnit:String="img://Imgset_Uint."+ _ItemImg;
			var itemName = _ItemImg;
			var len = itemName.length;
			var mark:String = itemName.slice(-4, -1);
			var markNum:Number = Number(itemName.slice(-1));
			if (mark == "_mk" && !isNaN(markNum))
			{
				itemName = itemName.slice(0, -4);
				markMC.gotoAndStop(markNum);
			}
			else
			{
				markMC.gotoAndStop(1);
			}

			if (_global.gfxPlayer)
			{
				imgPathUnit = "gfxImgSet/gfx_imgset_unitbox.swf";
				imgPathArmor = "gfxImgSet/Armor/" + _ItemImg + ".png";
				imgPathCashItem = "gfxImgSet/CashItem/" + itemName + ".png";
				imgPathWeapon = "gfxImgSet/Weapon/" + itemName + ".png";
			}
			else
			{
				var chk:String = itemName.substr(-4);
				if (chk == "_ani") {
					imgPathCashItem = UDKUtils.CashImgAniPath+itemName
					imgPathWeapon = UDKUtils.WeaponImgAniPath+itemName
				} else {
					imgPathCashItem = UDKUtils.CashImgPath+itemName;
					imgPathWeapon = UDKUtils.WeaponImgPath+itemName;
				}
				
			}

			if (n == "0")
			{
				mcLoader.loadClip(imgPathArmor,imgBox.tgMc);
			}
			else if (n == "1")
			{
				mcLoader.loadClip(imgPathWeapon,imgBox.tgMc);
			}
			else if (n == "2")
			{
				mcLoader.loadClip(imgPathUnit,imgBox.tgMc);
			}
			else if (n == "3")
			{
				mcLoader.loadClip(imgPathCashItem,imgBox.tgMc);
			}
		}

	}
	private function onLoadInit(mc:MovieClip)
	{
		//trace (mc._name +",,,,"+data.Index+",,,"+data.ItemImg)
		if (mc._name == "RankTg")
		{
			var lvNo:String = _Rank;
			var KD:String = lvNo.charAt(0);
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
			var rIndex1:Number;
			var rIndex2:Number;
			rIndex1 = Number(CL) + 1;
			rIndex2 = Number(LV) + 1;
			RankTg.lv0.gotoAndStop(rIndex1);
			RankTg.lv1.gotoAndStop(rIndex2);
		}
		else if (mc._name == "tgMc")
		{
			imgBox._visible = true;
			//var mc:MovieClip=imgBox.tgMc
			mc._xscale = mc._yscale = 100;
			mc._x = 0;
			mc._y = 0;

			if (_index == "0")
			{
				mc._x = -48;
				mc._y = -15;
			}
			else if (_index == "1")
			{
				mc._xscale = mc._yscale = 75;
				mc._x = -20;
				mc._y = 10;
			}
			else if (_index == "2")
			{
				mc.gotoAndStop(_ItemImg);
			}
			else if (_index == "3")
			{
				mc._x = 12;
				mc._y = -10;
			}
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


	public function draw()
	{
		super.draw();

	}
}