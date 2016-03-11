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
			w.data = new WorldDataVo(new <BodyDataVo>[
				new BodyDataVo(new <ShapeDataVo>[
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(5, 7), new VertexDataVo(11, 17)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(8, 12), new VertexDataVo(3, 28)])
				]),
				new BodyDataVo(new <ShapeDataVo>[
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(5, 7), new VertexDataVo(11, 17)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(8, 12), new VertexDataVo(3, 28)])
				]),
				new BodyDataVo(new <ShapeDataVo>[
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(10, 10), new VertexDataVo(25, 30)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(5, 7), new VertexDataVo(11, 17)]),
					new ShapeDataVo(new <VertexDataVo>[new VertexDataVo(8, 12), new VertexDataVo(3, 28)])
				])
			]);
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
			Assert.assertEquals(w.bodies.length, 3);
			Assert.assertEquals(w.bodies[1].shapes.length, 3);
			Assert.assertEquals(w.bodies[2].shapes[1].vertices[0].x, 5);
		}
	}
}
