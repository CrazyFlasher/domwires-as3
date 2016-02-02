/**
 * Created by Anton Nefjodov on 1.02.2016.
 */
package com.crazyfm.mvc.controller
{
	import com.crazyfm.mvc.common.Disposable;

	/**
	 * Class, that stores link to ICommand that should be executed, when specified signal occurs
	 */
	internal class MappingVo extends Disposable
	{
		private var _signalType:String;
		private var _command:ICommand;

		/**
		 * Creates new command-to-signal mapping object
		 * @param signalType
		 * @param command
		 */
		public function MappingVo(signalType:String, command:ICommand)
		{
			_signalType = signalType;
			_command = command;
		}

		/**
		 * Disposes object and reference to ICommand
		 */
		override public function dispose():void
		{
			_command = null;

			super.dispose();
		}

		public function get signalType():String
		{
			return _signalType;
		}

		public function get command():ICommand
		{
			return _command;
		}
	}
}
