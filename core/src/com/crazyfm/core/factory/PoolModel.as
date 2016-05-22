/**
 * Created by Anton Nefjodov on 21.05.2016.
 */
package com.crazyfm.core.factory
{
	internal class PoolModel
	{
		private var list:Array = [];
		private var capacity:int;

		private var currentIndex:int;
		private var factory:AppFactory;

		public function PoolModel(factory:AppFactory, capacity:int)
		{
			this.factory = factory;
			this.capacity = capacity;
		}

		internal function get(type:Class):*
		{
			var instance:*;

			if (list.length < capacity)
			{
				instance = factory.getNewInstance(type);
				list.push(instance);
			}else
			{
				instance = list[currentIndex];

				currentIndex++;

				if (currentIndex == capacity)
				{
					currentIndex = 0;
				}
			}

			return instance
		}

		internal function dispose():void
		{
			list = null;
			factory = null;
		}
	}
}
