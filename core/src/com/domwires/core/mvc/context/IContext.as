/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.mvc.command.ICommandMapper;
	import com.domwires.core.mvc.message.IMessage;
	import com.domwires.core.mvc.model.IModelContainer;
	import com.domwires.core.mvc.view.IViewContainer;

	/**
	 * Context contains models, views and services. Also implements <code>ICommandMapper</code>. You can map specific messages, that
	 * came out
	 * from hierarchy, to <code>ICommand</code>s.
	 */
	public interface IContext extends IModelContainer, IViewContainer, ICommandMapper
	{
		/**
		 * Dispatches messages to views.
		 * @param message
		 */
		function dispatchMessageToViews(message:IMessage):void;

		/**
		 * Dispatches message to models.
		 * @param message
		 */
		function dispatchMessageToModels(message:IMessage):void;
	}
}
