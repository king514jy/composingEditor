package src.events
{
	import flash.events.Event;
	
	public class ConfigEvent extends Event
	{
		public static const OUTPUT_COMPLETE:String = "output_complete"; 
		public function ConfigEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}