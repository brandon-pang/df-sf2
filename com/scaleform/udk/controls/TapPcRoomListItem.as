/**
 * ...
 * @author 
 */
 
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.controls.TapPcRoomListItem extends ListItemRenderer 
{
	private var mcLoader:MovieClipLoader;	
	private var txt_no:TextField;
	private var txt_clanname:TextField;
	private var txt_codename:TextField;
	private var txt_point:TextField;	
	private var classImg:MovieClip;
		
    private var _class:String;
    private var _no:String;
    private var _con:String;
    private var _cln:String;
    private var _po:String;
    private var classImgPath:String="imgset_class.swf";

	public function TapPcRoomListItem() {
		super();
	}	

	public function toString():String
	{
		return "[SF2_dialogWeeklyClanRank_itemRenderer_" + _name + "]";
	}	

	public function setData(data:Object):Void
	{
		// If we received null data, hide this renderer.
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();
		this._visible = true;
		
		_class=data.Class;
		_no=data.No;
		_con=data.CodeName;
		_cln=data.ClanName;
		_po=data.Point;
       
		UpdateTextFields();
	}

	private function UpdateTextFields()
	{		
		txt_no.text=_no;
		txt_codename.htmlText = _con;
		txt_clanname.text = _cln;
		txt_point.text = _po;
		
		lvLoader(classImgPath, classImg);
	}

	private function onLoadInit(mc:MovieClip):Void
	{		
		var lvNo:String = _class;			
		mc.set_level(lvNo);	
	}

	private function lvLoader(path:String, mc:MovieClip):Void
	{
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(path,mc);
	}

	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}
		validateNow();

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void
	{
		super.configUI();

		txt_no.verticalAlign       = "center";
		txt_codename.verticalAlign = "center";
		txt_clanname.verticalAlign = "center";	
		txt_point.verticalAlign    = "center";	

		txt_no.textAutoSize       = "shrink";
		txt_codename.textAutoSize = "shrink";
		txt_clanname.textAutoSize = "shrink";	
		txt_point.textAutoSize    = "shrink";
	}

	public function draw ()
	{
		super.draw ();
	}	
}