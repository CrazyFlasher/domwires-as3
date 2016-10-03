/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazyfm.core.common
{
	/**
	 * Any object that need to be disposed to free memory can extends this class.
	 */
	public class AbstractDisposable implements IDisposable
	{
		private var _isDisposed:Boolean;

		public function AbstractDisposable()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			if (_isDisposed)
			{
				log("Object already disposed!");
				throw new Error("Object already disposed!");
			}

			_isDisposed = true;
		}

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}
