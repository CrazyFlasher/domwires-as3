/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem.mechanisms
{
	import com.crazyfm.extension.goSystem.IMechanism;

	public class AbstractMechanismTest
	{
		private var m:IMechanism;

		[Before]
		public function setUp():void
		{
			m = new AbstractMechanism();
		}

		[After]
		public function tearDown():void
		{
			m.disposeWithAllChildren();
		}

		[Test]
		public function testInteract():void
		{

		}

		[Test]
		public function testDisposeWithAllChildren():void
		{

		}

		[Test]
		public function testGearList():void
		{

		}

		[Test]
		public function testDispose():void
		{

		}

		[Test]
		public function testNumGears():void
		{

		}

		[Test]
		public function testRemoveGear():void
		{

		}

		[Test]
		public function testContainsGear():void
		{

		}

		[Test]
		public function testAddGear():void
		{

		}

		[Test]
		public function testRemoveAllGears():void
		{

		}
	}
}
