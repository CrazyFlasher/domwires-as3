/**
 * Created by Anton Nefjodov on 10.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.Model;

	import flexunit.framework.Assert;

	import starling.animation.Juggler;

	public class GameObjectTest
	{
		private var go:IGameObject;

		[Before]
		public function setUp():void
		{
			go = new GameObject(new Juggler());
		}

		[After]
		public function tearDown():void
		{
			go.dispose();
		}

		[Test]
		public function testAdvanceTime():void
		{

		}

		[Test]
		public function testAddModel():void
		{
			go.addModel(new GameComponent());
			Assert.assertEquals(go.numModels, 1);
		}

		[Test(expects='Error')]
		public function testAddModelWrongType():void
		{
			go.addModel(new Model());
		}

		[Test]
		public function testStopSimulation():void
		{
			Assert.assertTrue(go.isSimulating);
			go.stopSimulation();
			Assert.assertFalse(go.isSimulating);
		}

		[Test]
		public function testStartSimulation():void
		{
			Assert.assertTrue(go.isSimulating);
			go.stopSimulation();
			Assert.assertFalse(go.isSimulating);
			go.startSimulation();
			Assert.assertTrue(go.isSimulating);
		}

		[Test(expects='Error')]
		public function testStopSimulation_noJuggler():void
		{
			go = new GameObject();
			go.stopSimulation();
		}

		[Test(expects='Error')]
		public function testStartSimulation_noJuggler():void
		{
			go = new GameObject();
			go.startSimulation();
		}

		[Test]
		public function testDispose():void
		{
			go.dispose();
			Assert.assertTrue(go.isDisposed);
		}

		[Test(expects='Error')]
		public function testDispose_startSim():void
		{
			go.dispose();
			go.startSimulation();
		}

		[Test(expects='Error')]
		public function testDispose_stopSim():void
		{
			go.dispose();
			go.stopSimulation();
		}
	}
}
