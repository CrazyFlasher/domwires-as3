/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.crazyfm.core.mvc.command
{
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;
	import com.crazyfm.core.mvc.message.IMessage;

	/**
	 * Command (or service) that operates on provided (injected) models.
	 */
	public class AbstractCommand extends AbstractHierarchyObject implements ICommand
	{
		private var message:ForwardMessage;

		/**
		 * @inheritDoc
		 */
		public function execute():void
		{

		}

		/**
		 * @inheritDoc
		 */
		public function retain():void
		{

		}

		protected function get forwardMessage():ForwardMessage
		{
			if (!message)
			{
				message = new ForwardMessage();
			}

			return message;
		}


		override public function dispose():void
		{
			message = null;

			super.dispose();
		}
	}
}

import com.crazyfm.core.common.Enum;
import com.crazyfm.core.mvc.message.IMessage;

internal class ForwardMessage implements IMessage
{
	public var _type:Enum;
	public var _data:Object;
	public var _bubbles:Boolean;
	public var _target:Object;
	public var _currentTarget:Object;

	public function ForwardMessage()
	{
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
		//not needed for forward message
		return null;
	}
}
