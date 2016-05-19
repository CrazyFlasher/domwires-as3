/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.core.common
{
	/**
	 * Abstract enum class.
	 */
	public class Enum
	{
		private var _name:String;

		/**
		 * Creates new enum.
		 * @param name
		 */
		public function Enum(name:String)
		{
			_name = name;
		}

		/**
		 * Returns enum name.
		 */
		public function get name():String
		{
			return _name;
		}

		public function toString():String
		{
			return _name;
		}
	}
}
