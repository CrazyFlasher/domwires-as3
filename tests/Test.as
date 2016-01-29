/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package
{
	import flash.utils.Dictionary;

	import flexunit.framework.Assert;

	public class Test
	{
		[Test]
		public function test():void
		{
			var d:Dictionary = new Dictionary();
			Assert.assertEquals(d.length, 0);
			d["a"] = 1;
			d["b"] = 2;
			d["c"] = 3;
			Assert.assertEquals(d.length, 0);
		}
	}
}
