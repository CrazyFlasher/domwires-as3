/**
 * Created by CrazyFlasher on 18.06.2018.
 */
package testObject
{
	import com.domwires.core.mvc.model.AbstractModel;

	public class TestModel7 extends AbstractModel
	{
		public var testVar:int;

		public function dispatch():void
		{
			dispatchMessage(MyCoolEnum.PREVED, null, true);
		}
	}
}
