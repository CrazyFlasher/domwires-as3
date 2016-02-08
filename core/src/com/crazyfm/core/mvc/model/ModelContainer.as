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
	 * Model object that can contain other models.
	 */
	public class ModelContainer extends Model implements IModelContainer, IBubbleEventHandler
	{
		private var _modelList:Dictionary;
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
				(model as HierarchyObject).setParent(this);
				_numModels++;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function addModels(models:Vector.<IModel>):void
		{
			for (var i:int = 0; i < models.length; i++)
			{
				if (!(models[i] is IModel))
				{
					throw new Error("ModelContainer#addModels: Error! You should pass IModel only!");
				}
				addModel(models[i]);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeModel(model:IModel, dispose:Boolean = false):void
		{
			var removed:Boolean = removeChild(model, _modelList);

			if(removed)
			{
				_numModels--;

				if(dispose)
				{
					model.dispose();
				}else
				{
					(model as Model).setParent(null);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeModels(models:Vector.<IModel>, dispose:Boolean = false):void
		{
			for (var i:int = 0; i < models.length; i++)
			{
				if (!(models[i] is IModel))
				{
					throw new Error("ModelContainer#removeModels: Error! You should pass IModel only!");
				}
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
					removeModel(_modelList[i], dispose);
				}

				_modelList = null;
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
			return _modelList != null && _modelList[model] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function disposeWithAllChildren():void
		{
			removeAllModels(true);

			super.dispose();
		}
	}
}
