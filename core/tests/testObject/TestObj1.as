/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package testObject
{
	public class TestObj1
	{
		private var _d:int;
		private var _s:String;

		public function TestObj1()
		{
		}

		public function set d(value:int):void
		{
			_d = value;
		}

		public function get d():int
		{
			return _d;
		}

		public function get s():String
		{
			return _s;
		}

		public function set s(value:String):void
		{
			_s = value;
		}
	}
}
