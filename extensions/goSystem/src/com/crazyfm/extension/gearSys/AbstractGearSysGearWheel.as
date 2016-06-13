/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;

	public class AbstractGearSysGearWheel extends AbstractHierarchyObject implements IGearSysGearWheel
	{
		private var _isEnabled:Boolean = true;

		public function AbstractGearSysGearWheel()
		{
			super();
		}

		public function interact(timePassed:Number):void
		{
		}

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

		public function get isEnabled():Boolean
		{
			return _isEnabled;
		}
	}
}
