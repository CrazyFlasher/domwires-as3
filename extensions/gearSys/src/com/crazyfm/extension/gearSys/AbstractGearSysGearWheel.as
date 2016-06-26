/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;

	internal class AbstractGearSysGearWheel extends AbstractHierarchyObject implements IGearSysGearWheel
	{
		private var _isEnabled:Boolean = true;

		public function AbstractGearSysGearWheel()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function interact(timePassed:Number):void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function setEnabled(value:Boolean):IGearSysGearWheel
		{
			if (isDisposed)
			{
				throw new Error("Object disposed!");
			}

			if (_isEnabled == value) return this;

			_isEnabled = value;

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get isEnabled():Boolean
		{
			return _isEnabled;
		}
	}
}
