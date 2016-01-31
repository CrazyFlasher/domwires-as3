/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IContext;
	import com.crazy.mvc.api.IView;

	import flash.utils.Dictionary;

	public class Context extends ModelContainer implements IContext
	{
		//private var _signalTypeToCommandMappings:Vector.<Object>/*String, Class*/;

		private var _viewList:Dictionary;
		private var _numViews:int;

		public function Context()
		{
			super();
		}

		/*
		public function mapSignalTypeToCommand(signalType:String, commandClass:Class, affectedModels:Vector.<IModel> = null):void
		{
			if (!_signalTypeToCommandMappings)
			{
				_signalTypeToCommandMappings = new Vector.<Object>()
			}

			_signalTypeToCommandMappings.push({signalType: signalType, commandClass: commandClass, affectedModels: affectedModels})
		}

		public function unmapSignalTypeFromCommand(signalType:String, commandClass:Class):void
		{
			if (_signalTypeToCommandMappings)
			{
				var indexToRemove:int = -1;
				for (var i:int = 0; i < _signalTypeToCommandMappings.length; i++)
				{
					var mapping:Object = _signalTypeToCommandMappings[i];
					if (mapping.signalType == signalType && mapping.commandClass == commandClass)
					{
						indexToRemove = i;
						mapping.commandClass = null;
						mapping.affectedModels = null;
						break;
					}
				}

				if (indexToRemove > -1)
				{
					_signalTypeToCommandMappings.removeAt(indexToRemove);
				}
			}
		}

		public function mapViewToMediator(view:IView, mediator:IController):void
		{

		}

		public function unmapViewFromMediator(view:IView, mediator:IController):void
		{

		}


		override public function onEventBubbled(event:IEvent):Boolean
		{
			super.onEventBubbled(event);

			var type:String = (event as ISignalEvent).type;

			for each (var mapping:Object in _signalTypeToCommandMappings)
			{
				mapping.signalType == type;
				var command:ICommand = new (mapping.commandClass(mapping.affectedModels));
				command.execute();
				command.retain();
			}
		}*/
		public function addView(view:IView):void
		{
			if (!_viewList)
			{
				_viewList = new Dictionary();
			}

			var added:Boolean = addChild(view, _viewList);

			if (added)
			{
				_numViews++;
			}
		}

		public function addViews(views:Vector.<IView>):void
		{
			for (var i:int = 0; i < views.length; i++)
			{
				if (!(views[i] is IView))
				{
					throw new Error("Context#addViews: Error! You should pass IView only!");
				}
				addView(views[i]);
			}
		}

		public function removeView(view:IView, dispose:Boolean = false):void
		{
			var removed:Boolean = removeChild(view, _viewList);

			if(removed)
			{
				_numViews--;

				if(dispose)
				{
					view.dispose();
				}
			}
		}

		public function removeViews(views:Vector.<IView>, dispose:Boolean = false):void
		{
			for (var i:int = 0; i < views.length; i++)
			{
				if (!(views[i] is IView))
				{
					throw new Error("Context#removeViews: Error! You should pass IView only!");
				}
				removeView(views[i], dispose);
			}
		}

		public function removeAllViews(dispose:Boolean = false):void
		{
			if (_viewList)
			{
				for (var i:* in _viewList)
				{
					removeView(_viewList[i], dispose);
				}

				_viewList = null;
			}
		}

		public function get numViews():int
		{
			return _numViews;
		}

		public function containsView(view:IView):Boolean
		{
			return _viewList != null && _viewList[view] != null;;
		}
	}
}
