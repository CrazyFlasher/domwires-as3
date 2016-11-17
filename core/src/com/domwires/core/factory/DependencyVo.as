/**
 * Created by CrazyFlasher on 17.11.2016.
 */
package com.domwires.core.factory
{
	internal class DependencyVo
	{
		private var _implementation:String;
		private var _autowired:Object;

		public function DependencyVo(json:Object)
		{
			if (!json.implementation)
			{
				log("WARNING: 'implementationDefinition' is not set in json!");
			}else
			{
				_implementation = json.implementation;
			}

			_autowired = json.autowired;
		}

		public function get implementation():String
		{
			return _implementation;
		}

		public function get autowired():Object
		{
			return _autowired;
		}
	}
}
