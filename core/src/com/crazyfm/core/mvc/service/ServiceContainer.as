/**
 * Created by Anton Nefjodov on 7.04.2016.
 */
package com.crazyfm.core.mvc.service
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;

	public class ServiceContainer extends HierarchyObjectContainer implements IServiceContainer
	{
		public function ServiceContainer()
		{
			super();
		}

		public function addService(service:IService):IServiceContainer
		{
			add(service);

			return this;
		}

		public function removeService(service:IService, dispose:Boolean = false):IServiceContainer
		{
			remove(service, dispose);

			return this;
		}

		public function removeAllServices(dispose:Boolean = false):IServiceContainer
		{
			removeAll(dispose);

			return this;
		}

		public function get numServices():int
		{
			return _childrenList ? _childrenList.length : 0;
		}

		public function containsService(service:IService):Boolean
		{
			return _childrenList && _childrenList.indexOf(service) != -1;
		}

		public function get serviceList():Array
		{
			return _childrenList;
		}

		public function dispatchSignalToServices(type:Enum, data:Object = null):void
		{
			dispatchSignalToChildren(type, data);
		}
	}
}
