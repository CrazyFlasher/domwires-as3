/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import flexunit.framework.Assert;

	public class VertexObjectTest
	{
		private var v:IVertexObject;

		[Before]
		public function setUp():void
		{
			v = new VertexObject();
			v.data = new VertexDataVo(10, 10);
		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testData():void
		{
			Assert.assertNotNull(v.data);
		}

		[Test]
		public function testX():void
		{
			Assert.assertEquals(v.data.x, 10);
		}

		[Test]
		public function testY():void
		{
			Assert.assertEquals(v.data.y, 10);
		}
	}
}
