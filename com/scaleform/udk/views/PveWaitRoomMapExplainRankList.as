/**
 * ...
 * @author 
 */

import com.scaleform.MaskedList;
import gfx.controls.Button;
import gfx.core.UIComponent;

[InspectableList("disabled", "visible", "enableInitCallback", "soundMap")]
class com.scaleform.udk.views.PveWaitRoomMapExplainRankList extends UIComponent
{
	public var arrowBtn:Button;
	public var rankTop:MovieClip;
	public var list:MaskedList;
	
	private var mcLoader:MovieClipLoader;
	
    public function PveWaitRoomMapExplainRankList()
    {         
        super(); 
        
        mcLoader = new MovieClipLoader();
        
		rankTop.rankTitleTxt.autoSize = true;
		rankTop.rankDateTxt.autoSize = true;
        
		rankTop.rankTitleTxt.verticalAlign = "center";
		rankTop.rankDateTxt.verticalAlign = "center";
        
        rankTop.rankTitleTxt.noTranslate = true;
		rankTop.rankDateTxt.noTranslate = true;
    }
	
	public function initList():Void
	{
		arrowBtn.visible = false;
		arrowBtn.selected = false;
		list.dataProvider = [];
	}
	
	public function setRankTitle(imgSet:String, title:String, date:String):Void
	{
		mcLoader.loadClip("img://Imgset_Mode."+imgSet, rankTop.loader);
		rankTop.rankTitleTxt.text = title;
		rankTop.rankDateTxt.text = date;
		rankTop.rankDateTxt._x = rankTop.rankTitleTxt._x + Math.round(rankTop.rankTitleTxt._width) - 1;
		rankTop._x = this._width - rankTop._width >> 1;
	}
	
	public function setRankList(arr:Array):Void
	{
		list.dataProvider = arr;
		list.scrollPosition = 0;
	}
	
	private function configUI():Void
	{
		super.configUI();
		arrowBtn.visible = false;
		arrowBtn.addEventListener("click", this, "onArrowBtnClick");
	}
	
	private function onArrowBtnClick(e:Object):Void
	{
		dispatchEvent({type:"arrowBtnClicked"});
	}
	
}