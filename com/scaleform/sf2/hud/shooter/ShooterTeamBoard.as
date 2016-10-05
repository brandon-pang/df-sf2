/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterTeamBoard extends Panel
{
	
	public var teamBoardCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String;
	
	private var ITEM_BASE_Y:Number = 0;
	private var ITEM_ROW_UNIT:Number = 105;
	
	private var itemArr:Array = [];
	private var _opened:Boolean = false;
	private var _hp:Number;
	private var HP_BAR_WIDTH:Number = 62;

	private var xInsPos:Array=[65,49,33];
	private var icon0:MovieClip;
	private var icon1:MovieClip;
	private var icon2:MovieClip;
	
    public function ShooterTeamBoard()
    {         
        super();
        mcLoader = new MovieClipLoader();
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function addTeamItem(imgSet:String, 
								level:Number, 
								codeName:String, 
								hp:Number, 
								totalHp:Number):Void
	{	
		var item:MovieClip = teamBoardCont.attachMovie(
													"shooterTeamBoardItem",
													"shooterTeamBoardItem"+itemArr.length,
													teamBoardCont.getNextHighestDepth(),
													{_x:100, _y:ITEM_BASE_Y+(itemArr.length*ITEM_ROW_UNIT)}
												);
		if(_global.gfxPlayer){
			_imgPathPersonal = "gfxImgSet/Personal/"+imgSet+".png";
		}else{
			_imgPathPersonal= "img://Imgset_Personal."+imgSet
		}
		mcLoader.loadClip(_imgPathPersonal, item.slot.imgIcon);
		item.slot.index = itemArr.length;
		item.levelTxt.noTranslate = true;
		item.codeNameTxt.noTranslate = true;
		item.levelTxt.verticalAlign = "center";
		item.codeNameTxt.verticalAlign = "center";
		item.codeNameTxt.html = true;
		item.levelTxt.text = level.toString();
		item.codeNameTxt.htmlText = codeName;
		
		var hpPer:Number = hp / totalHp * 100;
		var hpWidth:Number = hp / totalHp * HP_BAR_WIDTH;
		item.hpBar._width = hpWidth;
		if (hpPer <= 10 && hpPer > 0)
		{
			if (_hp > 10) { item.slot.danger.gotoAndPlay("show"); }
		}
		else
		{
			item.slot.danger.gotoAndStop(2);
		}
		_hp = hpPer;
		
		if (_opened) { TweenMax.to(item, 0.5, {delay:itemArr.length/2*0.3, _x:0, ease:Cubic.easeOut}); }
		
		itemArr.push(item);

		for(var i:Number=0;i<3;i++){
			item["icon"+i]._visible=false
		}

	}
	
	public function setTeamItem(index:Number,
							    level:Number,
	  							hp:Number,
	   							totalHp:Number,
	   							spe:Number,
								def:Number,
								att:Number):Void
	{
		var xInsMc:Array=[]

		if (itemArr[index] == null) { return; }
		itemArr[index].levelTxt.text = level.toString();
		var hpPer:Number = hp / totalHp * 100;
		var hpWidth:Number = hp / totalHp * HP_BAR_WIDTH;
		itemArr[index].hpBar._width = hpWidth;
		if (hpPer <= 10 && hpPer > 0)
		{
			if (_hp > 10) { itemArr[index].slot.danger.gotoAndPlay("show"); }
		}
		else
		{
			itemArr[index].slot.danger.gotoAndStop(2);
		}
		_hp = hpPer;
		
		for(var i:Number=0;i<3;i++){
			itemArr[index]["icon"+i]._visible=false
		}

		if(spe==1){
			itemArr[index]["icon"+0]._visible=true
			xInsMc.push(itemArr[index]["icon"+0])
		}
		if(def==1){
			itemArr[index]["icon"+1]._visible=true
			xInsMc.push(itemArr[index]["icon"+1])
		}
		if(att==1){
			itemArr[index]["icon"+2]._visible=true
			xInsMc.push(itemArr[index]["icon"+2])
		}

		for(var a:Number=0;a<xInsMc.length;a++){
			trace ("posss = "+xInsMc.length+" / "+xInsPos[a+1])
			xInsMc[a]._x=xInsPos[a]
		}
	}
	
	public function removeTeamItem(index:Number):Void
	{
		if (itemArr[index] == null) { return; }
		mcLoader.unloadClip(itemArr[index].slot.imgIcon);
		itemArr[index].removeMovieClip();
		itemArr.splice(index, 1);
		itemRange();
	}
	
	public function removeAllTeamItem():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			mcLoader.unloadClip(itemArr[i].slot.imgIcon);
			itemArr[i].removeMovieClip();
		}
		itemArr = [];
	}
	
	public function setTeamRespawn(index:Number, time:Number, total:Number):Void
	{
		if (itemArr[index] == null) { return; }
		itemArr[index].slot.danger.gotoAndStop(2);
		if (!itemArr[index].slot._dead)
		{
			itemArr[index].slot._dead = true;
			itemArr[index].slot.imgIcon._alpha = 50;
			itemArr[index].levelTxt._alpha = 50;
			itemArr[index].codeNameTxt._alpha = 50;
			itemArr[index].slot.frame._alpha = 50;
			//itemArr[index].bg._alpha = 50;
		}
		
		itemArr[index].slot.setCoolDown(time, total);
		
		if (time == total)
		{
			itemArr[index].slot._dead = false;
			itemArr[index].slot.imgIcon._alpha = 100;
			itemArr[index].levelTxt._alpha = 100;
			itemArr[index].codeNameTxt._alpha = 100;
			itemArr[index].slot.frame._alpha = 100;
			//itemArr[index].bg._alpha = 100;
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		this.addEventListener("openEnd", this, "onOpenEnd");
		this.addEventListener("closeEnd", this, "onCloseEnd");
	}
	
	private function onOpenEnd():Void
	{
		_opened = true;
		
		for (var i:Number=0; i<itemArr.length; i++)
		{
			TweenMax.to(itemArr[i], 0.5, {delay:i/2*0.3, _x:0, ease:Cubic.easeOut});
		}
	}
	
	private function onCloseEnd():Void
	{
		_opened = false;
		_hp = null;
		removeAllTeamItem();
	}
	
	private function itemRange():Void
	{
		for (var i:Number=0; i<itemArr.length; i++)
		{
			itemArr[i]._y = ITEM_BASE_Y + (ITEM_ROW_UNIT*i);
		}
	}
}