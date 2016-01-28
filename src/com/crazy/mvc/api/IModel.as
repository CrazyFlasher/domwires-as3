/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	import org.osflash.signals.ISignal;

	public interface IModel
	{
		function set parent(value:IModelContainer):void;
		function get parent():IModelContainer;
		function addSignalListener(listener:Function):void;
		function removeSignalListener(listener:Function):void;
		function removeSignalsListeners():void;
		function dispatchSignal(type:String, data:Object = null):void;
		function get signals():ISignal;
	}
}
