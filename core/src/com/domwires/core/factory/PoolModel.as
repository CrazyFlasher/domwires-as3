/**
 * Created by Anton Nefjodov on 21.05.2016.
 */
package com.domwires.core.factory
{
	internal class PoolModel
	{
		private var list:Array = [];
		private var _capacity:int;

		private var currentIndex:int;
		private var factory:AppFactory;

		public function PoolModel(factory:AppFactory, capacity:int)
		{
			this.factory = factory;
			_capacity = capacity;
		}

		internal function get(type:Class, args:Array = null, createNewIfNeeded:Boolean = true):*
		{
			var instance:*;

			if (list.length < _capacity && createNewIfNeeded)
			{
				instance = factory.getInstance(type, args, null, true);
				list.push(instance);
			}else
			{
				instance = list[currentIndex];

				currentIndex++;

				if (currentIndex == _capacity || currentIndex == list.length)
				{
					currentIndex = 0;
				}
			}

			return instance
		}

		internal function increaseCapacity(value:int):void
		{
			_capacity += value;
		}

		internal function dispose():void
		{
			list = null;
			factory = null;
		}

		internal function get capacity():int
		{
			return _capacity;
		}

		internal function get instanceCount():int
		{
			return list.length;
		}
	}
}
