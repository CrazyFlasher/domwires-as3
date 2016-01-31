/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc.api
{
	public interface ISignalDispatcher
	{
		function addSignalListener(type:String, listener:Function):void;
		function removeSignalListener(type:String):void;
		function removeAllSignals():void;
		function dispatchSignal(type:String, data:Object = null):void;
		function hasSignalListener(type:String):Boolean;
	}
}
