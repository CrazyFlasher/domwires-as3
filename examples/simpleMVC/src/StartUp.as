package
{
	import com.domwires.core.preloader.AbstractInternalPreloader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getDefinitionByName;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]

	public class StartUp extends AbstractInternalPreloader
	{

		public function StartUp()
		{
			super();

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		/**
		 * @inheritDoc
		 */
		override protected function appLoaded():void
		{
			var PreInitClass:Class = getDefinitionByName("PreInit") as Class;
			stage.addChild(new PreInitClass());
			stage.removeChild(this);
		}
	}
}
