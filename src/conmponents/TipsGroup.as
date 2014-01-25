package src.conmponents
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class TipsGroup extends Sprite
	{
		private var txt:TextField;
		private var time:int;
		private var oldTime:int;
		public function TipsGroup()
		{
			txt = this.getChildByName("tips_txt") as TextField;
		}
		public function set tips(str:String):void
		{
			txt.text = str;
		}
		public function get tips():String{ return txt.text; }
		public function close(time:int):void
		{
			this.time = time;
			oldTime = getTimer();
			this.addEventListener(Event.ENTER_FRAME,run);
		}
		private function run(e:Event):void
		{
			if(getTimer() - oldTime > time)
			{
				this.parent.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME,run);
			}
		}
	}
}