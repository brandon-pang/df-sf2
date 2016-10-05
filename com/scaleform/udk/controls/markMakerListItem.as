/**
 * ...
 * @author 
 */
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
 class com.scaleform.udk.controls.markMakerListItem extends ListItemRenderer {
	private var imgBox:MovieClip;
	private var emptyMc:MovieClip;
	private var _id:String;
	private var urlPath:String = "";
	//private var urlPath:String = "gfxImgSet/";
	private var imgClanMarkPath:String = urlPath+"gfx_imgset_clanMark.swf";
	
	public function markMakerListItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			_parent["itemBg"+((index)+1)]._visible = true;
			return;
		}
		_parent["itemBg"+((index)+1)]._visible = false
		this.data = data;
		invalidate();
		this._visible = true;
		super.setData(data);

		_id = data.ID;

		UpdateTextFields();
	}
	private function configUI():Void {
		super.configUI();
	}
	private function imgLoader() {
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgClanMarkPath,imgBox);
	}
	private function imgUnLoader() {	
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.unloadClip(imgBox);
	}

	//onLoadInit
	private function onLoadInit(mc:MovieClip) {
		var cm = _id;
		var fn:String = cm.charAt(0);		
		switch(fn){
			case "s":
				var sym:String=cm.substr(1,5)
				mc.symbolMc.setSymbolPic(sym)
			break;
			case "d":
				mc.decoMc.setDecoPic(cm)
			break;
			case "b":
				mc.backMc.setBackPic(cm)
			break;
		}		
	}

	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}

		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function UpdateTextFields() {
		if(_id=="empty"){			
			emptyMc.gotoAndStop(2)
			imgUnLoader()
		}else{
			emptyMc.gotoAndStop(1)
			imgLoader();
		}
		
	}


}