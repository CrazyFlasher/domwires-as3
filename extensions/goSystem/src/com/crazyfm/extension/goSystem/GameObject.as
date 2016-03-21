/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.Context;

	import flash.utils.Dictionary;

	public class GameObject extends Context implements IGameObject
	{
		private var _isEnabled:Boolean;
		private var _componentList:Dictionary/*IGameComponent, IGameComponent*/;
		private var _numComponents:int;

		public function GameObject()
		{
			super();

			setEnabled(true);
		}

		/**
		 * @inheritDoc
		 */
		public function advanceTime(time:Number):void
		{
			if (!_isEnabled) return;

			for (var i:* in _componentList)
			{
				_componentList[i].advanceTime(time);
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			setEnabled(false);

			removeAllComponents();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function setEnabled(value:Boolean):IGameObject
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

		/**
		 * @inheritDoc
		 */
		public function addComponent(component:IGameComponent):IGameObject
		{
			super.addModel(component);

			if (!_componentList)
			{
				_componentList = new Dictionary();
			}

			var added:Boolean = addChild(component, _componentList);

			if (added)
			{
				_numComponents++;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeComponent(component:IGameComponent, dispose:Boolean = false):IGameObject
		{
			super.removeModel(component, false);

			var removed:Boolean = removeChild(component, _componentList);

			if (removed)
			{
				_numComponents--;

				if (dispose)
				{
					component.dispose();
				}
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllComponents(dispose:Boolean = false):IGameObject
		{
			super.removeAllModels(false);

			if (_componentList)
			{
				for (var i:* in _componentList)
				{
					if (dispose)
					{
						_componentList[i].dispose();
					}
				}

				_componentList = null;

				_numComponents = 0;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numComponents():int
		{
			return _numComponents;
		}

		/**
		 * @inheritDoc
		 */
		public function containsComponent(component:IGameComponent):Boolean
		{
			return _componentList && _componentList[component] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function get componentList():Dictionary
		{
			return _componentList;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentByType(clazz:Class):IGameComponent
		{
			for (var i:* in _componentList)
			{
				if (_componentList[i] is clazz)
				{
					return _componentList[i]
				}
			}

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentsByType(clazz:Class):Vector.<IGameComponent>
		{
			var components:Vector.<IGameComponent> = new <IGameComponent>[];

			for (var i:* in _componentList)
			{
				if (_componentList[i] is clazz)
				{
					components.push(_componentList[i]);
				}
			}

			return components;
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllComponents(true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		public function get goSystem():IGOSystem
		{
			return parent as IGOSystem;
		}
	}
}
