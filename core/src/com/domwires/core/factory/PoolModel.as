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
		private var isBusyFlagGetterName:String;

		private var _args:Array;

		public function PoolModel(factory:AppFactory, capacity:int, isBusyFlagGetterName:String)
		{
			this.factory = factory;
			_capacity = capacity;
			this.isBusyFlagGetterName = isBusyFlagGetterName;
		}

		internal function get(type:Class, args:Array = null, createNewIfNeeded:Boolean = true):*
		{
			var instance:*;

			if (args == null && _args != null)
			{
				args = _args;
			} else
			{
				_args = args;
			}

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

				if (isBusyFlagGetterName != null && instance[isBusyFlagGetterName] == true)
				{
					return get(type, args, createNewIfNeeded);
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

		internal function get allItemsAreBusy():Boolean
		{
			if (list.length < _capacity) return false;
			if (isBusyFlagGetterName == null) return false;

			var instance:*;

			for (var i:int = 0; i < _capacity; i++)
			{
				instance = list[i];
				
				if (instance[isBusyFlagGetterName] == false)
				{
					return false;
				}
			}

			return true;
		}

		internal function get busyItemsCount():int
		{
			if (isBusyFlagGetterName == null) return 0;

			var count:int;
			var instance:*;
			for (var i:int = 0; i < list.length; i++)
			{
				instance = list[i];

				if (instance[isBusyFlagGetterName] == true)
				{
					count++;
				}
			}

			return count;
		}
	}
}
