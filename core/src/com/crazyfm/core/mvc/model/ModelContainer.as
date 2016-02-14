/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.model
{
	import com.crazyfm.core.mvc.event.ISignalEvent;

	import flash.utils.Dictionary;

	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	use namespace ns_hierarchy;

	/**
	 * Extends IModel and is able to add or remove other IModel objects (can be parent of them). Also receives all
	 * signals from children, sub-children and so on.
	 */
	public class ModelContainer extends Model implements IModelContainer, IBubbleEventHandler
	{
		private var _modelList:Dictionary/*IModel, IModel*/
		private var _bubbledSignalListeners:Dictionary;

		private var _numModels:int;

		public function ModelContainer()
		{
			super();
		}

		protected function addChild(child:Object, toList:Dictionary):Boolean
		{
			if (!toList[child])
			{
				toList[child] = child;

				return true;
			}

			return false;
		}

		protected function removeChild(child:Object, fromList:Dictionary):Boolean
		{
			if (fromList && fromList[child])
			{
				delete fromList[child];

				return true;
			}

			return false;
		}

		/**
		 * @inheritDoc
		 */
		public function addModel(model:IModel):void
		{
			if (!_modelList)
			{
				_modelList = new Dictionary();
			}

			var added:Boolean = addChild(model, _modelList);

			if (added)
			{
				_numModels++;
				
				if (model.parent != null)
				{
					(model.parent as IModelContainer).removeModel(model);
				}
				(model as HierarchyObject).setParent(this);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function addModels(...models):void
		{
			for (var i:int = 0; i < models.length; i++)
			{
				if (models[i] is IModel)
				{
					addModel(models[i]);
				}else
				{
					throw new Error("Object is not IModel: ", typeof(models[i]));
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeModel(model:IModel, dispose:Boolean = false):void
		{
			var removed:Boolean = removeChild(model, _modelList);

			if (removed)
			{
				_numModels--;

				if (dispose)
				{
					model.dispose();
				} else
				{
					(model as Model).setParent(null);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeModels(dispose:Boolean, ...models):void
		{
			for (var i:int = 0; i < models.length; i++)
			{
				removeModel(models[i], dispose);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllModels(dispose:Boolean = false):void
		{
			if (_modelList)
			{
				for (var i:* in _modelList)
				{
					//delete _modelList[i];

					if (dispose)
					{
						_modelList[i].dispose();
					} else
					{
						(_modelList[i] as Model).setParent(null);
					}
				}

				_modelList = null;

				_numModels = 0;
			}
		}

		/**
		 * Disposes object and removes all children models, but doesn't dispose them.
		 */
		override public function dispose():void
		{
			removeAllModels();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function onEventBubbled(event:IEvent):Boolean
		{
			var type:String = (event as ISignalEvent).type;

			if (getBubbledSignalListeners()[type] != null)
			{
				return getBubbledSignalListeners()[type](event);
			}

			return true;
		}

		/**
		 * @inheritDoc
		 */
		override public function addSignalListener(type:String, listener:Function):void
		{
			super.addSignalListener(type, listener);

			getBubbledSignalListeners()[type] = listener;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeSignalListener(type:String):void
		{
			super.removeSignalListener(type);

			delete getBubbledSignalListeners()[type];
		}

		/**
		 * @inheritDoc
		 */
		override public function removeAllSignals():void
		{
			super.removeAllSignals();

			if (_bubbledSignalListeners)
			{
				for (var type:String in _bubbledSignalListeners)
				{
					delete _bubbledSignalListeners[type];
				}

				_bubbledSignalListeners = null
			}
		}

		private function getBubbledSignalListeners():Dictionary
		{
			if (!_bubbledSignalListeners)
			{
				_bubbledSignalListeners = new Dictionary();
			}

			return _bubbledSignalListeners;
		}

		/**
		 * @inheritDoc
		 */
		public function get numModels():int
		{
			return _numModels;
		}

		/**
		 * @inheritDoc
		 */
		public function containsModel(model:IModel):Boolean
		{
			return _modelList && _modelList[model] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function disposeWithAllChildren():void
		{
			removeAllModels(true);

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		public function get modelList():Dictionary
		{
			return _modelList;
		}
	}
}
