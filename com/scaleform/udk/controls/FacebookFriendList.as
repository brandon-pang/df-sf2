/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import flash.external.ExternalInterface;
import gfx.controls.CoreList;
import gfx.utils.Constraints;
import gfx.controls.Button;
import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;

class com.scaleform.udk.controls.FacebookFriendList extends ListItemRenderer
{
	
	private var _hit:MovieClip;	
	private var txt_item:MovieClip;	
	private var btn_use:Button;	
	private var t_item:String;
	private var isDisable:String;
	//

	private function FacebookFriendList()
	{
		super();	
	}

	public function setData(data:Object):Void
	{
		if (data == null)
		{
			this.data = null;
			visible = false;
		}
		else
		{
			this.data = data;
			visible = true;
			t_item = data.FaceBookId;		
			isDisable=data.isDisable			
			
			invalidate();
		}
	}
	
	private function updateAfterStateChange():Void
	{
		if (!initialized) {
			return;
		}
		validateNow();		
		
		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}
	
	private function configUI():Void
	{
		constraints = new Constraints(this, true);
		if (!_disableConstraints) {
			constraints.addElement(textField, Constraints.ALL);
		}
		if (_autoSize != "none") {
			sizeIsInvalid = true;
		}
		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		
		//사용하기 버튼 클릭
		btn_use.addEventListener("rollOver",this,"onUseBtnRollOver");
		btn_use.addEventListener("rollOut",this,"onUseBtnRollOut");
		btn_use.addEventListener("click",this,"onUseBtnPress");			
		
		if (focusIndicator != null && !_focused && focusIndicator._totalFrames == 1) { focusIndicator._visible = false; }
		
		focusTarget = owner;
	}
	
	public function draw()
	{
		super.draw();
		
		txt_item.text = t_item
		btn_use.label="friend_add"
		btn_use.disabled=(isDisable == "0"||isDisable ==null) ? false : true;
	}
	
	private function onUseBtnRollOver(e:Object):Void
	{
		btn_use.setState("over");
	}

	private function onUseBtnRollOut(e:Object):Void
	{
		btn_use.setState("up");
	}
	private function onUseBtnPress(e:Object):Void
	{
		var n = this.index;
		ExternalInterface.call("facebook_friend_add_btn_click",n);
	}
	
	private function onListPress(e:Object):Void
	{
		var n = this.index;
		ExternalInterface.call("facebook_friend_add_list_click",n);
	}
	
	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void
	{
		setState("over");
	}
	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void
	{
		setState("out");
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void
	{
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}
	private function handleMouseRelease(mouseIndex:Number, button:Number):Void
	{
		setState("release");
		handleClick(mouseIndex,button);
	}
}