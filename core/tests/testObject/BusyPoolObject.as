/**
 * Created by CrazyFlasher on 23.03.2018.
 */
package testObject
{
	public class BusyPoolObject
	{
		private var _isBusy:Boolean;
		
		public function get isBusy():Boolean
		{
			return _isBusy;
		}

		public function set isBusy(value:Boolean):void
		{
			_isBusy = value;
		}
	}
}
