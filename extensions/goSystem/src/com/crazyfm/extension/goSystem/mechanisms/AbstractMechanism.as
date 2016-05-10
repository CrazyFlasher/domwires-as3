/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem.mechanisms
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;
	import com.crazyfm.extension.goSystem.IGOSystemGearWheel;
	import com.crazyfm.extension.goSystem.IGOSystemMechanism;

	public class AbstractMechanism extends HierarchyObjectContainer implements IGOSystemMechanism
	{
		private var constantPassedTime:Number;

		public function AbstractMechanism(constantPassedTime:Number = NaN)
		{
			super();

			this.constantPassedTime = constantPassedTime;
		}

		/**
		 * @inheritDoc
		 */
		public function addGear(value:IGOSystemGearWheel):IGOSystemMechanism
		{
			add(value);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGear(value:IGOSystemGearWheel, dispose:Boolean = false):IGOSystemMechanism
		{
			remove(value, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGears(dispose:Boolean = false):IGOSystemMechanism
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGears():int
		{
			return _childrenList ? _childrenList.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGear(value:IGOSystemGearWheel):Boolean
		{
			return _childrenList && _childrenList.indexOf(value) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get gearList():Array
		{
			return _childrenList;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			removeAllGears();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllGears(true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		public function interact(passedTime:Number):void
		{
			for (var i:int = 0; i < _childrenList.length; i++)
			{
				_childrenList[i].interact(isNaN(constantPassedTime) ? passedTime : constantPassedTime);
			}
		}
	}
}
