/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;

	public class GOSystem extends HierarchyObjectContainer implements IGOSystem
	{
		private var _mechanism:IMechanism;

		public function GOSystem(mechanism:IMechanism)
		{
			super();

			_mechanism = mechanism.addGear(this);
		}

		/**
		 * @inheritDoc
		 */
		public function addGameObject(value:IGameObject):IGOSystem
		{
			add(value);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGameObject(value:IGameObject, dispose:Boolean = false):IGOSystem
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
		public function containsGameObject(value:IGameObject):Boolean
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
		public function interact(timePassed:Number):void
		{
			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i].isEnabled)
				{
					_childrenList[i].interact(timePassed);
				}
			}
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
		public function get mechanism():IMechanism
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
	}
}
