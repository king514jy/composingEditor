package src.events
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import fl.containers.UILoader;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	
	public class SetEvent extends Event
	{
		public static const MAGNIFY:String = "magnify";
		public static const MINIFY:String = "minify";
		public static const REGAIN_SCALE:String = "regain_scale";
		public static const ADD_REFER:String = "add_refer";
		public static const ADD_COMPOSING:String = "add_composing";
		public static const DELETE_COMPOSING:String = "add_composing";
		public static const SET_SAMPLE_X:String = "set_sample_x";
		public static const SET_SAMPLE_Y:String = "set_sample_y";
		public static const SET_SAMPLE_SCALE:String = "set_sample_scale";
		public static const SET_SAMPLE_ROTATION:String = "set_sample_rotation";
		public static const OPEN_SAMPLE_SHADOW:String = "open_sample_show";
		public static const SET_BLUR_ALPHA:String = "set_blur_alpha";
		public static const SET_BLUR_X:String = "set_blur_x";
		public static const SET_BLUR_Y:String = "set_blur_y";
		public static const SET_BLUR_STRENGTH:String = "set_blur_strength";
		public static const SET_BLUR_ANGLE:String = "set_blur_angle";
		public static const SET_BLUR_DISTANCE:String = "set_blur_distance";
		public static const OUTPUT_CONFIG:String = "output_config";
		
		private var _info:String;
		private var _number:Number;
		public function SetEvent(type:String,info:String="",number:Number=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_info = info;
			_number = number;
		}
		public function get info():String{ return _info; }
		public function get number():Number{ return _number; }
	}
}