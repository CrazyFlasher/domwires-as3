/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.mvc.context.ICommandMapper;
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.service.IServiceContainer;
	import com.crazyfm.core.mvc.view.IViewContainer;

	public interface IContext extends IModelContainer, IViewContainer, IServiceContainer, ICommandMapper
	{

	}
}
