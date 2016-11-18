/**
 * Created by CrazyFlasher on 18.11.2016.
 */
package com.domwires.core.factory
{
	import com.domwires.core.mvc.model.AbstractModel;

	public class SuperCoolModel extends AbstractModel implements ISuperCoolModel
	{
		[Autowired(name="coolValue")]
		public var _coolValue:int;

		[Autowired]
		public var _value:int;

		[Autowired(name="def")]
		public var _def:IDefault;

		[Autowired(name="obj")]
		public var _object:Object;

		[Autowired]
		public var _array:Array;

		public function getCoolValue():int
		{
			return _coolValue;
		}

		public function get value():int
		{
			return _value;
		}

		public function get def():IDefault
		{
			return _def;
		}

		public function get object():Object
		{
			return _object;
		}

		public function get array():Array
		{
			return _array;
		}
	}
}
