/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.domwires.core.mvc.command
{
	import com.domwires.core.mvc.hierarchy.AbstractHierarchyObject;

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
	}
}
