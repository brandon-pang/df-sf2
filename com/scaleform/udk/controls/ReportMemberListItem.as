/**
 * ...
 * @author 
 */
 
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
 class com.scaleform.udk.controls.ReportMemberListItem extends ListItemRenderer {
	private var imgBox:MovieClip;
	private var txtId:MovieClip;	
	private var selectMc:MovieClip;
	private var _hit:MovieClip;
	public var mcLoader:MovieClipLoader
	//private var urlPath:String = "";
	//private var urlPath:String = "gfxImgSet/";
	private var imgClass:String = "imgset_class.swf";
	
	public function ReportMemberListItem() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;			
			return;
		}
		this.data = data;
		
		this._visible = true;
		super.setData(data);
		
		trace ("============== Declare data ID=== "+data.Id+"\n============== Declare data Grade=== "+data.Grade)
		txtId.htmlText=data.Id					
		imgLoader()
	}
	
	private function imgLoader() {
		mcLoader= new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgClass,imgBox);
	}
	
	//onLoadInit
	private function onLoadInit(mc:MovieClip) {
		var lvNo:String = data.Grade;		
		mc.set_level(lvNo)			

		if (data.manner == "4") {
			mc.manner.gotoAndStop(2);
		} else {
			mc.manner.gotoAndStop(1);
		}
		mc._xscale=mc._yscale=80
	}

	public function updateAfterStateChange ():Void
	{
		if (!initialized)
		{
			return;
		}
		
		txtId.htmlText=data.Id			
		imgLoader()

		if (constraints != null)
		{
			constraints.update (width,height);
		}
		dispatchEvent ({type:"stateChange", state:state});
	}
}