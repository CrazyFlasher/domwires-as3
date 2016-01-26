/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.ICommand;
	import com.crazy.mvc.api.IContext;
	import com.crazy.mvc.api.IDisposable;
	import com.crazy.mvc.api.IMediator;
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IView;

	import flash.utils.Dictionary;

	public class Context extends ModelContainer implements IContext
	{
		public function Context()
		{

		}

		public function mapEventTypeToCommand(eventType:String, command:ICommand):void
		{
		}

		public function mapViewToMediator(view:IView, mediator:IMediator):void
		{
		}

		override public function dispose():void
		{
			super.dispose();

		}
	}
}
