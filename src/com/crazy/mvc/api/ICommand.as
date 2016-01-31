/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface ICommand
	{
		function execute():void;
		function retain():void;
	}
}
