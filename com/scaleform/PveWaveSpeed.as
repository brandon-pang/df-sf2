/**
 * ...
 * @author 
 */

import com.greensock.easing.*; 
import com.greensock.TweenMax;
import com.scaleform.PveWaveSpeedCont;
import gfx.layout.Panel;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.PveWaveSpeed extends Panel
{
	public var waveSpeedCont:PveWaveSpeedCont;
	
	private var _speed:Number = 0;
	
    public function PveWaveSpeed()
    {         
        super();  
    }
	
	public function show(speed:Number):Void
	{
		_speed = speed;
		TweenMax.killTweensOf(waveSpeedCont);
		waveSpeedCont._x = 0;
		waveSpeedCont._y = 0;
		waveSpeedCont._xscale = 100;
		waveSpeedCont._yscale = 100;
		waveSpeedCont.setSpeed(speed);
		waveSpeedCont.gotoAndPlay("show");
	}
	
	public function hide():Void
	{
		TweenMax.killTweensOf(waveSpeedCont);
		waveSpeedCont.gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
		
		waveSpeedCont.addEventListener("openEnd", this, "onContOpenEnd");
		waveSpeedCont.addEventListener("closeEnd", this, "onContCloseEnd");
	}
	
	private function onContOpenEnd(e:Object):Void
	{
		if (_speed == 1)
		{
			hide();
		}
		else if (_speed > 1)
		{
			var point:Object = {x:_parent.pveModeInfo._x+60, y:_parent.pveModeInfo._y+2};
			this.globalToLocal(point);
			
			TweenMax.to(
							waveSpeedCont,
							0.5,
							{
								_x:			point.x,
								_y:			point.y,
								_xscale:	76,
								_yscale:	76,
								ease:		Cubic.easeOut
							}
						);
		}
	}
	
	private function onContCloseEnd(e:Object):Void
	{
		_speed = 0;
		waveSpeedCont.initCont();
	}
	
}