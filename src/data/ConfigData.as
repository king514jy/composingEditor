package src.data
{
	import com.kingclass.utils.Base64;
	import com.kingclass.utils.PassHandler;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import src.conmponents.Plane;
	import src.events.ConfigEvent;
	
	public class ConfigData extends EventDispatcher
	{
		private var xmlHead:String = '<?xml version="1.0" encoding="utf-8" ?>';
		public function ConfigData()
		{
			
		}
		public function outputComposing(planList:Vector.<Plane>):void
		{
			var xml:XML = <data></data>
			for each(var plane:Plane in planList)
			{
				var lev:int = plane.parent.getChildIndex(plane) - 2;
				var scale:Number = Math.floor(plane.scaleX * 1000) * 0.001;
				var ro:Number = Math.floor(plane.rotation * 1000) * 0.001;
				var planeItem:XML = <planeItem level={lev} x={plane.x} y={plane.y} scale={scale} rotation={ro} 
									shadow={plane.shadow} blurX={plane.blurX} blurY={plane.blurY} strength={plane.strength} 
										angle={plane.angle} distance={plane.distance} />
				xml.appendChild(planeItem);
			}
			var xmlStr:String = xml.toString();
			var pattern:RegExp =  /\n/g;
			xmlStr = xmlStr.replace(pattern, "\r\n");
			var byt:ByteArray = new ByteArray();
			byt.writeUTFBytes(PassHandler.encryption(Base64.encode(String(xmlHead + "\r\n" + xmlStr))));
			byt.compress();
			var file:File = File.desktopDirectory.resolvePath("config.ky");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			//fileStream.writeUTFBytes(String(xmlHead + "\r\n" + xmlStr));
			fileStream.writeBytes(byt);
			fileStream.close();
			dispatchEvent(new ConfigEvent(ConfigEvent.OUTPUT_COMPLETE));
		}
	}
}