/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.service
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IServiceContainer extends IService, IHierarchyObjectContainer
	{
		function addService(service:IService):IServiceContainer;

		function removeService(service:IService, dispose:Boolean = false):IServiceContainer;

		function removeAllServices(dispose:Boolean = false):IServiceContainer;

		function get numServices():int;

		function containsService(service:IService):Boolean;

		function get serviceList():Array;

		function dispatchSignalToServices(type:Enum, data:Object = null):void;
	}
}
