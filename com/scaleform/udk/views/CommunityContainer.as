/**
 * ...
 * @author 
 */

import com.scaleform.udk.views.CommunityWnd;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.CommunityContainer extends UIComponent
{
    public var communityWnd:CommunityWnd;
    
    public function CommunityContainer()
    {         
        super();  
    }  
    
	public function wndInit():Void
    {
		communityWnd.wndInit();
    }
    
    public function setNewWord(value:Number):Void
    {
    	communityWnd.setNewWord(value);
    }
    
    public function setNewsList(data:Array):Void
    {
    	communityWnd.setNewsList(data);
    }
    
    public function setNewsListItemAt(index:Number, data:Object):Void
    {
    	communityWnd.setNewsListItemAt(index, data);
    }
    
    public function setEmotionTooltip(index:Number, type:Number, value:Array):Void
    {
    	communityWnd.setEmotionTooltip(index, type, value);
	}
    
    public function setFriendException(type:Number, contents:String):Void
    {
    	communityWnd.setFriendException(type, contents);
    }
    
    public function setFriendList(data:Array):Void
    {
    	communityWnd.setFriendList(data);
    }
    
    private function configUI():Void
    {
    	super.configUI();
    }
}