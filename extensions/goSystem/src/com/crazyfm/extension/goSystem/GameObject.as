/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;

	public class GameObject extends HierarchyObjectContainer implements IGameObject
	{
		private var _isEnabled:Boolean;

		public function GameObject()
		{
			super();

			setEnabled(true);
		}

		/**
		 * @inheritDoc
		 */
		public function interact(timePassed:Number):void
		{
			if (!_isEnabled) return;

			for (var i:int = 0; i < _childrenList.length; i++)
			{
				_childrenList[i].interact(timePassed);
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
			add(component);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeComponent(component:IGameComponent, dispose:Boolean = false):IGameObject
		{
			remove(component, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllComponents(dispose:Boolean = false):IGameObject
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numComponents():int
		{
			return _childrenList ? _childrenList.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsComponent(component:IGameComponent):Boolean
		{
			return _childrenList && _childrenList.indexOf(component) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get componentList():Array
		{
			return _childrenList;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentByType(clazz:Class):IGameComponent
		{
			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i] is clazz)
				{
					return _childrenList[i]
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

			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i] is clazz)
				{
					components.push(_childrenList[i]);
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

			_childrenList = null;

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
