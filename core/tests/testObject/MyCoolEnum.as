/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package testObject
{
	import com.domwires.core.common.Enum;

	public class MyCoolEnum extends Enum
	{
		public static const PREVED:MyCoolEnum = new MyCoolEnum("preved");
		public static const BOGA:MyCoolEnum = new MyCoolEnum("boga");
		public static const SHALOM:MyCoolEnum = new MyCoolEnum("shalom");

		public function MyCoolEnum(name:String)
		{
			super(name);
		}
	}
}
