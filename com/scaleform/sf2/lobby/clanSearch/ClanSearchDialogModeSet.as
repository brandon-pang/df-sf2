/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import gfx.controls.Button;
import gfx.controls.TileList;
import flash.external.ExternalInterface;
 
class com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogModeSet extends UIComponent
{
    public var List_modeSet:MovieClip;
    public var btn_setMode:Button;
    public var txt_title:TextField;
    public var List_mode:TileList;
    private var ListItemName:String="Mode"
    public var modeImgBox:MovieClip;
    public var mcLoader:MovieClipLoader;
    
    public function ClanSearchDialogModeSet() {         
        super();  
    }	

     // Close the dropdown if the user clicks anywhere else in the application.
    private function handleStageClick(event:Object):Void {
        if (hitTest(_root._xmouse, _root._ymouse, true)) { return; }
        ListModeDisabled()
    }  

    public function onBtnSetModeHandler(e:Object){
        ExternalInterface.call("onBtnSet"+ListItemName+"Clicked")
        List_modeSet._visible=e.target.selected
        onMouseDown = handleStageClick;
        Mouse.addListener(this);
    }    

    private function onListChgHandler(e:Object){
    	var mod=e.item.ModeName
        var img=e.item.ModeImg
       	SetModeData(mod,img)

    	ListModeDisabled()
    }

    private function ListModeDisabled():Void{
    	List_modeSet._visible=false;
        btn_setMode.selected=false
        Mouse.removeListener(this);
    }

    //===========================
    // List Click Set MovieClip
    //===========================
    public function SetModeData($modeName:String,$modeImg:String){
        var imgPath:String;
        var mn:String=$modeName;
        var _img:String=$modeImg;

        if(_global.gfxPlayer){
            imgPath="gfxImgSet/modeIcon/"+_img+".png";
        }else{
            imgPath="img://Imgset_Mode."+_img;
        }

        loader(imgPath,modeImgBox);
        btn_setMode.label=mn;
    }

    private function loader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);

        mcLoader.loadClip(path,mc);
    }

    private function configUI():Void {
    	super.configUI();
    	
    	List_modeSet.txt_title.textAutoSize="shrink";
        List_modeSet.txt_title.verticalAlign="center";
        List_modeSet.txt_title.text="_clanSearchDialog_modeset";

        List_modeSet._visible=false

        btn_setMode.addEventListener("click",this,"onBtnSetModeHandler")
        List_modeSet.List_mode.addEventListener("itemClick",this,"onListChgHandler")
    }
}