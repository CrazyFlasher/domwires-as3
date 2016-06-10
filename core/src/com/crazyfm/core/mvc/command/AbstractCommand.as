/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;

	/**
	 * Command (or service) that operates on provided (injected) models.
	 */
	public class AbstractCommand extends AbstractHierarchyObject implements ICommand
	{
		/**
		 * @inheritDoc
		 */
		public function execute():void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function retain():void
		{

		}
	}
}
