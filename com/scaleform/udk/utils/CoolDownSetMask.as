import gfx.events.EventDispatcher;
import gfx.utils.Delegate;
import flash.geom.Rectangle;
import flash.geom.Point;
/**
 * @author noww
 */
class com.scaleform.udk.utils.CoolDownSetMask
{
	public var _progressed:Boolean = false;
	
	// EventDispatcher mix-in
	/** Mixed in from {@link EventDispatcher#addEventListener EventDispatcher} */
	public var addEventListener:Function;	
	/** Mixed in from {@link EventDispatcher#removeEventListener EventDispatcher} */ 
	public var removeEventListener:Function;
	/** Mixed in from {@link EventDispatcher#hasEventListener EventDispatcher} */
	public var hasEventListener:Function;
	/** Mixed in from {@link EventDispatcher#removeAllEventListeners EventDispatcher} */
	public var removeAllEventListeners:Function;	
	/** Mixed in from {@link EventDispatcher#cleanUpEvents EventDispatcher} */
	private var cleanUpEvents:Function;
	/** Mixed in from {@link EventDispatcher#dispatchEvent EventDispatcher} */
	private var dispatchEvent:Function;
	
	private var _increaseCool:Boolean = false;
	private var _offset:Number;
	
	private var _progressX:Number;
	private var _progressY:Number;
	
	private var _maskWidth:Number;
	private var _maskHeight:Number;
	
	private var _tempTime:Number = 0;
	private var _unitTime:Number;
	private var _deltaTime:Number;
	private var _cooldownTime:Number;
	private var _maskPhase:Number;
	private var _maskClip:MovieClip;
	
	//마스크 컬러정보
	private var _maskRGBA:Number;
	private var _lineRGBA:Number;
	private var _lineWidth:Number;
	
	
	
	public function CoolDownSetMask(target:MovieClip, maskWidth:Number, maskHeight:Number, increaseCool:Boolean)
	{	
		EventDispatcher.initialize(this);
		
		_maskWidth = maskWidth;
		_maskHeight = maskHeight;
		
		_progressX = _maskWidth/2;
		_progressY = 0;
		
		_increaseCool = increaseCool;
		
		_maskClip = target.createEmptyMovieClip("cooldownMC", target.getNextHighestDepth());
		//_maskClip.setMask(target.buffOver);
		
		_maskRGBA = 0x0000001E;
		_lineRGBA = 0x00000000;
		_lineWidth = 0;
	}
	
	public function setMaskColor(maskRGBA:Number, lineRGBA:Number, lineWidth:Number):Void
	{
		_maskRGBA = maskRGBA;
		_lineRGBA = lineRGBA;
		_lineWidth = lineWidth;
	}
	
	public function reset():Void
	{
		_maskClip.clear();
		delete _maskClip.onEnterFrame;
		_maskClip.onEnterFrame = null;
		_maskPhase = 0;
		_progressX = _maskWidth/2;
		_progressY = 0;
		_tempTime = 0;
		_progressed = false;
	}
	
	public function start(deltaTime:Number, cooldownTime:Number):Void
	{
		if (cooldownTime == 0 || cooldownTime == null || deltaTime > cooldownTime) { return; }
		_maskPhase = 0;
		_tempTime = 0;
		_deltaTime = deltaTime;
		_cooldownTime = cooldownTime;
		_offset = getTimer();
		_unitTime = setUnitTime();
		if (!_increaseCool && deltaTime == 0) { fullRectDraw(); }
		_maskClip.onEnterFrame = Delegate.create(this, checkEnterFrame);
		_progressed = true;
	}
	
	private function setUnitTime():Number
	{
		if (_cooldownTime <= 60000)
		{
			return 10;
		}
		else if (_cooldownTime <= 300000)
		{
			return 100;
		}
		else if (_cooldownTime <= 600000)
		{
			return 500;
		}
		else if (_cooldownTime <= 1800000)
		{
			return 1000;
		}
		else if (_cooldownTime <= 3600000)
		{
			return 5000;
		}
		else if (_cooldownTime > 3600000)
		{
			return 10000;
		}
	}
	
	private function checkEnterFrame():Void
	{
		var time:Number = (getTimer() - _offset + _deltaTime);
		if (time >= _cooldownTime)
		{
			reset();
			dispatchEvent({type:"coolDownEnd",target:_maskClip});
			return;
		}
		
		var tempTime:Number = Math.floor(time/_unitTime);
		if (_tempTime != tempTime)
		{
			update(time);
			_tempTime = tempTime;
		}
		dispatchEvent({type:"coolDownProgress", remainTime:_cooldownTime - time,target:_maskClip});
	}
	
	private function update(deltaTime:Number):Void
	{
		
		var degree:Number = deltaTime * 2 * Math.PI / _cooldownTime;
		if (degree < Math.PI/4) 
		{
			_maskPhase = 0;
			_progressX = _maskWidth/2 + Math.tan(degree)*_maskHeight/2;
			_progressY = 0;
		}
		else if (degree < Math.PI*2/4)
		{
			_maskPhase = 1;
			_progressX = _maskWidth;
			_progressY = _maskHeight/2 - Math.tan(Math.PI/2-degree)*_maskWidth/2;
		}
		else if (degree < Math.PI*3/4)
		{
			_maskPhase = 1;
			_progressX = _maskWidth;
			_progressY = _maskHeight/2 + Math.tan(degree-Math.PI/2)*_maskWidth/2;
		}
		else if (degree < Math.PI)
		{
			_maskPhase = 2;
			_progressX = _maskWidth/2 + Math.tan(Math.PI-degree)*_maskHeight/2;
			_progressY = _maskHeight;
		}
		else if (degree < Math.PI*5/4)
		{
			_maskPhase = 2;
			_progressX = _maskWidth/2 - Math.tan(degree-Math.PI)*_maskHeight/2;
			_progressY = _maskHeight;
		}
		else if (degree < Math.PI*6/4)
		{
			_maskPhase = 3;
			_progressX = 0;
			_progressY = _maskHeight/2 + Math.tan(Math.PI*6/4-degree)*_maskWidth/2;
		}
		else if (degree < Math.PI*7/4)
		{
			_maskPhase = 3;
			_progressX = 0;
			_progressY = _maskHeight/2 - Math.tan(degree-Math.PI*6/4)*_maskWidth/2;
		}
		else if (degree < Math.PI*8/4)
		{
			_maskPhase = 4;
			_progressX = _maskWidth/2 - Math.tan(Math.PI*8/4-degree)*_maskHeight/2;
			_progressY = 0;
		}
		
		_increaseCool?drawIncrease():draw();
	}
	
	private function draw():Void
	{
		_maskClip.clear();
		_maskClip.lineStyle(_lineWidth, (_lineRGBA&0xFFFFFF00)>>8, _lineRGBA&0x000000FF);
		_maskClip.beginFill((_maskRGBA&0xFFFFFF00)>>8, _maskRGBA&0x000000FF);
		_maskClip.moveTo(_progressX, _progressY);	
		
		switch (_maskPhase)
		{
			case 0 :
				{
					_maskClip.lineTo(_maskWidth, 0);
				};

			case 1 :
				{
					_maskClip.lineTo(_maskWidth, _maskHeight);
				};
			case 2 :
				{
					_maskClip.lineTo(0, _maskHeight);
				};
			case 3 :
				{
					_maskClip.lineTo(0, 0);
				};
			case 4 :
				{
					_maskClip.lineTo(_maskWidth/2, 0);
					_maskClip.lineTo(_maskWidth/2, _maskHeight/2);
				};
				break;
		}
		_maskClip.endFill();
	}
	
	private function drawIncrease():Void
	{
		_maskClip.clear();
		_maskClip.lineStyle(_lineWidth, (_lineRGBA&0xFFFFFF00)>>8, _lineRGBA&0x000000FF);
		_maskClip.beginFill((_maskRGBA&0xFFFFFF00)>>8, _maskRGBA&0x000000FF);

		_maskClip.moveTo(_progressX, _progressY);		
		switch (_maskPhase)
		{
			case 4 :
				{
					_maskClip.lineTo(0, 0);
				};
			case 3 :
				{
					_maskClip.lineTo(0, _maskHeight);
				};
			case 2 :
				{
					_maskClip.lineTo(_maskWidth, _maskHeight);
				};
			case 1 :
				{
					_maskClip.lineTo(_maskWidth, 0);
				};
			case 0 :
				{
					_maskClip.lineTo(_maskWidth/2, 0);
					_maskClip.lineTo(_maskWidth/2, _maskHeight/2);
				};
				break;
		}
		_maskClip.endFill();
	}
	
	private function fullRectDraw():Void
	{
		_maskClip.clear();
		_maskClip.lineStyle(_lineWidth, (_lineRGBA&0xFFFFFF00)>>8, _lineRGBA&0x000000FF);
		_maskClip.beginFill((_maskRGBA&0xFFFFFF00)>>8, _maskRGBA&0x000000FF);

		_maskClip.moveTo(0, 0);
		_maskClip.lineTo(0, _maskHeight);
		_maskClip.lineTo(_maskWidth, _maskHeight);
		_maskClip.lineTo(_maskWidth, 0);
		_maskClip.endFill();
	}
	
}