/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.core.common
{
	import org.swiftsuspenders.Injector;

	public class Instantiator
	{
		private static var instance:Instantiator;

		private var _injector:Injector;

		public function Instantiator()
		{
			if (instance)
			{
				throw new Error("Instantiator is already initialized! use Instantiator.get");
			}

			_injector = new Injector();
		}

		public static function get():Instantiator
		{
			if (!instance)
			{
				instance = new Instantiator();
			}

			return instance;
		}

		public function get injector():Injector
		{
			return _injector;
		}

		public function map(type:Class, toType:Class):void
		{
			_injector.map(type).toType(toType);
		}

		public function unmap(type:Class):void
		{
			if (_injector.hasMapping(type))
			{
				_injector.unmap(type);
			}
		}

		public function createNew(type:Class, ...constructorArgs):*
		{
			for each (var arg:* in constructorArgs)
			{
				//_injector.map(type).toValue(toType);
			}
			_injector.getInstance(type);
		}
	}
}
