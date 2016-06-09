/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.service
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	/**
	 * Container for services.
	 */
	public interface IServiceContainer extends IService, IHierarchyObjectContainer
	{
		/**
		 * Adds service to current container.
		 * @param service
		 * @return
		 */
		function addService(service:IService):IServiceContainer;

		/**
		 * Removes service from current container.
		 * @param service
		 * @param dispose
		 * @return
		 */
		function removeService(service:IService, dispose:Boolean = false):IServiceContainer;

		/**
		 * Removes all services from current container.
		 * @param dispose
		 * @return
		 */
		function removeAllServices(dispose:Boolean = false):IServiceContainer;

		/**
		 * Returns number of services in current container.
		 */
		function get numServices():int;

		/**
		 * Returns true, if current container has provided service.
		 * @param service
		 * @return
		 */
		function containsService(service:IService):Boolean;

		/**
		 * Returns list of services in current container.
		 */
		function get serviceList():Array;

		/**
		 * Sends signal to children services.
		 * @param type
		 * @param data
		 */
		function dispatchSignalToServices(type:Enum, data:Object = null):void;
	}
}
