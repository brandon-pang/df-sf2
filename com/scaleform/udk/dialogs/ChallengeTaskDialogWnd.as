/**
 * ...
 * @author 
 */

import com.greensock.easing.*;
import com.greensock.TweenMax;
import flash.external.ExternalInterface;
import com.scaleform.udk.controls.ChallengeDialogRewardItem;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.ChallengeTaskDialogWnd extends UIComponent
{
	public var btn_challengeDialog:Button;
	public var emblem:MovieClip;
	public var titleTxt:MovieClip;
	public var item1:ChallengeDialogRewardItem;
	public var item2:ChallengeDialogRewardItem;
	public var item3:ChallengeDialogRewardItem;
	public var item4:ChallengeDialogRewardItem;
	public var item5:ChallengeDialogRewardItem;
	public var item6:ChallengeDialogRewardItem;
	public var commentMC:MovieClip;
	
	private var itemPosX1:Array = [461];
	private var itemPosX2:Array = [406, 515];
	private var itemPosX3:Array = [352, 461, 570];
	private var itemPosX4:Array = [297, 406, 515, 624];
	private var itemPosX5:Array = [243, 352, 461, 570, 679];
	private var itemPosX6:Array = [188, 297, 406, 515, 624, 733];
	private var itemArr:Array;
	private var data:Object;
	private var datas:Array;
	private var _imgPathChallenge:String = "img://Imgset_Challenge_Emblem.128.";
	
	private var medalFontColor:Array = [0xB2B2B2, 0xdead8d, 0xbababa, 0xffe671];
	
	public function ChallengeTaskDialogWnd()
	{         
		super();  
	}
    
    public function setEmblem(data:Object):Void
    {
    	this.data = data;
    	emblem.gotoAndStop(1);
    	var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
    	mcLoader.loadClip(_imgPathChallenge+data.imgSet, emblem.emblemMC.imgIcon);
		
    	setEmblemTitle();
    }
    
    private function onLoadInit(mc:MovieClip):Void
	{
		emblem.gotoAndPlay(1);
	}
    
    public function setReward(datas:Array):Void
    {
    	this.datas = datas;
    	for (var i:Number=0; i<datas.length; i++)
    	{
    		itemArr[i]._x = this["itemPosX"+datas.length][i];
    	}
    	for (var j:Number=0; j<6; j++)
    	{
    		itemArr[j].setData(datas[j]);
    	}
    	itemStartTween();
    }
    
    public function setComment(cmt:String):Void
    {
    	commentMC.txt.text = cmt;
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	itemArr = [item1, item2, item3, item4, item5, item6];
    	
    	btn_challengeDialog.label = "_OK";
    	btn_challengeDialog.addEventListener("click", this, "onChallengeDialogBtnClick");
    	
		this.addEventListener("closeStart", this, "onCloseStart");
	}
	
	private function onChallengeDialogBtnClick():Void
	{
		ExternalInterface.call("challengeDialog_OnOkBtnClick");
	}
	
	private function itemStartTween():Void
	{
		TweenMax.killChildTweensOf(this, true);
		for (var i:Number=0; i<datas.length; i++)
		{
			TweenMax.to(itemArr[i], 0.2, {_y:365, _alpha:100, ease:Strong.easeOut});
		}
	}
	
	private function onCloseStart():Void
	{
		itemEndTween();
	}
	
	private function itemEndTween():Void
	{
		for (var i:Number=0; i<datas.length; i++)
		{
			TweenMax.to(itemArr[i], 0.1, {_y:380, _alpha:0, ease:Strong.easeOut, onComplete:itemEndTweenComplete, onCompleteParams:[itemArr[i]]});
		}
	}
	
	private function itemEndTweenComplete(item:ChallengeDialogRewardItem):Void
	{
		item.removeData();
	}
	
	private function setEmblemTitle():Void
	{
		titleTxt.txt.text = data.title;
    	titleTxt.txt.autoSize = true;
    	
    	if (data.medalType != null)
    	{
    		titleTxt.txt.textColor = medalFontColor[data.medalType];
    		titleTxt.txt._x = titleTxt._width - titleTxt.txt._width >> 1;
    		titleTxt.txt._x = titleTxt.txt._x + 20;
    		titleTxt.medalMC._x = titleTxt.txt._x - 41;
    		titleTxt.medalMC.gotoAndStop(data.medalType+1);
    		titleTxt.medalMC.txt.text = data.medalNum;
    		titleTxt.medalMC.txt.textColor = medalFontColor[data.medalType];
    	}
    	else
    	{
    		titleTxt.txt.textColor = medalFontColor[0];
    		titleTxt.txt._x = titleTxt._width - titleTxt.txt._width >> 1;
    		titleTxt.medalMC.gotoAndStop(1);
    		titleTxt.medalMC.txt.text = "";
    	}
	}
}