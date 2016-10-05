/**
 * ...
 * @author 
 */

import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.udk.views.TapWeekContainer;
import com.scaleform.udk.views.View;

class com.scaleform.udk.views.TapWeekView extends View
{
	public static var viewName:String = "TapWeekView";
    
    public var container:TapWeekContainer;

    private var blindLoader:MovieClipLoader;
    private var BlindMovieURL:String="gfx_clanRank_blind.swf" 
    public var BlindMovie:MovieClip;
    
    public function TapWeekView() {
        super(); 
        trace(viewName + " initialized.");
    }
    //blind
    public function SetBlindStat($statValue:String){        
        var stat=$statValue
        BlindMovie._y = 52;
        BlindMovie._visible=true;
        BlindMovie.gotoAndPlay(stat);
    }

    public function SetBlindInit(){     
        BlindMovie._y = -1000
        BlindMovie._visible=false
        BlindMovie.gotoAndPlay(1);
    }

     public function SetNoticeTextNBg($bgColor:Number,
                                      $txtTitle:String,
                                      $txtTime:String)
     {
        //open 
        //mid 
        //close        
        BlindMovie.SetNoticeTextNBg($bgColor,
                                    $txtTitle,
                                    $txtTime)
    }
    
    //top
    public function SetTapWeekTopTitle($str:String){
        container.SetTapWeekTopTitle($str)
    }
    
     //left
    public function SetClanRankMaxValue($value:Number)
    {
        container.SetClanRankMaxValue($value)
    }
    public function SetClanRankPos()
    {
        container.SetClanRankPos()
    }
    public function SetClanNameBoxPos($nowRankValue:Number,
                                      $ClanImg:String,
                                      $ClanPointStr:String,
                                      $isClan:Boolean,
                                      $RankValueTxt:String)
    {
        container.SetClanNameBoxPos($nowRankValue,
                                    $ClanImg,
                                    $ClanPointStr,
                                    $isClan,
                                    $RankValueTxt)
    }           
    //Right
    public function SetTxtRankResultTime($str:String)
    {
        container.SetTxtRankResultTime($str)
    }
    
    //================================
    //content Loader
    //================================
    private function onLoadInit(mc:MovieClip)
    {
        if(_global.gfxPlayer){
            SetBlindStat("open")
            SetNoticeTextNBg(2,
                            "$txtTitle:String",
                            "$txtTime:String")
        }
    }

    private function blindLoaders(path, mc)
    {
        blindLoader = new MovieClipLoader();
        blindLoader.addListener(this);

        blindLoader.loadClip(path,mc);
    }

    private function configUI():Void {
    	super.configUI();  

        BlindMovie = this.createEmptyMovieClip("blindMovie", 40);
        BlindMovie._x = 175;
        BlindMovie._y = -1000;
        BlindMovie._visible=false;

       blindLoaders(BlindMovieURL, BlindMovie);  	
    }    	
}