/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.gearSys.mechanisms
{
	import com.crazyfm.extension.gearSys.IGearSysMechanism;

	public class AbstractMechanismTest
	{
		private var m:IGearSysMechanism;

		[Before]
		public function setUp():void
		{
			m = new GOSystemMechanism();
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
