/**
 * ...
 * @author 
 */
import gfx.core.UIComponent;

class com.scaleform.udk.views.TapPcRoomMid extends UIComponent {
	public var txt_name : TextField;
	public var txt_content : TextField;
	public var classImg : MovieClip;
	public var mcLoader:MovieClipLoader;
	private var cl:String;
	private var classImgPath:String="imgset_class.swf";
	public function TapPcRoomMid() {         
		super();  
	}
	
	public function SetUserNameNContent($class:String,
										$name:String,
										$content:String):Void
	{
		cl=$class;
		var n:String=$name;
		var ct:String=$content;
		var icon:String = "<img src='sun_time' vspace='-12'>"; 	

		txt_name.htmlText=n;
		txt_content.htmlText=icon+ct;

		lvLoader(classImgPath, classImg);
	}	

	private function onLoadInit(mc:MovieClip):Void
	{
		if (mc._name == "classImg")
		{
			var lvNo:String = cl;			
			mc.set_level(lvNo);
		}
	}
	
    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
        mcLoader.loadClip(path,mc);
    }
    
	private function configUI() : Void {
		super.configUI();

		txt_name.verticalAlign     = "center";
		txt_name.textAutoSize      = "shrink";
		
		txt_content.verticalAlign  = "center";
		txt_content.textAutoSize   = "shrink";
	}
}