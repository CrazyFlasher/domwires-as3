/**
 * Created by CrazyFlasher on 6.11.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.mvc.command.ICommandMapperImmutable;
	import com.domwires.core.mvc.model.IModelContainerImmutable;
	import com.domwires.core.mvc.view.IViewContainerImmutable;

	/**
	 * @see com.domwires.core.mvc.context.IContext
	 */
	public interface IContextImmutable extends IModelContainerImmutable, IViewContainerImmutable, ICommandMapperImmutable
	{
		/**
		 * Returns true, if message can be bubbled up outside current context.
		 * By default will return false. Override if needed. but be careful!
		 */
		function get bubbleUpInternalContextMessage():Boolean;
	}
}
