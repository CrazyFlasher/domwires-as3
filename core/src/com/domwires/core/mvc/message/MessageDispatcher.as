/**
 * Created by Anton Nefjodov on 10.06.2016.
 */
package com.domwires.core.mvc.message
{
	import com.domwires.core.common.AbstractDisposable;
	import com.domwires.core.common.Enum;

	import flash.utils.Dictionary;

	/**
	 * Common message dispatcher. Can be used for listening and dispatching messages for views and models.
	 */
	public class MessageDispatcher extends AbstractDisposable implements IMessageDispatcher
	{
		private var _messageMap:Dictionary/*Enum, Vector.<Function>*/;
		private var _message:Message;

		private var extraMessagesHandlerList:Vector.<IMessageDispatcher>;
		private var isBubbling:Boolean;

		/**
		 * @inheritDoc
		 */
		public function addMessageListener(type:Enum, listener:Function):void
		{
			if (!_messageMap)
			{
				_messageMap = new Dictionary();
			}

			if (!_messageMap[type])
			{
				_messageMap[type] = new <Function>[];
				//To avoid check in this case, if vector contains element
				_messageMap[type].push(listener);
			} else if (_messageMap[type].indexOf(listener) == -1)
			{
				_messageMap[type].push(listener);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeMessageListener(type:Enum, listener:Function):void
		{
			if (_messageMap)
			{
				if (_messageMap[type])
				{
					_messageMap[type].removeAt(_messageMap[type].indexOf(listener));
					if (_messageMap[type].length == 0)
					{
						delete _messageMap[type];
					}
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllMessageListeners():void
		{
			if (_messageMap)
			{
				for each (var v:Vector.<Function> in _messageMap)
				{
					v.length = 0;
				}

				_messageMap = null;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessage(type:Enum, data:Object = null, bubbles:Boolean = false):void
		{
			if (isBubbling)
			{
				log("WARNING: You try to dispatch '" + type.toString() + "' while '" + _message.type.toString() + "' is bubbling. Making" +
					" new instance of IMessage");
			}

			_message = getMessage(type, data, bubbles, isBubbling);
			_message._target = this;
			_message.setCurrentTarget(this);

			handleMessage(_message);

			if (!isDisposed)
			{
				bubbleUpMessage(_message);
			}
		}

		private function bubbleUpMessage(message:Message):void
		{
			if (message.bubbles)
			{
				isBubbling = true;
				var currentTarget:Object = message._target;
				var bubbleUp:Boolean;
				while (currentTarget && currentTarget.hasOwnProperty("parent"))
				{
					currentTarget = currentTarget["parent"];

					if (!currentTarget) break;

					if (currentTarget is IBubbleMessageHandler)
					{
						// onMessageBubbled() can stop the bubbling by returning false.
						bubbleUp = IBubbleMessageHandler(message.setCurrentTarget(currentTarget)).onMessageBubbled(message);
						
						if (!bubbleUp)
						{
							break;
						}
					}
				}

				if (extraMessagesHandlerList != null)
				{
					var extraMessagesHandler:IMessageDispatcher;
					for each (extraMessagesHandler in extraMessagesHandlerList)
					{
						currentTarget = extraMessagesHandler;
						extraMessagesHandler.handleMessage(message);
					}
				}
			}
			isBubbling = false;
		}

		/**
		 * @inheritDoc
		 */
		public function registerExtraMessageHandler(object:IMessageDispatcher):void
		{
			if (!extraMessagesHandlerList)
			{
				extraMessagesHandlerList = new <IMessageDispatcher>[object];
			}else
			if (extraMessagesHandlerList.indexOf(object) == -1)
			{
				extraMessagesHandlerList.push(object);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function unRegisterExtraMessageHandler(object:IMessageDispatcher):void
		{
			if (!extraMessagesHandlerList) return;

			var objectIndex:int = extraMessagesHandlerList.indexOf(object);
			if (objectIndex != -1)
			{
				extraMessagesHandlerList.removeAt(objectIndex);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function handleMessage(message:IMessage):void
		{
			if (_messageMap)
			{
				if (_messageMap[message.type])
				{
					var listener:Function;
					for each (listener in _messageMap[message.type])
					{
						listener(message);
					}
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function hasMessageListener(type:Enum):Boolean
		{
			if (_messageMap)
			{
				return _messageMap[type] != null;
			}

			return false;
		}

		private function getMessage(type:Enum, data:Object, bubbles:Boolean, forceReturnNew:Boolean = false):Message
		{
			if (!_message || forceReturnNew)
			{
				_message = new Message(type, data, bubbles);
			} else
			{
				_message._type = type;
				_message._data = data;
				_message._bubbles = bubbles;
			}

			return _message;
		}

		/**
		 * Disposes and removes all message listeners.
		 */
		override public function dispose():void
		{
			removeAllMessageListeners();

			extraMessagesHandlerList = null;

			_message = null;
			//TODO: memory leaks test
			_messageMap = null;

			super.dispose();
		}
	}
}

import com.domwires.core.common.Enum;
import com.domwires.core.mvc.message.IMessage;

internal class Message implements IMessage
{
	internal var _type:Enum;
	internal var _data:Object;
	internal var _bubbles:Boolean;
	internal var _target:Object;
	internal var _previousTarget:Object;

	private var _currentTarget:Object;

	public function Message(type:Enum, data:Object = null, bubbles:Boolean = true)
	{
		_type = type;
		_data = data;
		_bubbles = bubbles;
	}

	internal function setCurrentTarget(value:Object):Object
	{
		_previousTarget = _currentTarget;

		_currentTarget = value;

		return _currentTarget;
	}

	public function get type():Enum
	{
		return _type;
	}

	public function get data():Object
	{
		return _data;
	}

	public function get bubbles():Boolean
	{
		return _bubbles;
	}

	public function get target():Object
	{
		return _target;
	}

	public function get currentTarget():Object
	{
		return _currentTarget;
	}

	public function get previousTarget():Object
	{
		return _previousTarget;
	}
}
