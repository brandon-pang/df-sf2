/**
 * ...
 * @author 
 */
import gfx.utils.Delegate;
import gfx.core.UIComponent;
import com.scaleform.sf2.lobby.MyInfo.MyInfoVipMapCont
 
class com.scaleform.sf2.lobby.MyInfo.MyInfoVipMapView extends UIComponent
{	
	public var vipmap_cont:MyInfoVipMapCont;
	
    public function MyInfoVipMapView() {         
        super(); 
		//vipmap_cont.ListModeMap.addEventListener("itemClick", this, "onClickHandler");
    }    
	
	/*private function onClickHandler(e:Object):Void {
		trace (e.index);
		trace (e.item.IconImg);
		
		vipmap_cont.ListSaveMap.dataProvider = [
									{IconImg:e.item.IconImg,Title:""},
									{IconImg:"", Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:"", Title:e.item.Title },
									{IconImg:"", Title:"" },
									{IconImg:e.item.IconImg, Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:e.item.IconImg, Title:""}
								   ]
	}*/
	public function setBlindTxt(txt:String) {
		vipmap_cont.blind_mc.setBlindTxt(txt)
	}
	
	public function onBlindEnabled(boo:Boolean) {
		vipmap_cont.blind_mc.onBlindEnabled(boo);
	}
	
    private function configUI():Void
    {
    	super.configUI();
		vipmap_cont.txt_mode.verticalAlign = "center"
		vipmap_cont.txt_mode.textAutoSize = "shrink"
		vipmap_cont.txt_mode.text = "_vipmap_mode_title"
		
		vipmap_cont.txt_mymap.verticalAlign = "center"
		vipmap_cont.txt_mymap.textAutoSize = "shrink"
		vipmap_cont.txt_mymap.text = "_vipmap_save_title"
		
		vipmap_cont.btnOk.label = "_vipmap_save";
		vipmap_cont.btnCancel.label = "_vipmap_reset";
		
		if(_global.gfxPlayer){
		vipmap_cont.list_modeIcon.dataProvider = [
									{IconImg:"mode_escape",Title:"아나콘다"},
									{IconImg:"mode_break", Title:"아나콘다" },
									{IconImg:"mode_explosion", Title:"아나콘다" },
									{IconImg:"mode_party", Title:"아나콘다" },
									{IconImg:"mode_pve", Title:"아나콘다" },
									{IconImg:"ShooterDefenceGame", Title:"아나콘다" }
								   ]
								   
		vipmap_cont.ListSaveMap.dataProvider = [
									{IconImg:"",Title:"아나콘다"},
									{IconImg:"", Title:"아나콘다" },
									{IconImg:"", Title:"아나콘다" },
									{IconImg:"", Title:"아나콘다" },
									{IconImg:"", Title:"아나콘다" },
									{IconImg:"", Title:"아나콘다" },
									{IconImg:"", Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:"", Title:"" },
									{IconImg:"",Title:""}
								   ]
								   
		vipmap_cont.ListModeMap.dataProvider = [
									{IconImg:"map_anaconda",Title:"아나콘다"},
									{IconImg:"map_basecamp", Title:"아나콘다" },
									{IconImg:"map_coop", Title:"아나콘다" },
									{IconImg:"map_burrow", Title:"아나콘다" },
									{IconImg:"map_GhostTown", Title:"아나콘다" },
									{IconImg:"map_Glass_Hexa", Title:"아나콘다" },
									{IconImg:"map_hospital", Title:"아나콘다" },
									{IconImg:"map_kingstemple", Title:"아나콘다" },
									{IconImg:"map_manas", Title:"아나콘다" },
									{IconImg:"map_Manas_MH",Title:"아나콘다"}
								   ]
		}
		vipmap_cont.list_modeIcon.selectedIndex = 0;
		vipmap_cont.ListModeMap.selectedIndex = 0;
		vipmap_cont.ListSaveMap.selectedIndex = 0;	
		
		//setBlindTxt("txt:String")
		//onBlindEnabled(true);
    }
	
}