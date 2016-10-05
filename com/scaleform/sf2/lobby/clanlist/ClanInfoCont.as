/**
 * ...
 * @author 
 */
import gfx.core.UIComponent;
import flash.external.ExternalInterface;
import gfx.utils.Delegate;
 
class com.scaleform.udk.views.ClanInfoCont extends UIComponent
{
	public var mapImgBox:MovieClip;
	public var modeImgBox:MovieClip;
	public var infoLoader:MovieClipLoader;

    public function ClanInfoCont() {         
        super();  
    }
   
    //===========================
	// Set btn mapSelect 
	//===========================
	public function SetMapNModeData($mapImg:String, $modeImg:String){
		var mapImg:String=$mapImg;
        var modImg:String=$modeImg;
        var mapImgPath:String;
        var modImgPath:String;

        if(_global.gfxPlayer){
            mapImgPath="gfxImgSet/Map/"+mapImg+".png";
            modImgPath="gfxImgSet/modeIcon/"+modImg+".png";
        }else{
            mapImgPath="img://Imgset_ClanMap."+mapImg;
            modImgPath="img://Imgset_Mode."+modImg;
        }

        loader(mapImgPath,mapImgBox.tg);
		loader(modImgPath,modeImgBox);
		
	}
	//end========================

	public function SetTagBoxTitle($array:Array){
		var txtArr:Array=$array;	
		for(var i:Number=0;i<txtArr.length;i++){
			this["tagBar"+i].txt_title.text=txtArr[i]
		};
	}

	public function SetTagBoxValue($array:Array){		
		var txtArr:Array=$array;
		for(var i:Number=0;i<txtArr.length;i++){
			this["tagBar"+i].txt_value.text=txtArr[i]
		};
	}

	private function onLoadInit(mc:MovieClip)
    {
      
    }

    private function loader(path, mc)
    {
        infoLoader = new MovieClipLoader();
        infoLoader.addListener(this);

        infoLoader.loadClip(path,mc);
    }
	
    private function configUI():Void
    {
    	super.configUI();   
        /*if(_global.gfxPlayer){
            var array1=["xxxx","sdf","sdf2","sd4","가나다",
                      "54334","sdfsae434","sdf2","sd4","가나다"]
            var array2=["xxa23xx","sdf","마소sdf2","sd4","가나다",
                     "54334","너른sae434","sd간다f2","sd4","가나다"]
            SetTagBoxValue(array1)  
            SetTagBoxTitle(array2)

            SetMapNModeData("map_Repaircenter","mode_explosion") 
        }*/
    }
}