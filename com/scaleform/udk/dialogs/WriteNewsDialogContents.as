/**
 * ...
 * @author 
 */

import gfx.managers.FocusHandler;
import gfx.controls.TextArea;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.WriteNewsDialogContents extends UIComponent
{
	public var titleTxt:TextField;
	public var imgIcon:MovieClip;
	public var contentsTxt:TextArea;
	public var typeImg:MovieClip;
	public var commentTxt:TextField;
	public var explainTxt:TextField;
	public var btnOk:Button;
	
	private var oldContents:String;
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	private var _typeColor:Array = ["#41af46", "#ff7800", "#9f42ff", "#4292ff"];
	
	public function WriteNewsDialogContents()
	{         
		super();
		
		titleTxt.verticalAlign = "center";
		titleTxt.text = "_dialog_write_title";
		commentTxt.textAutoSize="shrink";
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);
	}
    
    public function initCont():Void
    {
    	mcLoader.unloadClip(imgIcon);
    	contentsTxt.text = "";
    	typeImg.gotoAndStop(1);
    	commentTxt.htmlText = "";
    	explainTxt.text = "";
    }
    
    public function setContents(imgset:String, type:Number, comment:String, explain:String):Void
    {
    	mcLoader.loadClip(_imgPathPersonal+imgset, imgIcon);
    	typeImg.gotoAndStop(type+2);
    	var cmt:String = "<font color='" + _typeColor[type] + "'>"+ comment + "</font>";
    	commentTxt.htmlText = cmt;
    	explainTxt.text = explain;
	}
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	btnOk.label = "_dialog_write_submit";
    	//Selection.setFocus(contentsTxt.textField);
    	
    	contentsTxt.addEventListener("textChange", this, "onContentsTextChange");
	}

	private function onContentsTextChange(e:Object):Void
	{
		if (e.target.textField.maxscroll >= 2) { e.target.text = oldContents; }
		oldContents = e.target.text;
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		mc._xscale = 90;
		mc._yscale = 90;
	}
	
}