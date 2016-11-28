/**
 * Created by CrazyFlasher on 28.11.2016.
 */
package com.domwires.core.mvc.command
{
	public class MappingConfigList
	{
		private var list:Vector.<MappingConfig>;

		public function MappingConfigList()
		{
			list = new <MappingConfig>[];
		}

		internal function push(item:MappingConfig):void
		{
			list.push(item);
		}

		/**
		 * @see com.domwires.core.mvc.command.MappingConfig
		 * @param value
		 * @return
		 */
		public function addGuards(value:Class):MappingConfigList
		{
			var mappingConfig:MappingConfig;

			for each (mappingConfig in list)
			{
				mappingConfig.addGuards(value);
			}

			return this;
		}
	}
}
