
/**
 *  유틸리티 클래스.
 *
 *  @author noww
 */ 
class com.scaleform.udk.utils.Tool
{
    
   
	public function Tool()
	{
		super();
	}
	
    /**
     *  랜덤함수
     */
	public static function randRange(min:Number, max:Number):Number 
	{
	    var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
	    return randomNum;
	}
	
    /**
     *  텍스트 byte 계산
     */
	public static function getByteString(_data:String):Number 
	{
		var _txt:String = _data;
		var _bytes:Number = 0;
		for (var i:Number = 0 ; i < _txt.length ; i++) {
			var _code:Number = _txt.charCodeAt(i);
				if (_code >= 0 && _code <= 120) {
					_bytes += 1;
				} else {
					_bytes += 2;
			}
		}
		
		return _bytes;
	}
	
	/**
     *  금액 천단위로 콤마
     */
	public static function comma(num:Number):String
	{
		if (isNaN(num)) return "-";
		
		var arr:Array = String(num).split("");
		var tlen:Number = arr.length;
		var clen:Number = Math.ceil(tlen / 3);
		
		for (var i:Number = 1; i < clen; i++)
		{
			arr.splice(tlen - i * 3, 0, ",");
		}
		
		return arr.join("");
	}
	
	public static function drawWeadge(mc:MovieClip, x, y, startAngle, arc, radius, yRadius):MovieClip {
		if (arguments.length<5) {
			return;
		}
		// move to x,y position
		mc.moveTo(x, y);
		// if yRadius is undefined, yRadius = radius
		if (yRadius == undefined) {
			yRadius = radius;
		}
		// Init vars
		var segAngle, theta, angle, angleMid, segs, ax, ay, bx, by, cx, cy;
		// limit sweep to reasonable numbers
		if (Math.abs(arc)>360) {
			arc = 360;
		}
		// Flash uses 8 segments per circle, to match that, we draw in a maximum
		// of 45 degree segments. First we calculate how many segments are needed
		// for our arc.
		var segs = Math.ceil(Math.abs(arc)/45);
		// Now calculate the sweep of each segment.
		var segAngle = arc/segs;
		// The math requires radians rather than degrees. To convert from degrees
		// use the formula (degrees/180)*Math.PI to get radians.
			theta = -(segAngle/180)*Math.PI;
		// convert angle startAngle to radians
		var angle = -(startAngle/180)*Math.PI;
		// draw the curve in segments no larger than 45 degrees.
		if (segs>0) {
			// draw a line from the center to the start of the curve
			var ax = x+Math.cos(startAngle/180*Math.PI)*radius;
			var ay = y+Math.sin(-startAngle/180*Math.PI)*yRadius;
			mc.lineTo(ax, ay);
			// Loop for drawing curve segments
			for (var i = 0; i<segs; i++) {
				angle += theta;
				angleMid = angle-(theta/2);
				var bx = x+Math.cos(angle)*radius;
				var by = y+Math.sin(angle)*yRadius;
				var cx = x+Math.cos(angleMid)*(radius/Math.cos(theta/2));
				var cy = y+Math.sin(angleMid)*(yRadius/Math.cos(theta/2));
				mc.curveTo(cx, cy, bx, by);
			}
			// close the wedge by drawing a line to the center
			mc.lineTo(x, y);
		}
		
		return mc
	}


}
