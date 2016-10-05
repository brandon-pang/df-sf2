/**
 * ...
 * @author ...
 */

import gfx.controls.ListItemRenderer;
import gfx.controls.StatusIndicator;
import gfx.controls.CoreList;

//import gfx.controls.UILoader;

class com.scaleform.InvenListBox extends ListItemRenderer {

	public var index:Number;
	public var owner:CoreList;
	public var selectable:Boolean = true;

	//public var modify_mc:MovieClip;
	public var weaponType:Number;
	public var modify_mc:StatusIndicator;

	public var rowtext0:TextField;
	public var rowtext1:TextField;
	public var rowtext2:TextField;

	//public var rightMenuBtn:Button;

	//public var myImage:UILoader;

	public function InvenListBox() {
		super();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}

		this.data = data.split("|");
		rowtext0.text = this.data[2];
		rowtext1.text = this.data[3]+" kg";
		rowtext2.text = typeStr(this.data[0]);
		//내구도 애니메이션
		var div = (Number(this.data[4])/50000)*20;
		modify_mc.value = Math.floor(div);
		invalidate();
	}
   

	/*public function draw():Void {
	if (this.data[4] != undefined) {
	this.visible = true;
	modify_mc.value = this.data[4]
	thumbImg.autoSize = true;
	thumbImg.maintainAspectRatio = true;
	} else {
	this.thumbImg.visible = false;
	}
	}*/

	private function typeStr(n:String):String {
		var tyTxt:String;
		if (weaponType == 0) {
			switch (n) {
				case "0" :
					tyTxt = "MG";
					break;
				case "1" :
					tyTxt = "SR";
					break;
				case "2" :
					tyTxt = "SMG";
					break;
				case "3" :
					tyTxt = "AR";
					break;
			}
		}

		return "#type"+weaponType+tyTxt;
	}
}