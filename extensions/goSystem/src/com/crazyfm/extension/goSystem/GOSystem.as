/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModelContainer;
	import com.crazyfm.core.mvc.model.ModelContainer;

	import flash.utils.Dictionary;

	public class GOSystem extends ModelContainer implements IGOSystem
	{
		private var _mechanism:IMechanism;

		private var _gameObjectList:Dictionary/*IGameObject, IGameObject*/;
		private var _numGameObjects:int;

		public function GOSystem(mechanism:IMechanism)
		{
			super();

			_mechanism = mechanism.addGear(this);
		}

		/**
		 * @inheritDoc
		 */
		public function setMechanism(mechanism:IMechanism):IGOSystem
		{
			if (_mechanism != null)
			{
				_mechanism.removeGear(this);
			}

			_mechanism = mechanism;

			if (_mechanism != null)
			{
				_mechanism.addGear(this);
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function addGameObject(value:IGameObject):IGOSystem
		{
			super.addModel(value);

			if (!_gameObjectList)
			{
				_gameObjectList = new Dictionary();
			}

			var added:Boolean = addChild(value, _gameObjectList);

			if (added)
			{
				_numGameObjects++;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGameObject(value:IGameObject, dispose:Boolean = false):IGOSystem
		{
			super.removeModel(value, false);

			var removed:Boolean = removeChild(value, _gameObjectList);

			if (removed)
			{
				_numGameObjects--;

				if (dispose)
				{
					value.dispose();
				}
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGameObjects(dispose:Boolean = false, withChildren:Boolean = false):IGOSystem
		{
			super.removeAllModels(false);

			if (_gameObjectList)
			{
				for (var i:* in _gameObjectList)
				{
					if (dispose)
					{
						if (withChildren && _gameObjectList[i] is IModelContainer)
						{
							(_gameObjectList[i] as IModelContainer).disposeWithAllChildren();
						}else
						{
							_gameObjectList[i].dispose();
						}
					}
				}

				_gameObjectList = null;

				_numGameObjects = 0;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGameObjects():int
		{
			return _numGameObjects;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGameObject(value:IGameObject):Boolean
		{
			return _gameObjectList && _gameObjectList[value] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObjectList():Dictionary
		{
			return _gameObjectList;
		}

		/**
		 * @inheritDoc
		 */
		public function interact(timePassed:Number):void
		{
			for (var i:* in _gameObjectList)
			{
				if (_gameObjectList[i].isEnabled)
				{
					_gameObjectList[i].interact(timePassed);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllGameObjects(true, true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			if (_mechanism)
			{
				_mechanism.removeGear(this);
				_mechanism = null;
			}

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
	}
}
