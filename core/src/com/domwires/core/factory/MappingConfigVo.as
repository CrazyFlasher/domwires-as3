/**
 * Created by CrazyFlasher on 17.11.2016.
 */
package com.domwires.core.factory
{
	import com.domwires.core.factory.DependencyVo;

	import flash.utils.Dictionary;

	public class MappingConfigVo
	{
		private var _dependencyMap:Dictionary;

		public function MappingConfigVo(json:Object)
		{
			if (json)
			{
				_dependencyMap = new Dictionary();
				var key:*;
				for (key in json)
				{
					_dependencyMap[key] = new DependencyVo(json[key]);
				}
			}
		}

		public function get dependencyMap():Dictionary
		{
			return _dependencyMap;
		}
	}
}
