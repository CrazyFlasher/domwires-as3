/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IModel
	{
		function get id():String;
		function set parent(value:IModelContainer):void;
		function get parent():IModelContainer;
		function addModelEventListener(eventType:String, listener:Function, data:Object = null):void;
		function removeModelEventListener(listener:Function):void;
		function dispatch(eventType:String, data:Object = null):void;
	}
}
