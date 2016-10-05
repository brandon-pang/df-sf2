/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import gfx.controls.Button;
import gfx.controls.ButtonBar;
import gfx.controls.TileList;

import com.greensock.*; 
import com.greensock.easing.*;
import com.greensock.plugins.*;
import com.scaleform.sf2.lobby.MyInfo.BlindCont;


class com.scaleform.sf2.lobby.MyInfo.MyInfoVipMapCont extends UIComponent
{	
	public var txt_mode:MovieClip;
	public var txt_mymap:MovieClip;
	public var ListModeMap:TileList;
	public var ListSaveMap:TileList;
	public var list_modeIcon:TileList;
	public var btnOk:Button;
	public var btnCancel:Button;
	public var blind_mc:BlindCont;
	public var txtWarning:TextField;
	public var txt_warning:TextField;
    public function MyInfoVipMapCont() {         
        super();  
    }
	
	
    private function configUI():Void
    {
		txtWarning.htmlText = "<img src='warning_icon_png' vspace='-7'>" + txt_warning.text;
    	super.configUI();
    }
	
}