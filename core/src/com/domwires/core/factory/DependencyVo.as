/**
 * Created by CrazyFlasher on 17.11.2016.
 */
package com.domwires.core.factory
{
	internal class DependencyVo
	{
		private var _implementation:String;
		private var _value:*;
		private var _newInstance:Boolean;


		public function DependencyVo(json:Object)
		{
			if (!json.implementation)
			{
				log("'implementation' is not set in json!");
			}else
			{
				_implementation = json.implementation;
			}

			_value = json.value;

			if (json.newInstance)
			{
				_newInstance = json.newInstance;
			}
		}

		public function get implementation():String
		{
			return _implementation;
		}

		public function get value():*
		{
			return _value;
		}

		public function get newInstance():Boolean
		{
			return _newInstance;
		}
	}
}
