/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
import com.scaleform.udk.utils.UDKUtils;

class com.scaleform.udk.views.TapWeekLeft extends UIComponent
{
    private var mcLoader:MovieClipLoader;   
    private var clanmarkChk:String;
    private var _cmark:String;
    public var clanImg:MovieClip;
    public var rankNameBox:MovieClip;
    public var bar:MovieClip;
    public var posBox:MovieClip;
    public var barHei:Number;
    private var maxValue:Number;
    private var nowValue:Number;
    private var txt_d0:TextField
    private var rankNameArr:Array=[{posy:7,value:"tapWeekRank_platinum"},
                                   {posy:37,value:"tapWeekRank_gold"},
                                   {posy:77,value:"tapWeekRank_silver"},
                                   {posy:139,value:"tapWeekRank_bronze"}]

    public function TapWeekLeft() {         
        super();  
    }

    public function SetClanRankMaxValue($value:Number){
        maxValue=$value;
    }

    public function SetClanRankPos(){
        for(var i:Number=0;i<rankNameArr.length;i++){
            var rankBox:MovieClip=this.attachMovie("ClanRankNameBox","rankNameBox"+i,i+10)
            rankBox.gotoAndStop("silver")
            rankBox._x               = (bar._x+bar._width)-2
            rankBox._y               = rankNameArr[i].posy
            rankBox["txt_name"].text = rankNameArr[i].value
        }
    }

    public function SetClanNameBoxPos($nowRankValue:Number,
                                       $ClanImg:String,
                                       $ClanPointStr:String,
                                       $isClan:Boolean,
                                       $RankValueTxt:String):Void
    {
        var isClan=$isClan
        var nv:Number  = $nowRankValue;
        var img:String = $ClanImg;        
        var cp:String  = $ClanPointStr;
        var rankTxt:String=$RankValueTxt
        var rankBoxValue:String="0"
        _cmark=img;
        clanmarkChk = img.charAt(0);
        

        posBox["txt_rank"].text = rankTxt
        //String(nv)+txt_d0.text;
        posBox["txt_cp"].text   = cp;

        var per=(nv/maxValue)*100

        if(isClan==true || isClan==null){
            posBox._visible=true
            if(nv==-1){
                rankBoxValue=""
                posBox._y=barHei-4
                //posBox["txt_rank"].text     = "_tapWeekRank_rank_none" //순위없음

                if(cp=="-1" || cp==null || cp==""){
                    posBox["txt_cp"].text   = "_tapWeekRank_cp_none"   //CP없음
                }else{
                    posBox["txt_cp"].text   = cp
                }
                
            }
            //1등
            else if(nv==1){
                posBox._y=20
                rankBoxValue="0"
            }
            //2~4등
            else if(nv>1 && nv<5)
            {
                posBox._y=27+(nv*7)
                rankBoxValue="1"
            }
            //5~10등
            else if(nv>4 && nv<11){
                posBox._y=42+(nv*6)
                rankBoxValue="2"
            }else{
                //상위 10프로
                if(per < 11){
                    var tenPer=113+((nv*per)/maxValue)*82                
                    posBox._y=tenPer
                   rankBoxValue="3"
                }
                //나머지 등외
                else{
                    var tenPer=194+(nv/maxValue)*(barHei-205)
                    posBox._y=tenPer
                    rankBoxValue="4"
                }
            }
        }else{
        	rankBoxValue=""
            posBox._visible=false;
        }

        if (clanmarkChk == "#")
        {
            var imgClanMarkSmallPath:String

            if (_global.gfxPlayer)
            {
                imgClanMarkSmallPath = "gfxImgSet/gfx_imgset_clanMark.swf";
            }
            else
            {
                imgClanMarkSmallPath = "gfx_imgset_clanMark.swf"
            }   

            lvLoader(imgClanMarkSmallPath, posBox.clanImg["tg"]);
        }
        else if (clanmarkChk == "" || clanmarkChk == undefined)
        {
            //
        }
        else
        {
            clanmarkChk = "@";
            lvLoader(img, posBox.clanImg["tg"]);
        }

        onRankNameBoxTurnSwitch(rankBoxValue)      
    } 

    private function onRankNameBoxTurnSwitch($value:String){
        for(var i:Number=0;i<rankNameArr.length;i++){  
            this["rankNameBox"+i]["txt_name"].text = rankNameArr[i].value          
            if(String(i)==$value){ 
                this["rankNameBox"+i]["txt_name"].textColor = 0x613515
                this["rankNameBox"+i].gotoAndStop("gold")  
            }else{
                this["rankNameBox"+i]["txt_name"].text = rankNameArr[i].value  
                 this["rankNameBox"+i]["txt_name"].textColor = 0xcccccc
                this["rankNameBox"+i].gotoAndStop("silver")                  
            }            
        }
        //return;
    }       

    private function onLoadInit(mc:MovieClip)
    {
        if (mc._name == "tg")
        {
            if (clanmarkChk == "#")
            {
                var sym:String = _cmark.substr(1, 5);
                var dec:String = _cmark.substr(6, 3);
                var back:String = _cmark.substr(9, 3);

                mc.symbolMc.setSymbolPic(sym);
                mc.decoMc.setDecoPic("D" + dec);
                mc.backMc.setBackPic("B" + back);
            }
        }
    }

    private function lvLoader(path, mc)
    {
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);

        mcLoader.loadClip(path,mc);
    }

    private function configUI():Void {
    	super.configUI();
        posBox._visible=false
        barHei=bar._height
        txt_d0.text="_tapWeekRank_rank"
    }
}