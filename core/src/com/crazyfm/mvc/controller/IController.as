/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.mvc.controller
{
	public interface IController
	{
		function addViewListener(eventType:String, handler:Function):void;
		function removeViewListener(handler:Function):void;
	}
}
