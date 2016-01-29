/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.ICommand;
	import com.crazy.mvc.api.IContext;
	import com.crazy.mvc.api.IMediator;
	import com.crazy.mvc.api.IView;

	public class Context extends ModelContainer implements IContext
	{
		public function Context()
		{

		}

		public function mapSignalTypeToCommand(signalType:String, command:ICommand):void
		{
		}

		public function mapViewToMediator(view:IView, mediator:IMediator):void
		{
		}

		public function unmapSignalType(signalType:String, command:ICommand):void
		{
		}

		public function unmapViewFromMediator(view:IView, mediator:IMediator):void
		{
		}
	}
}
