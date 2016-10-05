/**
 * ...
 * @author 
 */
 
import gfx.controls.UILoader;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints", "enableInitCallback")]
class com.scaleform.udk.controls.PictureBoxThumbListItem extends ListItemRenderer
{
	public var loader:UILoader;
	public var loadingMC:MovieClip;
	
	private var intervalId:Number;
	private var isLoading:Boolean = false;
	
	public function PictureBoxThumbListItem()
	{
		super();
	}
	
	public function setData(data:Object):Void
	{
		clearInterval(intervalId);
		if (data == null)
		{
			this.data = null;
			_parent["itemBg"+((index%5)+1)]._visible = true;
			visible = false;
			loadingMC.gotoAndStop(1);
			isLoading = false;
			if(loader.initialized) { loader.unload(); }
			return;
		}
		
		this.data = data;
		_parent["itemBg"+((index%5)+1)]._visible = false;
		visible = true;
		if (loader.source == this.data.url)
		{
			loadingMC.gotoAndStop(1);
			isLoading = false;
			return;
		}
		loader.unload();
		if (selected)
		{
			onLoadInterval();
			dispatchEvent({type:"selectedSetData", data:data});
		}
		else
		{
			if (!isLoading)
			{
				loadingMC.gotoAndPlay("open");
			}
			isLoading = true;
			intervalId = setInterval(this, "onLoadInterval", (200 + ((index%5)+1)*100));
		}
	}
	
	private function onLoadInterval():Void
	{
		clearInterval(intervalId);
		loader.source = this.data.url;
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		loader.addEventListener("complete", this, "onLoaderComplete");
	}
	
	private function onLoaderComplete(e:Object):Void
	{
		loadingMC.gotoAndStop(1);
		isLoading = false;
	}
	
	
}