package starling.utils
{
	import flash.geom.Matrix;
	
	/** Appends a skew transformation to a matrix, with angles in radians. */
	public function skew(matrix:Matrix, skewX:Number, skewY:Number):void
	{
		var a:Number = matrix.a;
		var b:Number = matrix.b;
		var c:Number = matrix.c;
		var d:Number = matrix.d;
		var tanX:Number = Math.tan(skewX);
		var tanY:Number = Math.tan(skewY);
		
		
		matrix.a = a + b * tanX;
		matrix.b = a * tanY + b;
		matrix.c = c + d * tanX;
		matrix.d = c * tanY + d; 
	}
}