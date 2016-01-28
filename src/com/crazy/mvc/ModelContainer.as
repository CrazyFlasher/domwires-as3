/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;
	import com.crazy.mvc.api.ISignalEvent;

	import flash.utils.Dictionary;

	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	public class ModelContainer extends Model implements IModelContainer, IBubbleEventHandler
	{
		private var _modelList:Dictionary;
		private var _bubbledSignalListeners:Dictionary;

		public function ModelContainer()
		{
			super();
		}

		public function addModel(model:IModel):void
		{
			if (!_modelList)
			{
				_modelList = new Dictionary();
			}

			model.parent = this;
			_modelList[model] = model;
		}

		public function removeModel(model:IModel):void
		{
			if (_modelList)
			{
				model.dispose();
				delete _modelList[model]
			}
		}

		public function removeAllModels():void
		{
			if (_modelList)
			{
				for (var i:* in _modelList)
				{
					removeModel(_modelList[i]);
				}

				_modelList = null;
			}
		}

		override public function dispose():void
		{
			super.dispose();

			removeAllModels();
		}

		public function onEventBubbled(event:IEvent):Boolean
		{
            var type:String = (event as ISignalEvent).type;

			if(getBubbledSignalListeners()[type] != null)
			{
				return getBubbledSignalListeners()[type](event);
			}
			return true;
		}

        override public function addSignalListener(type:String, listener:Function):void
        {
            super.addSignalListener(type, listener);

            getBubbledSignalListeners()[type] = listener;
        }

        override public function removeSignalListener(type:String, listener:Function):void
        {
            super.removeSignalListener(type, listener);

            delete getBubbledSignalListeners()[type];
        }

        override public function removeAllSignals():void
        {
            super.removeAllSignals();

            if(_bubbledSignalListeners)
            {
                for (var type:String in _bubbledSignalListeners) {
                    delete _bubbledSignalListeners[type];
                }

                _bubbledSignalListeners = null
            }
        }

        private function getBubbledSignalListeners():Dictionary
        {
            if(!_bubbledSignalListeners)
            {
                _bubbledSignalListeners = new Dictionary();
            }

            return _bubbledSignalListeners;
        }
	}
}
