/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Delegate;
import flash.filters.ColorMatrixFilter;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
 class com.scaleform.udk.controls.ClanMarkList extends ListItemRenderer {
	private var modeIcon:MovieClip;
	private var txtUnitName:MovieClip;

	private var _img:String;
	private var hit:MovieClip;// instance of a generic MovieClip on the bottom-most layer of the component.
	/*private var BlackObj:ColorMatrixFilter;
	private var NormalObj:ColorMatrixFilter;*/

	public function ClanMarkList() {
		super();
		/*BlackObj = new ColorMatrixFilter();
		NormalObj = new ColorMatrixFilter();
		BlackObj.matrix = new Array(1/3, 1/3, 1/3, 0, 0, 1/3, 1/3, 1/3, 0, 0, 1/3, 1/3, 1/3, 0, 0, 0, 0, 0, 1, 0);
		NormalObj.matrix = new Array(1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0);*/
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);

		_img = data.IconImg;
		
		if(data.IconImg==""){
			txtUnitName._y=54
			txtUnitName.text = "선택 안함"
		}else{
			txtUnitName._y=93
			txtUnitName.text = data.IconImg;
		}
		trace("_shop_unit_name_"+data.IconImg);
		lvLoader();

	}
	private function lvLoader(caseBy:String) {
		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(data.ImgPath+data.IconImg,modeIcon);
	}
	//private function onLoadComplete(mc:MovieClip)
	private function onLoadInit(mc:MovieClip) {
		mc._xscale=70
		mc._yscale=70
	}
	private function UpdateTextFields() {
		lvLoader();
	}
	private function handleMousePress(mouseIndex:Number, button:Number):Void {
		if (_disabled) {
			return;
		}
		if (!_disableFocus) {
			Selection.setFocus(this);
		}
		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"press", mouseIndex:mouseIndex, button:button});
	}


	private function handleMouseRollOver(mouseIndex:Number, button:Number):Void {

		setState("over");// Focus changes in the setState will override those in the changeFocus (above)
		//modeIcon.filters=[NormalObj]
		dispatchEvent({type:"rollOver", mouseIndex:mouseIndex, button:button});

	}

	private function handleMouseRelease(mouseIndex:Number, button:Number):Void {

		setState("down");// Focus changes in the setState will override those in the changeFocus (above)
		//modeIcon.filters=[NormalObj]
		dispatchEvent({type:"click", mouseIndex:mouseIndex, button:button});


	}

	private function handleMouseRollOut(mouseIndex:Number, button:Number):Void {
		//modeIcon.filters=[BlackObj]
		setState("up");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"rollOut", mouseIndex:mouseIndex, button:button});
		var no = this.owner["_selectedIndex"];

	}

	private function handleReleaseOutside(mouseIndex:Number, button:Number):Void {
		//modeIcon.filters=[BlackObj]
		setState("up");// Focus changes in the setState will override those in the changeFocus (above)
		dispatchEvent({type:"rollOut", mouseIndex:mouseIndex, button:button});
		var no = this.owner["_selectedIndex"];


	}



	private function draw():Void {
		if (sizeIsInvalid) {// The size has changed.   
			_width = __width;
			_height = __height;
		}
	}

	private function configUI():Void {

		// Setup MouseEvents on the "hit" MovieClip on the bottom-most layer of the
		// component on the Stage. This allows Mouse events to reach the sub-components.
		hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		hit.onPress = Delegate.create(this, handleMousePress);
		hit.onRelease = Delegate.create(this, handleMouseRelease);
		hit.onDragOver = Delegate.create(this, handleDragOver);
		hit.onDragOut = Delegate.create(this, handleDragOut);
		hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);

		focusTarget = owner;
	}

	private function changeFocus():Void {
		if (_disabled) {
			return;
		}
		if (hit == null) {
			setState((_focused || _displayFocus) ? "over" : "up");
		}
		if (hit != null) {
			setState("up");

		}
	}


}