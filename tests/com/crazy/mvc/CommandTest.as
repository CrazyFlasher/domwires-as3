/**
 * Created by Anton Nefjodov on 29.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.ICommand;

	public class CommandTest
	{
		private var command:ICommand;

		[Before]
		public function setUp():void
		{
			command = new Command();
		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testRetain():void
		{

		}

		[Test]
		public function testExecute():void
		{

		}
	}
}
