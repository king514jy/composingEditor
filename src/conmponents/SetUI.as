package src.conmponents
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import fl.containers.UILoader;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.Label;
	import fl.controls.NumericStepper;
	import fl.events.ComponentEvent;
	
	import src.events.SetEvent;

	public class SetUI extends Sprite
	{
		private var minifyBtn:SimpleButton;
		private var magnifyBtn:SimpleButton;
		private var regainBtn:SimpleButton;
		private var addReferBtn:Button;
		private var setComposingBtn:Button;
		private var composingUI:UILoader;
		private var addComposingBtn:Button;
		private var deleteComposingBtn:Button;
		private var sampleNameTxt:TextField;
		private var xLabel:Label;
		private var yLabel:Label;
		private var scaleLabel:Label;
		private var rotationLabel:Label;
		private var openShadowCheckBox:CheckBox;
		private var alphaNumericStepper:NumericStepper;
		private var blurXNumericStepper:NumericStepper;
		private var blurYNumericStepper:NumericStepper;
		private var strengthNumericStepper:NumericStepper;
		private var angleNumericStepper:NumericStepper;
		private var distanceNumericStepper:NumericStepper;
		private var outPutBtn:Button;
		private var _composing:BitmapData;
		private var fileFilter:FileFilter;
		public function SetUI()
		{
			minifyBtn = this.getChildByName("minify_btn") as SimpleButton;
			magnifyBtn = this.getChildByName("magnify_btn") as SimpleButton;
			regainBtn = this.getChildByName("regain_btn") as SimpleButton;
			addReferBtn = this.getChildByName("add_refer_btn") as Button;
			setComposingBtn = this.getChildByName("set_composing_btn") as Button;
			composingUI = this.getChildByName("composing_ui") as UILoader;
			addComposingBtn = this.getChildByName("add_composing_btn") as Button;
			deleteComposingBtn = this.getChildByName("delete_composing_btn") as Button;
			sampleNameTxt = this.getChildByName("sample_name_txt") as TextField;
			xLabel = this.getChildByName("x_label") as Label;
			yLabel = this.getChildByName("y_label") as Label;
			scaleLabel = this.getChildByName("scale_label") as Label;
			rotationLabel = this.getChildByName("rotation_label") as Label;
			openShadowCheckBox = this.getChildByName("open_shadow_checkBox") as CheckBox;
			alphaNumericStepper = this.getChildByName("alpha_numberStepper") as NumericStepper;
			blurXNumericStepper = this.getChildByName("blurX_numberStepper") as NumericStepper;
			blurYNumericStepper = this.getChildByName("blurY_numberStepper") as NumericStepper;
			strengthNumericStepper = this.getChildByName("strength_numberStepper") as NumericStepper;
			angleNumericStepper = this.getChildByName("angle_numberStepper") as NumericStepper;
			distanceNumericStepper = this.getChildByName("distance_numberStepper") as NumericStepper;
			outPutBtn = this.getChildByName("output_config_btn") as Button;
			
			fileFilter = new FileFilter("图片","*.jpg;*.png");
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function get composing():BitmapData
		{ 
			if(_composing)
				return _composing.clone();
			else
				return null;
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			minifyBtn.addEventListener(MouseEvent.CLICK,clickSimpleBtn);
			magnifyBtn.addEventListener(MouseEvent.CLICK,clickSimpleBtn);
			regainBtn.addEventListener(MouseEvent.CLICK,clickSimpleBtn);
			addReferBtn.addEventListener(MouseEvent.CLICK,clickBtn);
			setComposingBtn.addEventListener(MouseEvent.CLICK,clickBtn);
			addComposingBtn.addEventListener(MouseEvent.CLICK,clickBtn);
			deleteComposingBtn.addEventListener(MouseEvent.CLICK,clickBtn);
			outPutBtn.addEventListener(MouseEvent.CLICK,clickBtn);
			
			openShadowCheckBox.addEventListener(MouseEvent.CLICK,clickCheckBox);
			
			alphaNumericStepper.addEventListener(Event.CHANGE,changeNum);
			blurXNumericStepper.addEventListener(Event.CHANGE,changeNum);
			blurYNumericStepper.addEventListener(Event.CHANGE,changeNum);
			strengthNumericStepper.addEventListener(Event.CHANGE,changeNum);
			angleNumericStepper.addEventListener(Event.CHANGE,changeNum);
			distanceNumericStepper.addEventListener(Event.CHANGE,changeNum);
		}
		private function activatNumeric(b:Boolean):void
		{
			alphaNumericStepper.enabled = b;
			blurXNumericStepper.enabled = b;
			blurYNumericStepper.enabled = b;
			strengthNumericStepper.enabled = b;
			angleNumericStepper.enabled = b;
			distanceNumericStepper.enabled = b;
		}
		private function clickSimpleBtn(e:MouseEvent):void
		{
			var btn:SimpleButton = e.currentTarget as SimpleButton;
			switch(btn)
			{
				case minifyBtn:
					dispatchEvent(new SetEvent(SetEvent.MINIFY));
					break;
				case magnifyBtn:
					dispatchEvent(new SetEvent(SetEvent.MAGNIFY));
					break;
				case regainBtn:
					dispatchEvent(new SetEvent(SetEvent.REGAIN_SCALE));
					break;
			}
		}
		private function clickBtn(e:MouseEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			switch(btn)
			{
				case addReferBtn:
					dispatchEvent(new SetEvent(SetEvent.ADD_REFER));
					break;
				case setComposingBtn:
					setComposing();
					break;
				case addComposingBtn:
					dispatchEvent(new SetEvent(SetEvent.ADD_COMPOSING));
					break;
				case deleteComposingBtn:
					dispatchEvent(new SetEvent(SetEvent.DELETE_COMPOSING));
					break;
				case outPutBtn:
					dispatchEvent(new SetEvent(SetEvent.OUTPUT_CONFIG));
					break;
			}
		}
		private function clickCheckBox(e:MouseEvent):void
		{
			var cb:CheckBox = e.currentTarget as CheckBox;
			var info:String;
			if(openShadowCheckBox.selected)
			{
				info="yes";
				activatNumeric(true);
			}
			else
			{
				info="no";
				activatNumeric(false);
			}
			dispatchEvent(new SetEvent(SetEvent.OPEN_SAMPLE_SHADOW,info));
		}
		private function changeNum(e:Event):void
		{
			var numSte:NumericStepper = e.target as NumericStepper;
			switch(numSte)
			{
				case alphaNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_ALPHA,"",numSte.value));
					break;
				case blurXNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_X,"",numSte.value));
					break;
				case blurYNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_Y,"",numSte.value));
					break;
				case strengthNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_STRENGTH,"",numSte.value));
					break;
				case angleNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_ANGLE,"",numSte.value));
					break;
				case distanceNumericStepper:
					dispatchEvent(new SetEvent(SetEvent.SET_BLUR_DISTANCE,"",numSte.value));
					break;
			}
		}
		private function setComposing():void
		{
			var file:File = File.desktopDirectory;
			file.browseForOpen("选择参照图案",[fileFilter]);
			file.addEventListener(Event.SELECT,selectFile);
		}
		private function selectFile(e:Event):void
		{
			var file:File = e.target as File;
			composingUI.source = file.url;
			composingUI.addEventListener(Event.COMPLETE,loadComplete);
		}
		private function loadComplete(e:Event):void
		{
			var bmp:Bitmap = composingUI.content as Bitmap; 
			_composing = bmp.bitmapData;
		}
		public function setCoordinate(xx:Number,yy:Number):void
		{
			xLabel.text = String(xx);
			yLabel.text = String(yy);
		}
		public function setScale(num:Number):void
		{
			scaleLabel.text = String(Math.floor(num * 1000) * 0.001);
		}
		public function setRotation(num:Number):void
		{
			rotationLabel.text = String(Math.floor(num * 1000) * 0.001);
		}
		public function setShowName(str:String):void
		{
			sampleNameTxt.text = str;
		}
		public function setShadowCheckBox(b:Boolean):void
		{
			openShadowCheckBox.selected = b;
			activatNumeric(b);
		}
	}
}