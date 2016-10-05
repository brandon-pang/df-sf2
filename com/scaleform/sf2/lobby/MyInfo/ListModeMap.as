
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import gfx.controls.Button;
import gfx.utils.Delegate;
import com.scaleform.udk.utils.UDKUtils 
import flash.external.ExternalInterface;
import flash.filters.ColorMatrixFilter;


class com.scaleform.sf2.lobby.MyInfo.ListModeMap extends ListItemRenderer
{
	//public var index:Number;
	//public var owner:CoreList;
   // public var selectable:Boolean = true;
	public var itemImg:MovieClip;
	//public var txtNo:TextField;
	public var txtName:TextField;
	private var _itemimg:String;
	private var _itemname:String;
	private var _hit:MovieClip;
	private var BlackObj:ColorMatrixFilter
	private var NormalObj:ColorMatrixFilter
	public var selectable:Boolean = false;
	
	public function ListModeMap() { 
		super();		
		BlackObj=new ColorMatrixFilter();
		NormalObj=new ColorMatrixFilter();
		BlackObj.matrix=new Array(1/3,1/3,1/3,0,0,
								  1/3,1/3,1/3,0,0,
								  1/3,1/3,1/3,0,0,
								  0,0,0,1,0)
		
		NormalObj.matrix=new Array(1,0,0,0,0,
								   0,1,0,0,0,
								   0,0,1,0,0,
								   0,0,0,1,0)
	}

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		}
		this.data = data;
		invalidate();
		this._visible = true;		
		super.setData(data);
		_itemimg  = data.IconImg;
		_itemname = data.Title;
		UpdateTextFields();
	}
	
	private function lvLoader(n:String)
	{
		var imgPathMap:String;
		var imgName = _itemimg;

		if (_global.gfxPlayer)
		{			
			imgPathMap = "d:/UI_DESIGN_SVN/이미지셋/맵/맵선택/"+imgName+".png";
		}
		else
		{
			imgPathMap = UDKUtils.MapImgPath + imgName;
		}

		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPathMap,itemImg);
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		mc._xscale = mc._yscale = 71;
		mc._x = - 12;
		mc._y = - 5;
		
		itemImg.filters = [BlackObj]
	}	
	
	private function updateAfterStateChange():Void {
		// Redraw should only happen AFTER the initialization.
		if (!initialized) { return; }		
		
		validateNow();// Ensure that the width/height is up to date.
		
		if (constraints != null) { 
			constraints.update(width, height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}	

	private function UpdateTextFields() {
		txtName.htmlText = _itemname;
		lvLoader();
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
		_hit.onRollOver = Delegate.create(this, handleMouseRollOver);
		_hit.onRollOut = Delegate.create(this, handleMouseRollOut);
		_hit.onPress = Delegate.create(this, handleMousePress);
		_hit.onRelease = Delegate.create(this, handleMouseRelease);
		_hit.onDragOver = Delegate.create(this, handleDragOver);
		_hit.onDragOut = Delegate.create(this, handleDragOut);
		_hit.onReleaseOutside = Delegate.create(this, handleReleaseOutside);
		

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1)
		{
			focusIndicator._visible = false;
		}

		focusTarget = false;
	}


	public function draw()
	{
		super.draw();

	}
	
	
}