
class com.scaleform.udk.controls.idCardMath
{
	
	public static function Point (c:Array, a:Number, d:Number):Array
	{
		var x:Number, y:Number, r:Number;
		r = a * 2 * Math.PI / 360;
		x = (c) ? d * Math.cos(r) + c[0] : d * Math.cos(r);
		y = (c) ? d * Math.sin(r) + c[1] : d * Math.sin(r);
		return [x,y];
		
		trace("정보1"+x+"정보2"+y)
	};

}