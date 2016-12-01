/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.context
{
	import com.domwires.core.factory.AppFactory;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.context.AbstractContext;
	import com.domwires.core.mvc.model.IModel;
	import com.domwires.core.mvc.view.IView;
	import com.domwires.example.simplemvc.commands.GenerateAgeCommand;
	import com.domwires.example.simplemvc.commands.GenerateFirstNameCommand;
	import com.domwires.example.simplemvc.commands.GenerateLastNameCommand;
	import com.domwires.example.simplemvc.model.AppModel;
	import com.domwires.example.simplemvc.model.IAppModel;
	import com.domwires.example.simplemvc.model.IAppModelImmutable;
	import com.domwires.example.simplemvc.view.AppView;
	import com.domwires.example.simplemvc.view.AppViewMessage;

	import starling.display.DisplayObjectContainer;

	public class AppContext extends AbstractContext
	{
		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		private var viewFactory:IAppFactory;
		private var modelFactory:IAppFactory;

		private var model:IAppModel;
		private var view:IView;

		[PostConstruct]
		override public function init():void
		{
			super.init();

			modelFactory = new AppFactory();

			model = modelFactory.getInstance(IAppModel);

			viewFactory = new AppFactory()
					.mapToType(IView, AppView)
					.mapToValue(DisplayObjectContainer, viewContainer)
					.mapToValue(IAppModelImmutable, model);

			view = viewFactory.getInstance(IView);

			//internal context factory (used for command mapper)
			factory.mapToValue(IAppModel, model);

			addModel(model);
			addView(view);

			map(AppViewMessage.FIRST_NAME_CLICKED, GenerateFirstNameCommand);
			map(AppViewMessage.LAST_NAME_CLICKED, GenerateLastNameCommand);
			map(AppViewMessage.AGE_CLICKED, GenerateAgeCommand);
		}
	}
}
