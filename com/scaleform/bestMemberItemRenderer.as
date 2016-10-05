import gfx.controls.ListItemRenderer;
import gfx.controls.UILoader;


class com.scaleform.bestMemberItemRenderer extends ListItemRenderer {
	
// Constants:
// Public Properties:	
// Private Properties:	
// UI Elements:
	public var field1:TextField;	// 계급
	public var field2:TextField;    // 이름
	
	// Maybe a button or something?
	


// Initialization:
	private function bestMemberItemRenderer() { super(); }
	
// Public Methods:	
	public function setData(data:Object):Void {
		 if (data == undefined) {
         this._visible = false;
         return;
         } 
		this.data = data;
		field1.htmlText = data.lv.toString();
		field2.htmlText = data.codeName.toString();		
	}
	// Private Methods:
}