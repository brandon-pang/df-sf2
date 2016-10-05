/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.controls.TileList;

class com.scaleform.udk.controls.ShopCharMaskList extends ListItemRenderer
{
	public var charShopItemList:TileList;
	public var _id:Number;
	private var tagSet:MovieClip;

	public function ShopCharMaskList()
	{
		super();		
	}

	public function setData(data:Object):Void
	{

		if (data == undefined || data.No == "")
		{
			this._visible = false;
			return;
		}

		this.data = data;
		
		this._visible = true;
		
		if (Number(data.Stat) != 0)
		{
			if(data.RowTitle != undefined){
				tagSet.txt.text = data.RowTitle;
				tagSet.txt.textColor = "0x000000"
				if (Number(data.Stat) == 1){					
				}else if (Number(data.Stat) == 2){
					tagSet.txt.textColor = "0xffffff"					
				}else if (Number(data.Stat) == 3){					
				}
			}else{					
				if (Number(data.Stat) == 1){
					tagSet.txt.text = "_take_item"
				}else if (Number(data.Stat) == 2){
					tagSet.txt.text = "_special_item"
					tagSet.txt.textColor = "0xffffff"
				}else if (Number(data.Stat) == 3){
					tagSet.txt.text = "_normal_item"
				}
			}	
			tagSet.gotoAndStop(Number(data.Stat));
			tagSet._visible = true;
		}
		else if(Number(data.Stat)==0)
		{
			tagSet._visible = false;
		}
		//_dataProvider = data.DataProvider; 
		//trace(data.dataProvider.toString());
		charShopItemList.dataProvider = data.dataProvider;
		_id = this.index;
	}

	public function updateAfterStateChange():Void
	{	

		if (Number(data.Stat) != 0)
		{
			if(data.RowTitle != undefined){
				tagSet.txt.text = data.RowTitle;
				tagSet.txt.textColor = "0x000000"
				if (Number(data.Stat) == 1){					
				}else if (Number(data.Stat) == 2){
					tagSet.txt.textColor = "0xffffff"					
				}else if (Number(data.Stat) == 3){					
				}
			}else{					
				if (Number(data.Stat) == 1){
					tagSet.txt.text = "_take_item"
				}else if (Number(data.Stat) == 2){
					tagSet.txt.text = "_special_item"
					tagSet.txt.textColor = "0xffffff"
				}else if (Number(data.Stat) == 3){
					tagSet.txt.text = "_normal_item"
				}
			}	
			tagSet.gotoAndStop(Number(data.Stat));
			tagSet._visible = true;
		}
		else
		{
			tagSet._visible = false;
		}
		
		charShopItemList.dataProvider = data.dataProvider;
		_id = this.index;

		if (!initialized)
		{
			return;
		}
		//validateNow();// Ensure that the width/height is up to date. 
		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}

	private function configUI():Void
	{
		constraints = new Constraints(this, true);

		if (!_disableConstraints)
		{
			constraints.addElement(textField,Constraints.ALL);
		}

		if (!_autoSize)
		{
			sizeIsInvalid = true;
		}
		//_hit.onRollOver = Delegate.create(this, handleMouseRollOver);           
		//_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		//_hit.onPress = Delegate.create(this, handleMousePress);
		//_hit.onRelease = Delegate.create(this, handleMouseRelease);
		//_hit.onDragOver = Delegate.create(this, handleDragOver);
		//_hit.onDragOut = Delegate.create(this, handleDragOut);
		//_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);*/ 
		//checkBox._disableFocus = true;

		//checkBox.addEventListener("click",this,"onChkHandler");
		//checkBox.addEventListener("rollOver",this,"onChkOverHandler");
		//checkBox.addEventListener("rollOut",this,"onChkOutHandler");

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		
		charShopItemList.scrollWheelDisabled = true;
	}

	public function draw()
	{
		super.draw();

	}
	/**/
	
}