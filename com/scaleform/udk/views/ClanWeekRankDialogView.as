/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.View;
import com.scaleform.udk.views.ClanWeekRankDialogCont
import com.scaleform.udk.utils.ScrollWheelManager;

class com.scaleform.udk.views.ClanWeekRankDialogView extends View
{
	public static var viewName:String = "ClanWeekRankDialogView";
	public var container:ClanWeekRankDialogCont
	
	public function ClanWeekRankDialogView()
	{
		super(); 
        trace(viewName + " initialized.");
	}

	public function openInit():Void
    {
    	this._visible = true;
    	container.gotoAndPlay("open");    	
    }
    
    public function closeInit():Void
    {
    	container.gotoAndPlay("close");		
    }        

    public function SetTitle($Value:String):Void{    	
		container.clanWeekRankWnd.SetTitle($Value);
	}

	public function SetTxtAttend($Value:String):Void{		
		container.clanWeekRankWnd.SetTxtAttend($Value);
	}

    private function configUI():Void {
    	super.configUI();
    	
    	if(_global.gfxPlayer){
    		SetTitle("String");
    		SetTxtAttend("Value:String");
    		container.clanWeekRankWnd.List_topRank.dataProvider = [
											{
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199",
												GradeIcon:"1"
											},
											{
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199",
												GradeIcon:"2"
											},
											{
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199",
												GradeIcon:"3"												
											}
    									];

    		container.clanWeekRankWnd.List_btRank.dataProvider = [
											{
												GradeIcon:"1",
												ClanGradeNo:"4위",
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"												
											},
											{
												GradeIcon:"2",
												ClanGradeNo:"4위",
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"												
											},
											{
												GradeIcon:"3",
												ClanGradeNo:"4위",	
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"																						
											},
											{
												GradeIcon:"1",
												ClanGradeNo:"4위",
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"2",
												ClanGradeNo:"4위",
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"3",
												ClanGradeNo:"4위",	
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"																						
											},
											{
												GradeIcon:"1",
												ClanGradeNo:"4위",
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"												
											},
											{
												GradeIcon:"2",
												ClanGradeNo:"4위",
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"												
											},
											{
												GradeIcon:"3",
												ClanGradeNo:"4위",	
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"																						
											},
											{
												GradeIcon:"1",
												ClanGradeNo:"4위",
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"2",
												ClanGradeNo:"4위",
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"3",
												ClanGradeNo:"4위",	
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"																						
											},
											{
												GradeIcon:"1",
												ClanGradeNo:"4위",
												ClanEffect:"001002",
												ClanMark:"gfxImgSet/40004.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"2",
												ClanGradeNo:"4위",
												ClanEffect:"001003",
												ClanMark:"gfxImgSet/40002.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"
												
											},
											{
												GradeIcon:"3",
												ClanGradeNo:"4위",	
												ClanEffect:"002005",
												ClanMark:"gfxImgSet/40006.png",
												ClanName:"얼짱만짱얼짱",
												MasterName:"제레미팡",
												ClanPoint:"991199"																						
											}
    									];
    	}	

    	this._visible = false;
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_dialog_weekly_clan");		
		ScrollWheelManager.registerList(container.clanWeekRankWnd.List_btRank, "WeeklyClan");
	}
	
	private function onCloseEndContainer():Void
	{
		_global.getCloseMotionEnd("gfx_dialog_weekly_clan");
		ScrollWheelManager.unregisterNameTag("WeeklyClan");
	}
	
}