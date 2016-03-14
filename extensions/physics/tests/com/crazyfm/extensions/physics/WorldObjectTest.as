/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import flexunit.framework.Assert;

	public class WorldObjectTest
	{

		private var w:IWorldObject;

		[Before]
		public function setUp():void
		{
			w = new WorldObject();

			var s_1:ShapeDataVo = new ShapeDataVo();
			var s_2:ShapeDataVo = new ShapeDataVo();
			var s_3:ShapeDataVo = new ShapeDataVo();

			s_1.vertexDataList = new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30), new VertexDataVo(10, 50)];
			s_2.vertexDataList = new <VertexDataVo>[new VertexDataVo(60, 60), new VertexDataVo(75, 80), new VertexDataVo(60, 100)];
			s_3.vertexDataList = new <VertexDataVo>[new VertexDataVo(110, 110), new VertexDataVo(125, 130), new VertexDataVo(110, 150)];

			var bd_1:BodyDataVo = new BodyDataVo();
			var bd_2:BodyDataVo = new BodyDataVo();
			var bd_3:BodyDataVo = new BodyDataVo();
			bd_1.shapeDataList = new <ShapeDataVo>[s_1, s_2, s_3];
			bd_2.shapeDataList = new <ShapeDataVo>[s_1, s_2, s_3];
			bd_3.shapeDataList = new <ShapeDataVo>[s_1, s_2, s_3];

			var wd:WorldDataVo = new WorldDataVo();
			wd.bodyDataList = new <BodyDataVo>[bd_1, bd_2, bd_3];

			w.data = wd;
		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testData():void
		{
			Assert.assertNotNull(w.data);
		}

		[Test]
		public function testBodies():void
		{
			Assert.assertEquals(w.bodyObjectList.length, 3);
			Assert.assertEquals(w.bodyObjectList[1].shapeObjectList.length, 3);
			Assert.assertEquals(w.bodyObjectList[2].shapeObjectList[1].vertexObjectList[0].x, 60);
		}
	}
}
