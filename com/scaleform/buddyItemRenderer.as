import gfx.controls.ListItemRenderer;
import gfx.controls.UILoader;


class com.scaleform.buddyItemRenderer extends ListItemRenderer {
	
// Constants:
// Public Properties:	
// Private Properties:	
// UI Elements:
	public var field1:TextField;	// 온오프라인	
	public var field2:TextField;    // 계급수
	public var field3:TextField;	// 닉네임
	public var field4:TextField;	// 상태
	
	// Maybe a button or something?
	


// Initialization:
	private function buddyItemRenderer() { super(); }
	
// Public Methods:	
	public function setData(data:Object):Void {
		 if (data == undefined) {
         this._visible = false;
         return;
         } 
		this.data = data;
		field1.htmlText = data.stat.toString();
		field2.htmlText = data.lv.toString();
		field3.htmlText = data.codeName.toString();
		field4.htmlText = data.statTxt.toString();
	}
	// Private Methods:
}