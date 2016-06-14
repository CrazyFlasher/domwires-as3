/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	import avmplus.getQualifiedClassName;

	public class GearSysObject extends AbstractGearSysGearWheelContainer implements IGearSysObject
	{
		public function GearSysObject()
		{
			super();
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
		public function addComponent(component:IGearSysComponent, priority:int = -1):IGearSysObject
		{
			add(component, priority);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeComponent(component:IGearSysComponent, dispose:Boolean = false):IGearSysObject
		{
			remove(component, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllComponents(dispose:Boolean = false):IGearSysObject
		{
			removeAll(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numComponents():int
		{
			return children ? children.length : 0;
		}

		/**
		 * @inheritDoc
		 */
		public function containsComponent(component:IGearSysComponent):Boolean
		{
			return children && children.indexOf(component) != -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get componentList():Array
		{
			return children;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentByType(clazz:Class):IGearSysComponent
		{
			for (var i:int = 0; i < children.length; i++)
			{
				if (children[i] is clazz)
				{
					return children[i]
				}
			}

			log("Warning: components [" + getQualifiedClassName(clazz) + "] not found in this GearSysObject!");

			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getComponentsByType(clazz:Class):Array
		{
			var components:Array = [];

			for (var i:int = 0; i < children.length; i++)
			{
				if (children[i] is clazz)
				{
					components.push(children[i]);
				}
			}

			if (components.length == 0)
			{
				log("Warning: components [" + getQualifiedClassName(clazz) + "] not found in this GearSysObject!");
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
		public function get goSystem():IGearSys
		{
			return parent as IGearSys;
		}
	}
}
