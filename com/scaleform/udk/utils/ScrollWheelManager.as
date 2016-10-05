import gfx.controls.CoreList;

/**
 *  스크롤매니져 클래스.
 *
 *  @author noww
 */ 
class com.scaleform.udk.utils.ScrollWheelManager
{
    
    private static var registeredList:Array = [];
    
	public function ScrollWheelManager()
	{
		super();
	}
	
	/**
     *  초기화
     */
	public static function init():Void 
	{
		for (var i:Number=0; i<registeredList.length; i++)
		{
			if (registeredList[i].list != null)
			{
				Mouse.removeListener(registeredList[i].list);
			}
		}
		registeredList = [];
	}
	
    /**
     *  리스트 등록
     */
	public static function registerList(list:Object, nameTag:String):Void 
	{
		for (var i:Number=0; i<registeredList.length; i++)
		{
			if (registeredList[i].list == list) { return; }
		}
	    var obj:Object = {list:list, nameTag:nameTag};
	    Mouse.addListener(list);
	    if (list["_scrollBar"]) {  Mouse.addListener(list["_scrollBar"]); }
	    registeredList.push(obj);
	}
	
	/**
     *  이름표로 등록 해지
     */
	public static function unregisterNameTag(nameTag:String):Void 
	{
		for (var i:Number=0; i<registeredList.length; i++)
		{
			if (registeredList[i].nameTag == nameTag)
			{
				registeredList.splice(i, 1);
				Mouse.removeListener(registeredList[i].list);
				if (registeredList[i].list["_scrollBar"]) {  Mouse.removeListener(registeredList[i].list["_scrollBar"]); }
				unregisterNameTag(nameTag);
			}
		}
	}
	
	/**
     *  리스트 등록 해지
     */
	public static function unregisterList(list:Object):Void 
	{
		for (var i:Number=0; i<registeredList.length; i++)
		{
			if (registeredList[i].list == list)
			{
				registeredList.splice(i, 1);
				Mouse.removeListener(registeredList[i].list);
				if (registeredList[i].list["_scrollBar"]) {  Mouse.removeListener(registeredList[i].list["_scrollBar"]); }
				return;
			}
		}
	}
	
    /**
     *  리스트 등록 여부
     */
	public static function checkList(list:Object):Boolean 
	{	
		for (var i:Number=0; i<registeredList.length; i++)
		{
			if (registeredList[i].list == list)
			{
				return true;
			}
		}
		return false;
	}


}
