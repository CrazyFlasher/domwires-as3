/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	public class GameComponentTest
	{
		private var c:IGameComponent;

		[Before]
		public function setUp():void
		{
			c = new GameComponent();
		}

		[After]
		public function tearDown():void
		{
			c.dispose();
		}

		[Test]
		public function testAdvanceTime():void
		{

		}
	}
}
