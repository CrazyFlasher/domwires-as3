/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IContext extends IModelContainer
	{
		function mapEventTypeToCommand(eventType:String, command:ICommand):void;
		function mapViewToMediator(view:IView, mediator:IMediator):void;
	}
}
