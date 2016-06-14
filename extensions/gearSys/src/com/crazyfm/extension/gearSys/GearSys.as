/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import com.crazyfm.extension.gearSys.messages.GearSysMessageEnum;

	public class GearSys extends AbstractGearSysGearWheelContainer implements IGearSys
	{
		private var _mechanism:IGearSysMechanism;

		private var initialized:Boolean;

		public function GearSys(mechanism:IGearSysMechanism)
		{
			super();

			_mechanism = mechanism.addGear(this);
		}

		/**
		 * @inheritDoc
		 */
		public function addGameObject(value:IGearSysObject):IGearSys
		{
			add(value);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGameObject(value:IGearSysObject, dispose:Boolean = false):IGearSys
		{
			remove(value, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGameObjects(dispose:Boolean = false):IGearSys
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGameObjects():int
		{
			return children ? children.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGameObject(value:IGearSysObject):Boolean
		{
			return children && children.indexOf(value) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObjectList():Array
		{
			return children;
		}

		/**
		 * @inheritDoc
		 */
		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			for (var i:int = 0; i < children.length; i++)
			{
				if (children[i].isEnabled)
				{
					children[i].interact(timePassed);
				}
			}

			if (!initialized)
			{
				initialized = true;

				dispatchMessage(GearSysMessageEnum.INITIALIZED);
			}

			dispatchMessage(GearSysMessageEnum.STEP);
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeMechanism();

			removeAllGameObjects(true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			removeMechanism();

			removeAllGameObjects();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function get mechanism():IGearSysMechanism
		{
			return _mechanism;
		}

		private function removeMechanism():void
		{
			if (_mechanism)
			{
				_mechanism.removeGear(this);
				_mechanism = null;
			}
		}

		public function updateNow():IGearSys
		{
			interact(1);

			return this;
		}
	}
}
