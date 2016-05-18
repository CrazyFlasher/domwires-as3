/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import avmplus.getQualifiedClassName;

	public class GOSystemObject extends AbstractGOSystemGearWheelContainer implements IGOSystemObject
	{
		public function GOSystemObject()
		{
			super();
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
		public function addComponent(component:IGOSystemComponent, priority:int = -1):IGOSystemObject
		{
			add(component, priority);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeComponent(component:IGOSystemComponent, dispose:Boolean = false):IGOSystemObject
		{
			remove(component, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllComponents(dispose:Boolean = false):IGOSystemObject
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
		public function containsComponent(component:IGOSystemComponent):Boolean
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
		public function getComponentByType(clazz:Class):IGOSystemComponent
		{
			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i] is clazz)
				{
					return _childrenList[i]
				}
			}

			log("Warning: components [" + getQualifiedClassName(clazz) + "] not found in this GOSystemObject!");

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentsByType(clazz:Class):Array
		{
			var components:Array = [];

			for (var i:int = 0; i < _childrenList.length; i++)
			{
				if (_childrenList[i] is clazz)
				{
					components.push(_childrenList[i]);
				}
			}

			if (components.length == 0)
			{
				log("Warning: components [" + getQualifiedClassName(clazz) + "] not found in this GOSystemObject!");
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
