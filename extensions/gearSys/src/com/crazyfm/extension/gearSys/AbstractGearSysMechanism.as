/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	public class AbstractGearSysMechanism extends AbstractGearSysGearWheelContainer implements IGearSysMechanism
	{
		[Autowired]
		public var constantPassedTime:Number;

		public function AbstractGearSysMechanism()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function addGear(value:IGearSysGearWheel):IGearSysMechanism
		{
			add(value);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGear(value:IGearSysGearWheel, dispose:Boolean = false):IGearSysMechanism
		{
			remove(value, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGears(dispose:Boolean = false):IGearSysMechanism
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGears():int
		{
			return children ? children.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGear(value:IGearSysGearWheel):Boolean
		{
			return children && children.indexOf(value) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get gearList():Array
		{
			return children;
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
		override public function interact(passedTime:Number):void
		{
			super.interact(passedTime);

			if (!isEnabled) return;

			for (var i:int = 0; i < children.length; i++)
			{
				if (children[i].isEnabled)
				{
					children[i].interact(isNaN(constantPassedTime) ? passedTime : constantPassedTime);
				}
			}
		}
	}
}
