/**
 * ...
 * @author 
 */

import flash.external.ExternalInterface;
import com.scaleform.MaskedList;
import gfx.controls.Button;
import gfx.core.UIComponent;
 
class com.scaleform.udk.views.CommunityWnd extends UIComponent
{
	public var titleMC:MovieClip;
	public var newWord:MovieClip;
	public var newsBtn:Button;
	public var rankBtn:Button;
	public var requestFriendBtn:Button;
	public var tagBtn:Button;
	public var friendPage:MovieClip;
	public var friendException:MovieClip;
	public var newsPage:MovieClip;
	
	private var exceptionBtnLabel:Array = ["_community_register_btn", "_community_modify_btn"];
	
	
	public function CommunityWnd()
	{         
		super();
		
		titleMC.titleTxt1.autoSize = true;
		titleMC.titleTxt2.autoSize = true;
		titleMC.titleTxt1.verticalAlign = "center";
		titleMC.titleTxt2.verticalAlign = "center";
		newWord.textField.autoSize = "center";
	}
	
    public function wndInit():Void
    {
    	setNewWord(0);
    	newsPage.newsList.dataProvider = [];
    	newsPage.newsList.scrollPosition = 0;
    	friendPage.friendList.dataProvider = [];
    	friendPage.friendList.scrollPosition = 0;
    }
    
    public function setNewWord(value:Number):Void
    {
    	if (value != null && value != 0)
    	{
    		newWord._visible = true;
			newWord.textField.text = value.toString();
    	}
    	else
    	{
    		newWord._visible = false;
			newWord.textField.text = "";
    	}
    }
    
    public function setNewsList(data:Array):Void
    {
    	newsPage.newsList.dataProvider = data;
    	newsPage.newsList.scrollPosition = 0;
    }
    
    public function setNewsListItemAt(index:Number, data:Object):Void
    {
    	newsPage.newsList.setItemAt(index, data);
    }
    
    public function setEmotionTooltip(index:Number, type:Number, value:Array):Void
    {
    	newsPage.newsList.renderers[index].emotion.setTooltip(type, value);
	}
    
    public function setFriendException(type:Number, contents:String):Void
    {
    	friendPage.friendList.dataProvider = [];
    	friendPage.friendList.scrollPosition = 0;
    	friendException._visible = true;
    	
		switch (type)
    	{
    		case 0 :
    			friendException.title.gotoAndStop(type);
		    	friendException.contents.htmlText = contents;
		    	friendException.btn.visible = true;
		    	friendException.btnBg.visible = true;
		    	friendException.btn.data = type.toString();
		    	friendException.btn.label = exceptionBtnLabel[type];
    			break;
    		
    		case 1 :
    			friendException.title.gotoAndStop(type);
		    	friendException.contents.htmlText = contents;
		    	friendException.btn.visible = true;
		    	friendException.btnBg.visible = true;
		    	friendException.btn.data = type.toString();
		    	friendException.btn.label = exceptionBtnLabel[type];
    			break;
    			
    		case 2 :
    			friendException.title.gotoAndStop(type);
		    	friendException.contents.htmlText = contents;
		    	friendException.btn.visible = false;
		    	friendException.btnBg.visible = false;
		    	break;
		    
		    default :
		    	friendException._visible = false;
		    	break;
    	}
    }
    
    public function setFriendList(data:Array):Void
    {
    	friendException._visible = false;
		friendPage.friendList.dataProvider = data;
    	friendPage.friendList.scrollPosition = 0;
    }
    
    private function configUI():Void
    {
    	super.configUI();
    	
    	titleMC.titleTxt1.text = "_community_title1";
    	titleMC.titleTxt2.text = "_community_title2";
    	titleMC.titleTxt2._x = titleMC.titleTxt1._x + Math.round(titleMC.titleTxt1._width) - 3;
    	titleMC._x = this._width - titleMC._width >> 1;
    	
    	newWord._visible = false;
    	
    	newsBtn.label = "_community_news";
    	rankBtn.label = "_community_rank";
    	requestFriendBtn.tooltip = "_community_preparing";
    	friendPage.friendTitle.text = "_community_friend_recommand";
    	friendPage.friendSearchBtn.tooltip = "_community_preparing";
    	friendException._visible = false;
    	friendException.btn.addEventListener("click", this, "onFriendExceptionBtnClick");
    	newsPage.newsWriteBtn.label = "_community_write";
    	
    	newsBtn.addEventListener("click", this, "onNewsBtnClick");
    	rankBtn.addEventListener("click", this, "onRankBtnClick");
    	tagBtn.addEventListener("click", this, "onTagBtnClick");
    	newsPage.newsWriteBtn.addEventListener("click", this, "onNewsWriteBtnClick");
    	
    	if (_root.designMode)
    	{
    		setNewWord(10);
    		
    		newsPage.newsList.dataProvider = [
    											{
    												EmblemIcon:"",
    												ClassIcon:"",
    												Manner:"",
    												Codename:"강남스타일",
    												Voted:true,
    												Comment:"<font color='#ff0000'>59,000위 상승!!</font>",
    												Contents:"0나 랭킹 좀 \rㄱㅋ",
    												Joy:50,
    												JoyNames:["sdfdfe", "<font color='#ff0000'>강북스타일</font>", "바이바", "강동스타일ㅂㅂㅂㅂ", "qkdlddkf"],
    												Sorrow:10,
    												SorrowNames:["sdfdfe", "<font color='#ff0000'>강북스타일</font>", "바이바", "강동스타일ㅂㅂㅂㅂ", "qkdlddkf"],
    												Love:20,
    												LoveNames:["sdfdfe", "<font color='#ff0000'>강북스타일</font>", "바이바", "강동스타일ㅂㅂㅂㅂ", "qkdlddkf"],
    												Date:"11월 20일 오후 11:33"
    											},
    											{
    												EmblemIcon:"",
    												ClassIcon:"",
    												Manner:"",
    												Codename:"강남스타일",
    												Voted:false,
    												Comment:"<font color='#ff0000'>59,000위 상승!!</font>",
    												Contents:"1나 랭킹 좀 \rㄱㅋ",
    												Joy:100,
    												JoyNames:["sdfdfe", "<font color='#ff0000'>강북스타일</font>", "바이바"],
    												Sorrow:222,
    												Love:333,
    												Date:"11월 20일 오후 11:33"
    											},
    											{
    												EmblemIcon:"",
    												ClassIcon:"",
    												Manner:"",
    												Codename:"강남스타일",
    												Voted:true,
    												Comment:"<font color='#ff0000'>59,000위 상승!!</font>",
    												Contents:"2나 랭킹 좀 \rㄱㅋ",
    												Joy:1,
    												Sorrow:0,
    												Love:1,
    												Date:"11월 20일 오후 11:33"
    											},
    											{Contents:"3"},
    											{Contents:"4"},
    											{Contents:"5"}
    										];
    		
    		setFriendException(0, "안녕하세요~ SF2 기획자에요^^ 태그를 등록하시면 새롭고 재밌는 친구들을 하루에 5명씩 만나볼수 있어요~");
    		/*							
    		friendPage.friendList.dataProvider = [
    												{
    													EmblemIcon:"",
    													Codename:"강남스타일",
    													TagJob:{name:"드래곤플라이", match:false},
    													TagSchool:{name:"서울고등학교", match:true},
    													TagGame:{name:"월드오브워크래프트", match:false}
    												},
    												{
    													EmblemIcon:"",
    													Codename:"강북스타일",
    													TagJob:{name:"드래곤플라이2", match:true},
    													TagSchool:{name:"서울고등학교2", match:true},
    													TagGame:{name:"스페셜포스", match:true}
    												},
    												{
    													EmblemIcon:"",
    													Codename:"강남스타일",
    													TagSchool:{name:"서울고등학교", match:false},
    													TagGame:{name:"월드오브워크래프트", match:true}
    												}
    											];
    		*/
    	}
    	
    }
    
    private function onFriendExceptionBtnClick(e:Object):Void
    {
    	ExternalInterface.call("community_OnFriendExceptionBtnClick", Number(e.target.data));
    }
    
	private function onNewsBtnClick():Void
	{
		ExternalInterface.call("community_OnNewsBtnClick");
	}
	
	private function onRankBtnClick():Void
	{
		ExternalInterface.call("community_OnRankBtnClick");
	}
	
	private function onTagBtnClick(e:Object):Void
    {
    	ExternalInterface.call("community_OnTagBtnClick");
    }
    
    private function onNewsWriteBtnClick(e:Object):Void
    {
    	ExternalInterface.call("community_OnNewsWriteBtnClick");
    }
}