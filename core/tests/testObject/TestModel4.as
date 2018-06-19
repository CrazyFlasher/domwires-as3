/**
 * Created by CrazyFlasher on 18.06.2018.
 */
package testObject
{
	import com.domwires.core.mvc.model.AbstractModel;

	public class TestModel4 extends AbstractModel
	{
		private var _testVar:int;

		public function set testVar(value:int):void
		{
			_testVar = value;
			dispatchMessage(MyCoolEnum.BOGA, null, true);
		}

		public function get testVar():int
		{
			return _testVar;
		}
	}
}
