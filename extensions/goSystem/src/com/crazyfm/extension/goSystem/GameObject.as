/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModel;
	import com.crazyfm.core.mvc.model.ModelContainer;

	import flash.utils.Dictionary;

	import starling.animation.IAnimatable;

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
			}
		}

		public function addComponents(...values):void
		{
			for (var i:int = 0; i < values.length; i++)
			{
				if (values[i] is IModel)
				{
					addModel(values[i] as IModel);
				}
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
			}
		}

		public function removeComponents(...values):void
		{
			for (var i:int = 0; i < values.length; i++)
			{
				removeModel(values[i] as IModel, false);
				removeComponent(values[i]);
			}
		}

		public function removeAllComponents():void
		{
			removeAllModels();

			if (_componentList)
			{
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
			for (var component:* in componentList)
			{
				(component as IComponent).update(time);
			}
		}

		public function get numComponents():int
		{
			return _numComponents;
		}

		public function get componentList():Dictionary
		{
			return _componentList;
		}
	}
}
