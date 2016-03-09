/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem.tests
{
	import com.crazyfm.extension.goSystem.Component;
	import com.crazyfm.extension.goSystem.IComponent;

	public class ComponentTest
	{

		private var c:IComponent;

		[Before]
		public function setUp():void
		{
			c = new Component();
		}

		[After]
		public function tearDown():void
		{
			c.dispose();
		}

		[Test]
		public function testUpdate():void
		{

		}
	}
}
