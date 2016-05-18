/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.extension.goSystem.events.GOSystemSignalEnum;

	public class GOSystem extends AbstractGOSystemGearWheelContainer implements IGOSystem
	{
		private var _mechanism:IGOSystemMechanism;

		private var initialized:Boolean;

		public function GOSystem(mechanism:IGOSystemMechanism)
		{
			super();

			_mechanism = mechanism.addGear(this);
		}

		/**
		 * @inheritDoc
		 */
		public function addGameObject(value:IGOSystemObject):IGOSystem
		{
			add(value);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGameObject(value:IGOSystemObject, dispose:Boolean = false):IGOSystem
		{
			remove(value, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGameObjects(dispose:Boolean = false):IGOSystem
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGameObjects():int
		{
			return _childrenList ? _childrenList.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGameObject(value:IGOSystemObject):Boolean
		{
			return _childrenList && _childrenList.indexOf(value) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObjectList():Array
		{
			return _childrenList;
		}

		/**
		 * @inheritDoc
		 */
		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i].isEnabled)
				{
					_childrenList[i].interact(timePassed);
				}
			}

			if (!initialized)
			{
				initialized = true;

				dispatchSignal(GOSystemSignalEnum.INITIALIZED);
			}

			dispatchSignal(GOSystemSignalEnum.STEP);
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
		public function get mechanism():IGOSystemMechanism
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

		public function updateNow():IGOSystem
		{
			interact(1);

			return this;
		}
	}
}
