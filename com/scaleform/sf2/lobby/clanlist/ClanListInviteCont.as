/**
 * ...
 * @author 
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
import gfx.utils.Delegate;
import gfx.controls.ScrollingList;
 
class com.scaleform.sf2.lobby.clanlist.ClanListInviteCont extends UIComponent
{
	public var topIndexBar:MovieClip;
    public var List_clanInvite:ScrollingList;
    private var txtMcArray:Array=["txt_mark","txt_info",
                                "txt_user","txt_day"];
    private var txtArray:Array=["_clanInvite_mark","_clanInvite_info",
                                "_clanInvite_recommer","_clanInvite_recomday"];
    public function ClanListInviteCont() {         
        super();  
    }
	
    private function configUI():Void
    {
    	super.configUI(); 

        for(var i:Number=0;i<txtMcArray.length;i++){
            topIndexBar[txtMcArray[i]].text=txtArray[i]
            topIndexBar[txtMcArray[i]].verticalAlign="center";
            topIndexBar[txtMcArray[i]].textAutoSize="shrink";
        }
        if(_global.gfxPlayer){
            List_clanInvite.dataProvider=[
            {ClanMark:"00004_64",Cname:"1가나다클랜",Cmaster:"1클랜장이름",RecomName:"추천인 1이름",RecomDay:"2013-01-01"},
            {ClanMark:"00004_64",Cname:"2가나다클랜",Cmaster:"클2랜장이름",RecomName:"추천인 2이름",RecomDay:"2013-01-01"},
            {ClanMark:"00004_64",Cname:"3가나다클랜",Cmaster:"클랜3장이름",RecomName:"추천인 이름",RecomDay:"2013-01-01"},
            {ClanMark:"000000",Cname:"4가나다클랜",Cmaster:"클랜장4이름",RecomName:"추천인 3이름",RecomDay:"2014-01-01"},
            {ClanMark:"000000",Cname:"5가나다클랜",Cmaster:"클랜장이5름",RecomName:"추천인 이름",RecomDay:"2013-01-01"},
            {ClanMark:"000000",Cname:"6가나다클랜",Cmaster:"클랜장이름6",RecomName:"추천인 4이름",RecomDay:"2013-04-01"},
            {ClanMark:"000000",Cname:"7가나다클랜",Cmaster:"7클랜장이름",RecomName:"추천인 이름",RecomDay:"2013-01-01"},
            {ClanMark:"000000",Cname:"8가나다클랜",Cmaster:"클8랜장이름",RecomName:"추천인 이름",RecomDay:"2013-01-01"},
            {ClanMark:"000000",Cname:"9가나다클랜",Cmaster:"클랜9장이름",RecomName:"추천인5 이름",RecomDay:"2013-05-01"},
            {ClanMark:"000000",Cname:"10가나다클랜",Cmaster:"클랜장10이름",RecomName:"추천인7이름",RecomDay:"2013-01-01"}]
        }
    }
}