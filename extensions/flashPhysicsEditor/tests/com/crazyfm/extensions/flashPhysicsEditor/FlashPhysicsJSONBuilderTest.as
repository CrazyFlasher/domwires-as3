/**
 * Created by Anton Nefjodov on 18.03.2016.
 */
package com.crazyfm.extensions.flashPhysicsEditor
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.extensions.physics.BodyObject;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.factory.PhysFactory;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	import flash.utils.ByteArray;

	import flexunit.framework.Assert;

	public class FlashPhysicsJSONBuilderTest
	{

		[Embed(source="../../../../test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var world:IWorldObject;

		[Before]
		public function setUp():void
		{
			world = new WorldObject(new WorldDataVo(JSON.parse((new WorldClass() as ByteArray).toString())));
		}

		[Test]
		public function testBodiesPositions():void
		{
			var bodyObj_1:IBodyObject = world.bodyObjectById("wb");
			Assert.assertEquals(bodyObj_1.data.x, 50);
			Assert.assertEquals(bodyObj_1.data.y, 50);
		}

		[Test]
		public function testBodiesAngle():void
		{
			var bodyObj_2:IBodyObject = world.bodyObjectById("b_1");
			Assert.assertEquals(bodyObj_2.data.x, 210.4);
			Assert.assertEquals(bodyObj_2.data.y, 91.55);
			Assert.assertEquals(bodyObj_2.data.angle.toFixed(2), (-135 * Math.PI / 180).toFixed(2));
		}

		[Test]
		public function testWorldProperties():void
		{
			Assert.assertEquals(world.data.gravity.x, 0);
			Assert.assertEquals(world.data.gravity.y, 50);
		}

		[Test]
		public function testJointProperties():void
		{
			var j:IJointObject = world.jointObjectById("j");
			Assert.assertEquals(j.data.x, 204.3);
			Assert.assertEquals(j.data.y, 76.3);
			Assert.assertEquals(j.data.minAngle.toFixed(2), (Math.PI / 2).toFixed(2));
			Assert.assertEquals(j.data.maxAngle.toFixed(2), (Math.PI).toFixed(2));

			var wj:IJointObject = world.jointObjectById("wj");
			Assert.assertEquals(wj.data.bodyToConnectIdList[0], "wb");
			Assert.assertEquals(wj.data.bodyToConnectIdList[1], "$world");
		}

		[Test]
		public function testShapesProperties():void
		{
			var s:IShapeObject = world.bodyObjectById("b_1").shapeObjectById("s_2");
			Assert.assertEquals(s.data.x, 0);
			Assert.assertEquals(s.data.y, 50);
			Assert.assertEquals(s.data.radius, 15);

			var s_2:IShapeObject = world.bodyObjectById("wb").shapeObjectById("s_2");
			Assert.assertEquals(s_2.data.x, 65.65);
			Assert.assertEquals(s_2.data.y, -2.05);
			Assert.assertEquals(s_2.data.angle.toFixed(2), (50 * Math.PI / 180).toFixed(2));
			Assert.assertEquals(s_2.data.vertexDataList.length, 5);
		}

		[After]
		public function tearDown():void
		{

		}
	}
}
