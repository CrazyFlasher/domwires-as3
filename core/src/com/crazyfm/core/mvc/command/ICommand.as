/**
 * Created by Anton Nefjodov on 27.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;

	/**
	 * Command (or service) that operates on provided (injected) models.
	 */
	public interface ICommand extends IHierarchyObject
	{
		/**
		 * Executes command.
		 */
		function execute():void;

		/**
		 * Manually cancel async command during progress.
		 */
		function retain():void;
	}
}
