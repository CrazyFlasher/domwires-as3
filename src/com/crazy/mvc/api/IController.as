/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IController
	{
		function addViewListener(eventType:String, handler:Function):void;
		function removeViewListener(handler:Function):void;
	}
}
