
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import gfx.utils.Constraints;
import com.scaleform.udk.utils.UDKUtils;
import flash.external.ExternalInterface;


class com.scaleform.sf2.lobby.MyInfo.ListSaveMap extends ListItemRenderer
{
	public var itemImg:MovieClip;
	public var txtNo:TextField;
	public var txtName:TextField;
	private var _itemimg:String;
	private var _itemname:String;
	private var _hit:MovieClip;
	private var txt_bg:MovieClip;
	
	public function ListSaveMap(){ super(); }

	public function setData(data:Object):Void
	{
		if (data == undefined) {
			this._visible = false;
			return;
		} 	
		invalidate();
		this.data = data;
		this._visible = true;
		
		_itemimg  = data.IconImg;
		_itemname = data.Title;
		
        var img   = _itemimg;
		var name  = _itemname;
		
		if (_itemname==""||_itemname==null) {
			txt_bg._visible = false;
		}else {
			txt_bg._visible = true;
		}		
		lvLoader();
		txtName.htmlText = name;
		txtNo.htmlText = this.index+1;
		
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
		mc._xscale = mc._yscale = 65;
		mc._x = - 12;
		mc._y = - 10;
	}

	private function updateAfterStateChange():Void
	{
		if (!initialized)
		{
			return;
		}

		if (constraints != null)
		{
			constraints.update(width,height);
		}
		dispatchEvent( { type:"stateChange", state:state } );
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