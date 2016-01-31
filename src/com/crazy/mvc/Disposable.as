/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IDisposable;

	public class Disposable implements IDisposable
	{
		private var _isDisposed:Boolean;

		public function Disposable()
		{
		}

		public function dispose():void
		{
			_isDisposed = true;
		}

		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}
