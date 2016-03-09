/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.HierarchyObject;
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.core.mvc.model.ns_hierarchy;

	import flash.utils.Dictionary;

	import starling.animation.IAnimatable;

	use namespace ns_hierarchy;

	public class GameObject extends ModelContainer implements IGameObject, IAnimatable
	{
		private var _componentList:Dictionary/*IComponent, IComponent*/
		private var _numComponents:int;

		public function GameObject()
		{
			super();
		}

		public function addComponent(value:IComponent):void
		{
			addModel(value);

			if (!_componentList)
			{
				_componentList = new Dictionary();
			}

			var added:Boolean = addChild(value, _componentList);

			if (added)
			{
				_numComponents++;

				if (value.parent != null)
				{
					(value.parent as IGameObject).removeComponent(value);
				}
				(value as HierarchyObject).setParent(this);
			}
		}

		public function addComponents(...values):void
		{
			addModels(values);

			for (var i:int = 0; i < values.length; i++)
			{
				if (values[i] is IComponent)
				{
					addComponent(values[i]);
				}else
				{
					throw new Error("Object is not IComponent: ", typeof(values[i]));
				}
			}
		}

		public function removeComponent(value:IComponent):void
		{
			removeModel(value);

			var removed:Boolean = removeChild(value, _componentList);

			if (removed)
			{
				_numComponents--;

				(value as Component).setParent(null);
			}
		}

		public function removeComponents(...values):void
		{
			removeModels(false, values);

			for (var i:int = 0; i < values.length; i++)
			{
				removeModel(values[i], false);
			}
		}

		public function removeAllComponents():void
		{
			removeAllModels();

			if (_componentList)
			{
				for (var i:* in _componentList)
				{
					(_componentList[i] as Component).setParent(null);
				}

				_componentList = null;

				_numComponents = 0;
			}
		}

		override public function dispose():void
		{
			removeAllComponents();

			super.dispose();
		}

		public function advanceTime(time:Number):void
		{
			//TODO: update components
		}
	}
}
