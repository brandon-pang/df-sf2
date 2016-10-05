/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.Button;
import gfx.controls.ButtonBar;
 
class com.scaleform.udk.views.ClanWeekRankBaseWnd extends UIComponent 
{
	public var bb_clanRankTap:ButtonBar
	private var mcLoader:MovieClipLoader;
	private var TapClanWeekURL:String="gfx_clanRank_weekly.swf"
    private var TapPcRoomURL:String="gfx_clanRank_pcroom.swf" 
	public var TapContainerWeek:MovieClip;
    public var TapContainerPcRoom:MovieClip;

	public function ClanWeekRankBaseWnd()
	{         
		super();	
	}	

	//================================
	//base tap setting
	//================================
	public function SetMainTab($data:Array):Void
	{
		var _arr=$data
		var _no:Number=Number(_arr[0].Code)
		setTapData(_no)	

		bb_clanRankTap.dataProvider = _arr;		
		bb_clanRankTap.labelField   = "Label";		
		bb_clanRankTap.displayFocus = true;
		bb_clanRankTap.addEventListener("change",this,"onTapClick");	
	}

	public function onTapClick(e:Object)
	{
		var no = e.item.Code;		
		_global.onTapClickIndex(no);		
		setTapData(no)
	}

	public function setTapData($no:Number)
	{
		trace ("xxxxx"+$no)

		var no=$no
		TapContainerWeek._visible=false;    
        TapContainerPcRoom._visible=false; 
		if (no == 0)
		{			
			TapContainerWeek._y = 84;
			TapContainerWeek._visible=true;			
		}
		else if (no == 1)
		{
			TapContainerPcRoom._y = 84;
            TapContainerPcRoom._visible=true; 
			
		}
		else if (no == 2)
		{
			
			
		}
		else if (no == 3)
		{
			
		}
	}
    //--------------------------------------
    //end
    //--------------------------------------

	//================================
	//content Loader
	//================================
	private function onLoadInit(mc:MovieClip)
    {
        
    }

    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);

        mcLoader.loadClip(path,mc);
    }
    //================================
    //Weekly clan ranking
    //================================

    //blind
    public function SetBlindStat($statValue:String){
    	TapContainerWeek.SetBlindStat($statValue)
    }
    public function SetBlindInit(){
    	TapContainerWeek.SetBlindInit();
    }
    public function SetNoticeTextNBg($bgColor:Number,
                                    $txtTitle:String,
                                    $txtTime:String){
        
       TapContainerWeek.SetNoticeTextNBg($bgColor,
                                         $txtTitle,
                                         $txtTime)
    }

    //top
    public function SetTapWeekTopTitle($str:String){
        TapContainerWeek.SetTapWeekTopTitle($str)
    } 
    
    //left
    public function SetClanRankMaxValue($value:Number)
    {
        TapContainerWeek.SetClanRankMaxValue($value)
    }
    public function SetClanRankPos()
    {
        TapContainerWeek.SetClanRankPos()
    }
    public function SetClanNameBoxPos($nowRankValue:Number,
    								$ClanImg:String,
    								$ClanPointStr:String,
    								$isClan:Boolean,
    								$RankValueTxt:String)
    {
        TapContainerWeek.SetClanNameBoxPos($nowRankValue,
                                    $ClanImg,
                                    $ClanPointStr,
                                    $isClan,
                                    $RankValueTxt)
    }
    
    // Right    
    public function SetTxtRankResultTime($str:String)
    {
        TapContainerWeek.SetTxtRankResultTime($str);
    }
    //--------------------------------------
    //end
    //--------------------------------------

    //================================
    // Pcroom Tap Setter
    //================================

    //top
    public function SetTapPcRoomTopTitle($title:String, $id:String):Void{
        TapContainerPcRoom.SetTapPcRoomTopTitle($title, $id);
    }
    //mid
    public function SetUserNameNContent($class:String,
                                        $name:String,
                                        $content:String){
        TapContainerPcRoom.SetUserNameNContent($class,$name,$content);
    }
    //--------------------------------------
    //end
    //--------------------------------------
    
    private function configUI():Void
    {
    	super.configUI();

    	TapContainerWeek = this.createEmptyMovieClip("tapContainerWeek", 20);
		TapContainerWeek._x = 30;
		TapContainerWeek._y = -1000;
		TapContainerWeek._visible=false;
		lvLoader(TapClanWeekURL, TapContainerWeek);

        TapContainerPcRoom = this.createEmptyMovieClip("tapContainerPcRoom", 30);
        TapContainerPcRoom._x = 30;
        TapContainerPcRoom._y = -1000;
        TapContainerPcRoom._visible=false;
        lvLoader(TapPcRoomURL, TapContainerPcRoom);
    }
}