/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import com.greensock.easing.Cubic;
import com.greensock.easing.Linear;
import com.greensock.TweenMax;
import gfx.utils.Delegate;
 
class com.scaleform.udk.views.GachaRollWnd extends UIComponent
{
	public var rollBg:MovieClip;
	public var rollTxt:MovieClip;
	public var rollContainer:MovieClip;
	public var rollConMask:MovieClip;
	public var oriTxt:String;
	public var rCon:MovieClip;
	public var bgTween:TweenMax;
	public var txtTween:TweenMax;
	public var bgOutTween:TweenMax;
	
	public function GachaRollWnd()
	{         
		super();
		
		rollBg=this.attachMovie("notice_bg", "rollBg", 10)
		rollBg._x = 339;
		rollBg._y = 736;
		rollBg._width = 669;
		rollBg._height = 0;
		rollBg._alpha = 0;
		
		rollContainer = this.createEmptyMovieClip("rollContainer", 20);
		rollContainer._x = 341
		rollContainer._y = 736;
		
		rCon = rollContainer.attachMovie("textMc", "textMc", 10);		
		rCon.txt._x=667
		//setRollTxt("가나다라바마마마<font color='#00ff00'>마맘아럼니ㅓ리농럼123123123노어ㅏㄻ너</font>ㅏ올마너ㅁㄴㅇasdfㅁㄴㅇ라ㅣㄴ오린 rkasldfk가가가나나다ㅏㅜㄴㅁ으,룸ㄴ,울,ㅡㅁ눙,ㅡ룸ㄴㅇㄹ980ㄴㅇㄹㄴㅁ8ㅇ리ㅏㄴ어리ㅏ너러;ㅣ");
	}
	
	public function rollBgFadeIn() {
		bgTween=TweenMax.to(rollBg, 0.5,
		{_alpha:100,		
		_height:25,
		ease:Cubic.easeOut,
		onComplete:Delegate.create(this, onBgFadeInComp)});
	}
	
	public function rollBgFadeOut() {
		bgOutTween=TweenMax.to(rollBg, 0.5,
		{_alpha:0,		
		_height:0,
		ease:Cubic.easeOut,onComplete:Delegate.create(this, onRollBgFadeOutComp)});
	}
	public function onRollBgFadeOutComp() {
		bgOutTween.kill();
		ExternalInterface.call("GachaRollTxtEnd");
	}
	
	
	
	public function rollTxtFadeIn() {
		var txtWid = rCon["txt"].textWidth
		var sec=Math.ceil(txtWid/60)
		txtTween=TweenMax.to(rCon.txt, sec,
		{_x:-txtWid,ease:Linear.easeNone,repeat:2,repeatDelay:0.6,
		onComplete:Delegate.create(this, onTxtFadeInComp) } );
	}
	
	private function onBgFadeInComp() {		
		bgTween.kill();
		rollTxtFadeIn() 
	}
	
	public function onTxtFadeInComp():Void
	{
		txtTween.kill();
		rollTxtInit();		
	}
	
	
	public function setRollTxt(value:String):Void {
		oriTxt = value		
		rCon["txt"].htmlText = oriTxt;	
		
		rollBgFadeIn()
	}
	
	public function rollTxtInit():Void 
	{		
		txtTween.kill();		
		oriTxt = ""		
		rCon["txt"].htmlText = oriTxt;	
		rCon.txt._x = 667;
		rCon["txt"].textWidth = 0		
		rollBgFadeOut()
	}
    private function configUI():Void
    {
    	super.configUI();
		
    }
}