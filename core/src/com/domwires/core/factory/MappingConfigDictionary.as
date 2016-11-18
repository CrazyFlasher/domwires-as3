/**
 * Created by CrazyFlasher on 17.11.2016.
 */
package com.domwires.core.factory
{
	import flash.utils.Dictionary;

	/**
	 * Used by <code>IAppFactory</code> to create new instances, map types and inject dependencies via json config.
	 * See last example in <code>IAppFactory</code>
	 * @see IAppFactory#setMappingConfig
	 */
	public dynamic class MappingConfigDictionary extends Dictionary
	{
		public function MappingConfigDictionary(json:Object)
		{
			if (json)
			{
				var key:*;
				for (key in json)
				{
					this[key] = new DependencyVo(json[key]);
				}
			}
		}
	}
}
