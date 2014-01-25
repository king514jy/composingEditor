package src
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import src.conmponents.ComposingGroup;
	import src.conmponents.SetUI;
	import src.conmponents.TipsGroup;
	import src.data.ConfigData;
	import src.events.ConfigEvent;
	import src.events.SetEvent;
	
	public class ComposingEditor extends Sprite
	{
		private var composingGroup:ComposingGroup;
		private var setUI:SetUI;
		private var config:ConfigData;
		private var tipsGroup:TipsGroup;
		public function ComposingEditor()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			composingGroup = new ComposingGroup();
			composingGroup.x = (stage.stageWidth-200) * 0.5;
			composingGroup.y = stage.stageHeight * 0.5;
			this.addChild(composingGroup);
			setUI = new SetUI();
			setUI.x = stage.stageWidth;
			this.addChild(setUI);
			composingGroup.setUI = setUI;
			
			config = new ConfigData();
			tipsGroup = new TipsGroup();
			tipsGroup.x = (stage.stageWidth-200) * 0.5;
			tipsGroup.y = stage.stageHeight * 0.5;
			
			resize();
			stage.addEventListener(Event.RESIZE,resize);
			addListener();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
		}
		private function addListener():void
		{
			setUI.addEventListener(SetEvent.MAGNIFY,handleSetEvent);
			setUI.addEventListener(SetEvent.MINIFY,handleSetEvent);
			setUI.addEventListener(SetEvent.REGAIN_SCALE,handleSetEvent);
			setUI.addEventListener(SetEvent.ADD_REFER,handleSetEvent);
			setUI.addEventListener(SetEvent.ADD_COMPOSING,handleSetEvent);
			setUI.addEventListener(SetEvent.DELETE_COMPOSING,handleSetEvent);
			setUI.addEventListener(SetEvent.OPEN_SAMPLE_SHADOW,handleSetEvent);
			setUI.addEventListener(SetEvent.OUTPUT_CONFIG,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_ALPHA,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_ANGLE,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_DISTANCE,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_STRENGTH,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_X,handleSetEvent);
			setUI.addEventListener(SetEvent.SET_BLUR_Y,handleSetEvent);
		}
		private function reportKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE) 
			{ 
				Mouse.cursor = MouseCursor.HAND;
				composingGroup.addEventListener(MouseEvent.MOUSE_DOWN,drugBegin);
				composingGroup.addEventListener(MouseEvent.MOUSE_UP,drugEnd);
				composingGroup.addEventListener(MouseEvent.MOUSE_OUT,drugEnd);
			} 
		}
		private function reportKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE) 
			{ 
				Mouse.cursor = MouseCursor.ARROW;
				composingGroup.removeEventListener(MouseEvent.MOUSE_DOWN,drugBegin);
				composingGroup.removeEventListener(MouseEvent.MOUSE_UP,drugEnd);
				composingGroup.removeEventListener(MouseEvent.MOUSE_OUT,drugEnd);
			} 
		}
		private function drugBegin(e:MouseEvent):void
		{
			composingGroup.startDrag();
		}
		private function drugEnd(e:MouseEvent):void
		{
			composingGroup.stopDrag();
		}
		private function handleSetEvent(e:SetEvent):void
		{
			var info:String = e.info;
			var num:Number = e.number;
			var type:String = e.type;
			var sca:Number;
			switch(type)
			{
				case SetEvent.MAGNIFY:
					sca = composingGroup.scaleX + 0.3;
					TweenLite.to(composingGroup,1,{scaleX:sca,scaleY:sca,ease:Quint.easeInOut});
					break;
				case SetEvent.MINIFY:
					if(composingGroup.scaleX > 0)
						sca = composingGroup.scaleX - 0.3;
					TweenLite.to(composingGroup,1,{scaleX:sca,scaleY:sca,ease:Quint.easeInOut});
					break;
				case SetEvent.REGAIN_SCALE:
					TweenLite.to(composingGroup,1,{x:(stage.stageWidth-200) * 0.5,y:stage.stageHeight * 0.5,scaleX:1,scaleY:1,ease:Quint.easeInOut});
					break;
				case SetEvent.ADD_REFER:
					composingGroup.addRefer();
					break;
				case SetEvent.ADD_COMPOSING:
					if(setUI.composing)
						composingGroup.addComposing(new Bitmap(setUI.composing));
					break;
				case SetEvent.DELETE_COMPOSING:
					break;
				case SetEvent.OPEN_SAMPLE_SHADOW:
					composingGroup.nowPlane.shadow = (info=="yes");
					break;
				case SetEvent.OUTPUT_CONFIG:
					tipsGroup.tips = "正在输出配置文件...";
					this.addChild(tipsGroup);
					config.addEventListener(ConfigEvent.OUTPUT_COMPLETE,outputComplete);
					config.outputComposing(composingGroup.planeList);
					break;
				case SetEvent.SET_BLUR_ALPHA:
					composingGroup.nowPlane.alphaShadow = num;
					break;
				case SetEvent.SET_BLUR_ANGLE:
					composingGroup.nowPlane.angle = num;
					break;
				case SetEvent.SET_BLUR_DISTANCE:
					composingGroup.nowPlane.distance = num;
					break;
				case SetEvent.SET_BLUR_STRENGTH:
					composingGroup.nowPlane.strength = num;
					break;
				case SetEvent.SET_BLUR_X:
					composingGroup.nowPlane.blurX = num;
					break;
				case SetEvent.SET_BLUR_Y:
					composingGroup.nowPlane.blurY = num;
					break;
				
			}
		}
		private function outputComplete(e:ConfigEvent):void
		{
			tipsGroup.tips = "配置文件已输出到桌面！";
			config.removeEventListener(ConfigEvent.OUTPUT_COMPLETE,outputComplete);
			tipsGroup.close(3000);
		}
		private function resize(e:Event=null):void
		{
			//composingGroup.x = (stage.stageWidth-200) * 0.5;
			//composingGroup.y = stage.stageHeight * 0.5;
			setUI.x = stage.stageWidth;
			tipsGroup.x = (stage.stageWidth-200) * 0.5;
			tipsGroup.y = stage.stageHeight * 0.5;
		}
	}
}