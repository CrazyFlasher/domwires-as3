/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem.mechanisms
{
	import com.crazyfm.core.mvc.model.ModelContainer;
	import com.crazyfm.extension.goSystem.IGearWheel;
	import com.crazyfm.extension.goSystem.IMechanism;

	import flash.utils.Dictionary;

	public class AbstractMechanism extends ModelContainer implements IMechanism
	{
		private var _gearList:Dictionary;
		private var _numGears:int;
		
		public function AbstractMechanism()
		{

		}

		/**
		 * @inheritDoc
		 */
		public function addGear(value:IGearWheel):IMechanism
		{
			super.addModel(value);

			if (!_gearList)
			{
				_gearList = new Dictionary();
			}

			var added:Boolean = addChild(value, _gearList);

			if (added)
			{
				_numGears++;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeGear(value:IGearWheel, dispose:Boolean = false):IMechanism
		{
			super.removeModel(value, false);

			var removed:Boolean = removeChild(value, _gearList);

			if (removed)
			{
				_numGears--;

				if (dispose)
				{
					value.dispose();
				}
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllGears(dispose:Boolean = false):IMechanism
		{
			super.removeAllModels(false);

			if (_gearList)
			{
				for (var i:* in _gearList)
				{
					if (dispose)
					{
						_gearList[i].dispose();
					}
				}

				_gearList = null;

				_numGears = 0;
			}

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numGears():int
		{
			return _numGears;
		}

		/**
		 * @inheritDoc
		 */
		public function containsGear(value:IGearWheel):Boolean
		{
			return _gearList && _gearList[value] != null;
		}

		/**
		 * @inheritDoc
		 */
		public function get gearList():Dictionary
		{
			return _gearList;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			removeAllGears();

			super.dispose();
		}

		/**
		 * @inheritDoc
		 */
		override public function disposeWithAllChildren():void
		{
			removeAllGears(true);

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		public function interact(passedTime:Number):void
		{
			for (var i:* in _gearList)
			{
				_gearList[i].interact(passedTime);
			}
		}
	}
}
