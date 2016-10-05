/**
 * ...
 * @author 
 */

import gfx.controls.ButtonBar;

[InspectableList("disabled", "visible", "itemRenderer", "spacing", "autoSize", "buttonWidth", "buttonHeight","direction", "enableInitCallback")]

class com.scaleform.ButtonBarEx extends ButtonBar
{
	
    public function ButtonBarEx()
    {         
        super();
    }
	
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function populateData():Void {
		for (var i:Number = 0; i < renderers.length; i++) {
			var renderer:MovieClip = renderers[i];
			renderer.label = itemToLabel(_dataProvider.requestItemAt(i));
			if (renderer.setData)
			{
				renderer.setData(_dataProvider.requestItemAt(i));
			}
			else
			{
				renderer.data = _dataProvider.requestItemAt(i);
			}
			renderer.disabled = _disabled;
		}		
	}
}