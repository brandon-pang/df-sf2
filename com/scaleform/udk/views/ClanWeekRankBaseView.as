/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.udk.views.ClanWeekRankBaseCont;
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.udk.views.ClanWeekRankBaseView extends View
{
	public static var viewName:String = "ClanWeekRankBaseView";
	public var container:ClanWeekRankBaseCont;
	
	public function ClanWeekRankBaseView()
	{
		super(); 
        trace(viewName + " initialized.");
	}

	public function openInit():Void
    {
    	this._visible = true;
    	container.gotoAndPlay("open");
        if (_global.gfxPlayer)
        {  
            SetBlindStat("open") 
            SetClanRankBaseTabData([
                        {
                         Label:"주간클랜랭킹",
                         Code:0
                        },
                         {
                         Label:"PC방 랭킹",
                         Code:1
                        }
                        ]);

            SetTapWeekTopTitle("$str:String")
            
            SetClanRankMaxValue(1000)
            SetClanRankPos()
            SetClanNameBoxPos(900,
                              "gfxImgSet/00004_64.png",
                              "33,333");

            SetTxtRankResultTime("99",
                             "99",
                             "99");

            container.clanWeekRankBase.TapContainerWeek.container.weekRankRight.List_TapWeek.dataProvider = [
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"001002",
                                            ClanMark:"gfxImgSet/40004.png",
                                            ClanName:"얼짱만짱얼짱",
                                            ClanPoint:"991199",
                                            GradeIcon:"1"
                                        },
                                        {
                                            ClanGradeNo:"4위",
                                            ClanEffect:"001003",
                                            ClanMark:"gfxImgSet/40002.png",
                                            ClanName:"얼짱만짱얼짱",
                                            MasterName:"제레미팡",
                                            ClanPoint:"991199",
                                            GradeIcon:"2"
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:"3"                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        },
                                         {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        },
                                         {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        },
                                         {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        },
                                         {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        },
                                         {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199",
                                            GradeIcon:""                                               
                                        },
                                        {
                                            ClanGradeNo:"5위",
                                            ClanEffect:"002005",
                                            ClanMark:"gfxImgSet/40006.png",
                                            ClanName:"얼짱만짱얼짱",                                         
                                            ClanPoint:"991199"                                           
                                        }
                                    ]; 
        //=============================================
         container.clanWeekRankBase.TapContainerPcRoom.container.pcRoomRankBt.List_TapPcRoom.dataProvider = [
                                        {
                                            Class:"0012",
                                            No:"1위",
                                            CodeName:"가나다라맘",
                                            ClanName:"얼짱만짱얼짱",                                          
                                            Point:"1111"
                                        },
                                        {
                                            Class:"0012",
                                            No:"99위",
                                            CodeName:"1232skrksk나나나",
                                            ClanName:"얼짱만짱얼짱",                                            
                                            Point:"111111"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",                                            
                                            Point:"19199"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2123위",
                                            CodeName:"sk1가나앎ㅌ아람ㅇㄴㄹkskekrkkr",
                                            ClanName:"얼짱만짱ㅁㄴㅇㄻㄴㅇㄹskekfk얼짱",                                            
                                            Point:"11232999990"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",                                            
                                            Point:"1231"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"121"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"131"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"919"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"18881"
                                        },
                                        {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"19898"
                                        },
                                          {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"19898"
                                        },
                                          {
                                            Class:"0012",
                                            No:"2위",
                                            CodeName:"skskskekrkkr",
                                            ClanName:"얼짱만짱얼짱",
                                            Point:"19898"
                                        }
                                    ];
        SetTapPcRoomTopTitle("$title:String", "$id:String")
        var testTxt:String="<font size='11' color='#8A8A8A'>내 순위</font><font size='17' color='#E2AA01'> 999</font><font size='11' color='#8A8A8A'>위 (전일대비</font> <font size='11' color='#FF0000'>▼</font><font size='11' color='#8A8A8A'> 10위 하락) / 내 누적점수</font><font size='17' color='#E2AA01'> 9000000"
        SetUserNameNContent("$class:String",
                            "$name:String",
                            testTxt)          
        }  
    }
    
    public function closeInit():Void
    {
    	container.gotoAndPlay("close");

    }   

 //================================================================================================
 // clanRank Base Method 
 //================================================================================================

    //클랜랭킹 탭 세팅
	public function SetClanRankBaseTabData($data:Array):Void
	{
		if($data==null)return
		container.SetMainTab($data)
	}	

    public function setTapData($no:Number){
        container.setTapData($no)
    }
//================================================================================================
// End
//================================================================================================

//================================================================================================
// clanRank TAP  Weekly
//================================================================================================
    //blind
    public function SetBlindStat($statValue:String){
         container.clanWeekRankBase.SetBlindStat($statValue);
    }

    public function SetBlindInit(){
        container.clanWeekRankBase.SetBlindInit();
    }
    public function SetNoticeTextNBg($bgColor:Number,
                                    $txtTitle:String,
                                    $txtTime:String){
        
        container.clanWeekRankBase.SetNoticeTextNBg($bgColor,
                                                    $txtTitle,
                                                    $txtTime)
    }
    //top
    public function SetTapWeekTopTitle($str:String){
        container.SetTapWeekTopTitle($str)
    }  
    
	//left
    public function SetClanRankMaxValue($value:Number)
    {
        container.SetClanRankMaxValue($value)
    }
    public function SetClanRankPos()
    {
        container.SetClanRankPos()
    }
    public function SetClanNameBoxPos($nowRankValue:Number,
                                        $ClanImg:String,
                                        $ClanPointStr:String,
                                        $isClan:Boolean,
                                        $RankValueTxt:String)
    {
        container.clanWeekRankBase.SetClanNameBoxPos($nowRankValue,
                                    $ClanImg,
                                    $ClanPointStr,
                                    $isClan,
                                    $RankValueTxt)
    }
    
    // Right    
    public function SetTxtRankResultTime($str:String)
    {
        container.clanWeekRankBase.SetTxtRankResultTime($str)
    }
//================================================================================================
// End
//================================================================================================

//================================
// Pcroom Tap Setter
//================================

    //top
    public function SetTapPcRoomTopTitle($title:String, $id:String):Void{
        container.clanWeekRankBase.SetTapPcRoomTopTitle($title, $id);
    }
    //mid
    public function SetUserNameNContent($class:String,
                                        $name:String,
                                        $content:String){
        container.clanWeekRankBase.SetUserNameNContent($class,$name,$content);
    }
//--------------------------------------
//end
//--------------------------------------
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_clanRank_base");
		ScrollWheelManager.registerList(container.clanWeekRankBase.TapContainerWeek.container.weekRankRight.List_TapWeek, "ClanWeekRankBase");
        ScrollWheelManager.registerList(container.clanWeekRankBase.TapContainerPcRoom.container.pcRoomRankBt.List_TapPcRoom, "ClanWeekRankBase");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_clanRank_base");
        //블라인드 초기화
        SetBlindInit();
		ScrollWheelManager.unregisterNameTag("ClanWeekRankBase");
        //
        container.clanWeekRankBase.bb_clanRankTap.selectedIndex=0
	}

	 private function configUI():Void {
    	super.configUI();    	
    	this._visible = false;

    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");   
	}
	
}