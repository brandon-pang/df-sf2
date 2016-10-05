/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.Back;
import gfx.layout.Panel;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterResultWnd extends Panel
{
	
	public var shooterResultCon:MovieClip;
	private var urlPath = "";
	//private var urlPath = "gfxImgSet/";
	private var _imgPath:String = urlPath + "imgset_big_class.swf";
	private var _rank:String
	private var mcLoader:MovieClipLoader;
	
    public function ShooterResultWnd()
    {         
        super();
    }	
	
	public function setTitle($str:String):Void
	{
		var str=$str;
		shooterResultCon.titleMc.txt_title.htmlText=str;
	}

	public function setSuccessCase($boo:Boolean):Void{
		var boo:Boolean=$boo
		if(boo){
			shooterResultCon.bg_title._visible=true
			shooterResultCon.mark.gotoAndStop(1);
		}else{
			shooterResultCon.bg_title._visible=false
			shooterResultCon.mark.gotoAndStop(2);
		}		
	}

	private function lvLoader(path, mc)
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(path,mc);
	}

	private function onLoadInit(mc:MovieClip)
	{
		//
	}

	public function setCodeNames(arr:Array):Void
	{
		var a:Array=arr;
		for(var i:Number=0;i<a.length;i++){
			shooterResultCon["codeNameMc"+i].img._visible=true;
			shooterResultCon["codeNameMc"+i].txt_codename.htmlText=a[i].CodeName;
			shooterResultCon["codeNameMc"+i].img.tg.set_level(a[i].Rank)
		}
	}

	public function setInit(){
		for(var i:Number=0;i<4;i++){
			shooterResultCon["codeNameMc"+i].img._visible=false;
			shooterResultCon["codeNameMc"+i].txt_codename.htmlText="";
			_rank="";
		}		
		shooterResultCon.gotoAndPlay(1);
	}

	public function show():Void
	{
		gotoAndPlay("show");
	}

	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		shooterResultCon.titleMc.txt_title.verticalAlign="center";
		shooterResultCon.titleMc.txt_title.textAutoSize="shrink";
		for(var i:Number=0;i<4;i++){			
			shooterResultCon["codeNameMc"+i].txt_codename.verticalAlign="center";
			shooterResultCon["codeNameMc"+i].txt_codename.textAutoSize="shrink";
			shooterResultCon["codeNameMc"+i].img._visible=false;
			lvLoader(_imgPath,shooterResultCon["codeNameMc"+i].img.tg);
		}	

	}
	
}