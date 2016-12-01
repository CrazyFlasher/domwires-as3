/**
 * Created by CrazyFlasher on 31.08.2016.
 */
package
{
	import com.domwires.core.factory.AppFactory;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.context.IContext;
	import com.domwires.core.mvc.context.config.ContextConfigVoBuilder;
	import com.domwires.core.mvc.message.IMessage;
	import com.domwires.example.simplemvc.Main;
	import com.domwires.example.simplemvc.context.AppContext;
	import com.domwires.extension.starlingApp.configs.StarlingConfig;
	import com.domwires.extension.starlingApp.configs.StarlingConfigBuilder;
	import com.domwires.extension.starlingApp.initializer.IStarlingInitializer;
	import com.domwires.extension.starlingApp.messages.StarlingInitializerMessage;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.utils.ScaleMode;

	public class PreInit extends Sprite
	{
		private var starlingInitializerFactory:IAppFactory;

		public function PreInit()
		{
			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);

			var starlingConfigBuilder:StarlingConfigBuilder = new StarlingConfigBuilder();
			starlingConfigBuilder.stageWidth = stage.stageWidth;
			starlingConfigBuilder.stageHeight = stage.stageHeight;

			var starlingConfig:StarlingConfig = starlingConfigBuilder.build();

			starlingInitializerFactory = new AppFactory();
			starlingInitializerFactory.mapToValue(Stage, stage)
					.mapToValue(Class, Main)
					.mapToValue(StarlingConfig, starlingConfig);

			starlingInitializerFactory.getInstance(IStarlingInitializer)
					.addMessageListener(StarlingInitializerMessage.STARLING_INITIALIZED, starlingReady);
		}

		private function starlingReady(m:IMessage):void
		{
			starlingInitializerFactory.dispose();

			Starling.current.showStats = true;

			var viewContainer:DisplayObjectContainer = Starling.current.root as DisplayObjectContainer;
			var contextFactory:IAppFactory = new AppFactory()
					.mapToType(IContext, AppContext)
					.mapToValue(DisplayObjectContainer, viewContainer)
					.mapToValue(IAppFactory, new AppFactory());

			contextFactory.getInstance(IContext);
		}
	}
}
