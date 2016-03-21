/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.Context;

	import flash.utils.Dictionary;

	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public class GOSystem extends Context implements IGOSystem, IAnimatable
	{
		private var _juggler:Juggler;

		private var _gameObjectList:Dictionary/*IGameObject, IGameObject*/;
		private var _numGameObjects:int;

		public function GOSystem()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function setJuggler(juggler:Juggler):IGOSystem
		{
			if (_juggler != null)
			{
				_juggler.remove(this);
			}

			_juggler = juggler;

			if (_juggler != null)
			{
				_juggler.add(this);
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
		public function removeAllGameObjects(dispose:Boolean = false):IGOSystem
		{
			super.removeAllModels(false);

			if (_gameObjectList)
			{
				for (var i:* in _gameObjectList)
				{
					if (dispose)
					{
						_gameObjectList[i].dispose();
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
		public function advanceTime(time:Number):void
		{
			for (var i:* in _gameObjectList)
			{
				if (_gameObjectList[i].isEnabled)
				{
					_gameObjectList[i].advanceTime(time);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllGameObjects(true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			if (_juggler)
			{
				_juggler.remove(this);
				_juggler = null;
			}

			removeAllGameObjects();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function get juggler():Juggler
		{
			return _juggler;
		}
	}
}
