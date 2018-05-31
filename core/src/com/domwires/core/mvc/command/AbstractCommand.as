/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.domwires.core.mvc.command
{
	/**
	 * @see com.domwires.core.mvc.command.ICommand
	 */
	public class AbstractCommand implements ICommand
	{
		private var _logExecution:Boolean;

		/**
		 * @inheritDoc
		 */
		public function execute():void
		{

		}
	}
}
