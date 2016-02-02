/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.mvc.controller
{
	public interface ICommand
	{
		/**
		 * Command execution. After that by default command goes to pool
		 */
		function execute():void;
	}
}
