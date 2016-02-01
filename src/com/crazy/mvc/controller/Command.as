/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazy.mvc.controller
{
	public class Command implements ICommand
	{
		public function Command()
		{
		}

		public function execute():void
		{
			throw new Error("Command#execute should be overridden!");
		}
	}
}
