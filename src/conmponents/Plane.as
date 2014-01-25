package src.conmponents
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import fl.controls.CheckBox;
	import fl.controls.NumericStepper;
	
	public class Plane extends Sprite
	{
		private var _shadow:Boolean;
		private var _alphaShadow:Number = 1;
		private var _blurX:Number = 10;
		private var _blurY:Number = 10;
		private var _strength:Number = 1;
		private var _angle:Number = 45;
		private var _distance:Number = 5;
		public function Plane(bmp:Bitmap)
		{
			bmp.x = -bmp.width * 0.5;
			bmp.y = -bmp.height * 0.5;
			this.addChild(bmp);
		}
		public function set shadow(b:Boolean):void
		{
			_shadow = b;
			setShadow();
		}
		public function get shadow():Boolean{ return _shadow; }
		public function set alphaShadow(n:Number):void
		{
			_alphaShadow = n;
			setShadow();
		}
		public function get alphaShadow():Number{ return _alphaShadow; }
		public function set blurX(n:Number):void
		{
			_blurX = n;
			setShadow();
		}
		public function get blurX():Number{ return _blurX; }
		public function set blurY(n:Number):void
		{
			_blurY = n;
			setShadow();
		}
		public function get blurY():Number{ return _blurY; }
		public function set strength(n:Number):void
		{
			_strength = n;
			setShadow();
		}
		public function get strength():Number{ return _strength; }
		public function set angle(n:Number):void
		{
			_angle = n;
			setShadow();
		}
		public function get angle():Number{ return _angle; }
		public function set distance(n:Number):void
		{
			_distance = n;
			setShadow();
		}
		public function get distance():Number{ return _distance; }
		private function setShadow():void
		{
			if(_shadow)
				TweenMax.to(this, 0.1, {dropShadowFilter:{color:0x000000, alpha:_alphaShadow, blurX:_blurX, blurY:_blurX, 
														strength:_strength, angle:_angle, distance:_distance}});
			else
				this.filters = null;
		}
	}
}