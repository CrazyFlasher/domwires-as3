/**
 * Created by CrazyFlasher on 28.11.2016.
 */
package com.domwires.core.mvc.command
{
	public class MappingConfig
	{
		private var _commandClass:Class;
		private var _data:Object;
		private var _once:Boolean;
		private var _guardList:Vector.<Class>;
		private var _stopOnExecute:Boolean;

		public function MappingConfig(commandClass:Class, data:Object, once:Boolean, stopOnExecute:Boolean = false)
		{
			_commandClass = commandClass;
			_data = data;
			_once = once;
			_stopOnExecute = stopOnExecute;
		}

		/**
		 * Class, that implements <code>IGuards</code> interface.
		 * @see com.domwires.core.mvc.command.IGuards
		 * @param value
		 * @return
		 */
		public function addGuards(value:Class):MappingConfig
		{
			if (!_guardList)
			{
				_guardList = new <Class>[];
			}
			_guardList.push(value);

			return this;
		}

		internal function get commandClass():Class
		{
			return _commandClass;
		}

		internal function get once():Boolean
		{
			return _once;
		}

		internal function get data():Object
		{
			return _data;
		}

		internal function get guardList():Vector.<Class>
		{
			return _guardList;
		}

		public function get stopOnExecute():Boolean
		{
			return _stopOnExecute;
		}
	}
}
