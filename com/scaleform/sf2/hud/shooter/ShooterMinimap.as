/**
 * ...
 * @author 
 */

import gfx.layout.Panel;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterMinimap extends Panel
{
	
	public var minimapCont:MovieClip;
	
	private var mcLoader:MovieClipLoader;
	
    public function ShooterMinimap()
    {         
        super();
        
        mcLoader = new MovieClipLoader();
        mcLoader.addListener(this);
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function minimapLoad():Void
	{
		mcLoader.loadClip("Minimap_re.swf", minimapCont.container);
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
	private function onLoadInit(mc:MovieClip)
	{
		minimapCont.container.minimap.secterBar._visible = false;
		minimapCont.container.minimap.zoomBar._visible = false;
		minimapCont.container.minimap.bg._visible = false;
		
		minimapCont.container.minimap.zigAni._visible = false;
		minimapCont.container.minimap.mask_mc._width = 194;
		minimapCont.container.minimap.mask_mc._height = 136;
	}
	
}