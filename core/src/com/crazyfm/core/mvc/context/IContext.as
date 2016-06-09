/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.service.IServiceContainer;
	import com.crazyfm.core.mvc.view.IViewContainer;

	/**
	 * Context contains models, views and services. Also implements <code>ICommandMapper</code>. You can map specific signals, that came out
	 * from hierarchy, to <code>ICommand</code>s.
	 */
	public interface IContext extends IModelContainer, IViewContainer, IServiceContainer, ICommandMapper
	{

	}
}
