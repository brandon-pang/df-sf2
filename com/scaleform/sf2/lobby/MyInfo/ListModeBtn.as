
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;
import flash.external.ExternalInterface;


class com.scaleform.sf2.lobby.MyInfo.ListModeBtn extends ListItemRenderer
{
	//public var index:Number;
	//public var owner:CoreList;
    //public var selectable:Boolean = true;
	public var itemImg:MovieClip;
	public var txtName:TextField;
	private var _itemimg:String;
	private var _itemname:String;
	private var _hit:MovieClip;
	
	public function ListModeBtn(){ super(); }

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		} 		
		this.data = data;
		this._visible = true;

		_itemimg  = data.IconImg;
		_itemname = data.Title;
		
        var img   = _itemimg;
		var name  = _itemname;
		
		lvLoader();
		txtName.htmlText = name;
		
		invalidate();
	}
	
	private function lvLoader(n:String)
	{
		var imgPathMode:String;
		var imgName = _itemimg;

		if (_global.gfxPlayer)
		{			
			imgPathMode = "d:/UI_DESIGN_SVN/이미지셋/모드아이콘/"+imgName+".png";
		}
		else
		{
			imgPathMode = UDKUtils.ModeImgPath + imgName;
		}

		var mcLoader:MovieClipLoader = new MovieClipLoader();
		mcLoader.addListener(this);
		mcLoader.loadClip(imgPathMode,itemImg.img);
	}

	private function onLoadInit(mc:MovieClip)
	{
		//mc._xscale = mc._yscale = 75;
		//mc._x = - 12;
		//mc._y = - 10;
	}

	private function updateAfterStateChange():Void
	{
		//txtName.htmlText = name;
		if (!initialized)
		{
			return;
		}

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
		focusTarget = owner;
	}
	
	public function draw()
	{
		super.draw();
	}   
}