/**
 * Created by Anton Nefjodov on 14.06.2016.
 */
package
{
	public class MethodTest
	{
		//[Ignore]
		[Test]
		public function testReturnArray():void
		{
			var a:Array;

			for (var i:int = 0; i < 100000; i++)
			{
				var f:Function = function():Array
				{
					return a;
				}
			}
		}

		[Ignore]
		[Test]
		public function testReturnVoid():void
		{
			var a:Array;

			for (var i:int = 0; i < 100000; i++)
			{
				var f:Function = function():void
				{

				}
			}
		}

	}
}
