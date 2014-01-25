package src.conmponents
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformItem;
	import com.greensock.transform.TransformManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	
	public class ComposingGroup extends Sprite
	{
		public var planeList:Vector.<Plane>;
		private var refer:Bitmap;
		private var centerBmp:Bitmap;
		private var fileFilter:FileFilter;
		public var transformManager:TransformManager;
		public var setUI:SetUI;
		public var nowPlane:Plane;
		public function ComposingGroup()
		{
			centerBmp = new Bitmap(new CenterData());
			centerBmp.x = -centerBmp.width * 0.5;
			centerBmp.y = -centerBmp.height * 0.5;
			this.addChild(centerBmp);
			fileFilter = new FileFilter("图片","*.jpg;*.png");
			setTransformManager();
			planeList = new Vector.<Plane>();
		}
		private function setTransformManager():void
		{
			transformManager = new TransformManager();
			transformManager.constrainScale = true;
			transformManager.arrowKeysMove = true;
			transformManager.allowDelete = true;
			transformManager.allowMultiSelect = false;
			transformManager.autoDeselect = false;
			
			transformManager.addEventListener(TransformEvent.DELETE,deleteComposing);
			transformManager.addEventListener(TransformEvent.FINISH_INTERACTIVE_MOVE,finishMove);
			transformManager.addEventListener(TransformEvent.FINISH_INTERACTIVE_ROTATE,finishRotate);
			transformManager.addEventListener(TransformEvent.FINISH_INTERACTIVE_SCALE,finishScale);
		}
		private function finishMove(e:TransformEvent):void
		{
			var transformItem:TransformItem = e.items[0];
			setUI.setCoordinate(transformItem.x,transformItem.y);
		}
		private function finishRotate(e:TransformEvent):void
		{
			var transformItem:TransformItem = e.items[0];
			setUI.setRotation(transformItem.rotation);
		}
		private function finishScale(e:TransformEvent):void
		{
			var transformItem:TransformItem = e.items[0];
			setUI.setScale(transformItem.scaleX);
		}
		public function addRefer():void
		{
			var file:File = File.desktopDirectory;
			file.browseForOpen("选择参照图案",[fileFilter]);
			file.addEventListener(Event.SELECT,selectFile);
		}
		private function selectFile(e:Event):void
		{
			var file:File = e.target as File;
			var loader:Loader = new Loader();
			loader.load(new URLRequest(file.url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		private function onComplete(e:Event):void
		{
			if(refer)
			{
				this.removeChild(refer);
				refer.bitmapData.dispose();
				refer = null;
			}
			var loader:Loader = LoaderInfo(e.target).loader;
			refer = loader.content as Bitmap;
			refer.x = -refer.width * 0.5;
			refer.y = -refer.height * 0.5;
			this.addChildAt(refer,0);
		}
		public function addComposing(bmp:Bitmap):void
		{
			var plane:Plane = new Plane(bmp);
			planeList.push(plane);
			this.addChild(plane);
			var transformItem:TransformItem = transformManager.addItem(plane);
			transformItem.addEventListener(TransformEvent.SELECT,selectComposing);
			transformItem.addEventListener(TransformEvent.DESELECT,dSelectComposing);
		}
		private function deleteComposing(e:TransformEvent):void
		{
			var le:uint = e.items.length;
			for each(var item:TransformItem in e.items)
			{
				var plane:Plane = item.targetObject as Plane;
				planeList.splice(planeList.indexOf(plane),1);
			}
		}
		private function selectComposing(e:TransformEvent):void
		{
			var transformItem:TransformItem = e.items[0];
			nowPlane = transformItem.targetObject as Plane;
			setUI.setShowName("样片"+String(planeList.indexOf(nowPlane)));
			setUI.setShadowCheckBox(nowPlane.shadow);
			setUI.setCoordinate(nowPlane.x,nowPlane.y);
			setUI.setRotation(nowPlane.rotation);
			setUI.setScale(nowPlane.scaleX);
		}
		private function dSelectComposing(e:TransformEvent):void
		{
			setUI.setShowName("");
			setUI.setShadowCheckBox(false);
			setUI.setRotation(0);
			setUI.setCoordinate(0,0);
			setUI.setScale(0);
		}
	}
}