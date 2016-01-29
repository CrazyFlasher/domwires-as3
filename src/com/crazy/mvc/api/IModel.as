/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	import org.osflash.signals.ISignal;

	public interface IModel extends IDisposable
	{
		function set parent(value:IModelContainer):void;
		function get parent():IModelContainer;
		function addSignalListener(type:String, listener:Function):void;
		function removeSignalListener(type:String):void;
		function removeAllSignals():void;
		function dispatchSignal(type:String, data:Object = null):void;
		function hasSignalListener(type:String):Boolean;
		function get isDisposed():Boolean;
	}
}
