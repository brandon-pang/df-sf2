/**
 * ...
 * @author 
 */


import gfx.core.UIComponent;
import gfx.controls.Button;
import gfx.controls.ScrollingList;
import flash.external.ExternalInterface
//import gfx.controls.DropdownMenu;
 
class com.scaleform.sf2.lobby.clanSearch.ClanSearchDialogMapSet extends UIComponent
{
    public var List_mapSet:MovieClip
    public var btn_setMap:Button
    public var txt_title:TextField
    public var List_map:ScrollingList;
    private var ListItemName:String="Map";
    private var mcLoader:MovieClipLoader;
    
    public function ClanSearchDialogMapSet() {         
        super();  
    } 

    //=============================
    // List Show Hide Control
    //=============================
    private function handleStageClick(event:Object):Void {
        if (hitTest(_root._xmouse, _root._ymouse, true)) { return; }
        ListMapDisabled()
    }  

    public function onBtnSetMapHandler(e:Object){
        ExternalInterface.call("onBtnSet"+ListItemName+"Clicked")
        List_mapSet._visible=e.target.selected
        onMouseDown = handleStageClick;
        Mouse.addListener(this);
    }    

    private function onListChgHandler(e:Object){
        var map=e.item.MapName
        var img=e.item.MapImg
        SetMapData(map,img)
        ListMapDisabled()
    }

    private function ListMapDisabled():Void{
        List_mapSet._visible=false;
        btn_setMap.selected=false
        Mouse.removeListener(this);

    }
    //===========================
    // List Click Set MovieClip
    //===========================
    public function SetMapData($mapName:String,$mapImg:String){
        var imgPath:String;
        var mn:String=$mapName;
        var _img:String=$mapImg;
        if(_global.gfxPlayer){
            imgPath="gfxImgSet/ClanMap/"+_img+".png";
        }else{
            imgPath="img://Imgset_ClanMap."+_img;
        }

        loader(imgPath,btn_setMap["mapImgBox"]);
        btn_setMap.label=mn;
    }

    private function onLoadInit(mc:MovieClip)
    {
        mc._xscale=mc._yscale=74
        mc._y=-20
    }

    private function loader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);

        mcLoader.loadClip(path,mc);
    }

    private function configUI():Void {
    	super.configUI();
        List_mapSet.txt_title.textAutoSize="shrink";
        List_mapSet.txt_title.verticalAlign="center";
        List_mapSet.txt_title.text="_clanSearchDialog_mapset";

        List_mapSet._visible=false;

        btn_setMap.addEventListener("click",this,"onBtnSetMapHandler")       
        List_mapSet.List_map.addEventListener("itemClick",this,"onListChgHandler")

        //
        
    }
}