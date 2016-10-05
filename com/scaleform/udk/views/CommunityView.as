/**
 * ...
 * @author 
 */

import gfx.controls.Button;
import com.scaleform.udk.utils.ScrollWheelManager;
import com.scaleform.udk.views.CommunityContainer;
import com.scaleform.udk.views.View;

class com.scaleform.udk.views.CommunityView extends View
{
	public static var viewName:String = "CommunityView";
    
    public var container:CommunityContainer;
    
    public function CommunityView()
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
    
    public function setNewWord(value:Number):Void
    {
    	if (value == null || value < 0) { return; }
    	container.setNewWord(value);
    }
    
    public function setNewsList(data:Array):Void
    {
    	if (data == null) { return; }
    	container.setNewsList(data);
    }
    
    public function setNewsListItemAt(index:Number, data:Object):Void
    {
    	if (index == null || index < 0 || data == null) { return; }
    	container.setNewsListItemAt(index, data);
    }
    
    public function setEmotionTooltip(index:Number, type:Number, value:Array):Void
    {
    	if (index == null || index < 0) { return; }
    	container.setEmotionTooltip(index, type, value);
	}
    
    public function setFriendException(type:Number, contents:String):Void
    {
    	if (type == null) { return; }
    	container.setFriendException(type, contents);
    }
    
    public function setFriendList(data:Array):Void
    {
    	if (data == null) { return; }
    	container.setFriendList(data);
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	this._visible = false;
    	
    	container.addEventListener("openEnd", this, "onOpenEndContainer");
    	container.addEventListener("closeEnd", this, "onCloseEndContainer");
	}
	
	private function onOpenEndContainer():Void
	{
		_global.getMotionEnd("gfx_community");
		
		ScrollWheelManager.registerList(container.communityWnd.newsPage.newsList, "community");
		ScrollWheelManager.registerList(container.communityWnd.friendPage.friendList, "community");
	}
	
	private function onCloseEndContainer():Void
	{
		container.wndInit();
		this._visible = false;
		_global.getCloseMotionEnd("gfx_community");
		ScrollWheelManager.unregisterNameTag("community");
	}
}