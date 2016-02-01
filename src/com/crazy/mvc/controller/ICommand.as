/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.controller
{
	public interface ICommand
	{
		function execute():void;
		function retain():void;
	}
}
