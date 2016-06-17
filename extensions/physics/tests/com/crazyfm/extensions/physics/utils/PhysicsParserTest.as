/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics.utils
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	public class PhysicsParserTest
	{
		private var worldJson:Object;

		[Before]
		public function setUp():void
		{
			worldJson =
					JSON.parse('{"id":"instance144","gravity":{"x":0,"y":600},"joints":[],"bodies":[{"angle":0,"allowRotation":false,"filter":{"collisionMask":4352,"collisionGroup":17},"y":630,"shapes":[{"angle":0,"x":-12,"id":"torso","y":-42,"vertices":[{"x":2,"id":"v_1","y":2},{"x":22,"id":"v_2","y":2},{"x":22,"id":"v_3","y":42},{"x":2,"id":"v_4","y":42}]},{"radius":10,"angle":0,"x":0,"id":"legs","y":0},{"radius":10,"angle":0,"x":0,"id":"head","y":-40}],"x":400,"id":"enemy_1","material":{"rollingFriction":0,"dynamicFriction":0,"staticFriction":0}},{"angle":0,"allowRotation":false,"filter":{"collisionMask":4352,"collisionGroup":17},"y":640,"shapes":[{"angle":0,"x":-12,"id":"torso","y":-42,"vertices":[{"x":2,"id":"v_1","y":2},{"x":22,"id":"v_2","y":2},{"x":22,"id":"v_3","y":42},{"x":2,"id":"v_4","y":42}]},{"radius":10,"angle":0,"x":0,"id":"legs","y":0},{"radius":10,"angle":0,"x":0,"id":"head","y":-40}],"x":70,"id":"user","material":{"rollingFriction":0,"dynamicFriction":0,"staticFriction":0}},{"type":"static","angle":0,"filter":{"collisionMask":17,"collisionGroup":4352},"y":500,"shapes":[{"angle":0,"x":110,"id":"ladder_to3","y":0,"vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"teleportExitId":"ladder_to3"},"y":-20,"x":90,"id":"ladder_from3","vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"isLadder":true},"y":0,"x":0,"id":"ladder3","vertices":[{"x":90,"id":"v_1","y":20},{"x":100,"id":"v_2","y":20},{"x":100,"id":"v_3","y":170},{"x":90,"id":"v_4","y":170}]},{"angle":0,"x":1070,"id":"ladder_to2","y":140,"vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"teleportExitId":"ladder_to2"},"y":120,"x":1050,"id":"ladder_from2","vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"isLadder":true},"y":0,"x":0,"id":"ladder2","vertices":[{"x":1050,"id":"v_1","y":160},{"x":1060,"id":"v_2","y":160},{"x":1060,"id":"v_3","y":360},{"x":1050,"id":"v_4","y":360}]},{"angle":0,"x":1030,"id":"ladder_to1","y":40,"vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"teleportExitId":"ladder_to1"},"y":20,"x":1010,"id":"ladder_from1","vertices":[{"x":0,"id":"v_1","y":0},{"x":10,"id":"v_2","y":0},{"x":10,"id":"v_3","y":10},{"x":0,"id":"v_4","y":10}]},{"angle":0,"customData":{"isLadder":true},"y":0,"x":0,"id":"ladder1","vertices":[{"x":1010,"id":"v_1","y":60},{"x":1020,"id":"v_2","y":60},{"x":1020,"id":"v_3","y":140},{"x":1010,"id":"v_4","y":140}]},{"angle":0,"x":0,"id":"instance222","y":0,"vertices":[{"x":100,"id":"v_1","y":10},{"x":140,"id":"v_2","y":10},{"x":140,"id":"v_3","y":-10},{"x":150,"id":"v_4","y":-10},{"x":150,"id":"v_5","y":20},{"x":100,"id":"v_6","y":20}]},{"angle":0,"x":0,"id":"instance210","y":0,"vertices":[{"x":1020,"id":"v_1","y":50},{"x":1210,"id":"v_2","y":50},{"x":1210,"id":"v_3","y":30},{"x":1220,"id":"v_4","y":30},{"x":1220,"id":"v_5","y":60},{"x":1160,"id":"v_6","y":60},{"x":1160,"id":"v_7","y":80},{"x":1150,"id":"v_8","y":80},{"x":1150,"id":"v_9","y":60},{"x":1020,"id":"v_10","y":60}]},{"angle":0,"x":0,"id":"instance195","y":0,"vertices":[{"x":720,"id":"v_1","y":80},{"x":720,"id":"v_2","y":-50},{"x":940,"id":"v_3","y":-110},{"x":1160,"id":"v_4","y":-50},{"x":1160,"id":"v_5","y":-20},{"x":1150,"id":"v_6","y":-20},{"x":1150,"id":"v_7","y":-40},{"x":730,"id":"v_8","y":-40},{"x":730,"id":"v_9","y":50},{"x":980,"id":"v_10","y":50},{"x":980,"id":"v_11","y":60},{"x":730,"id":"v_12","y":60},{"x":730,"id":"v_13","y":80}]},{"angle":0,"x":0,"id":"instance189","y":0,"vertices":[{"x":1060,"id":"v_1","y":160},{"x":1060,"id":"v_2","y":150},{"x":1160,"id":"v_3","y":150},{"x":1190,"id":"v_4","y":160}]},{"angle":0,"x":0,"id":"instance183","y":0,"vertices":[{"x":690,"id":"v_1","y":160},{"x":720,"id":"v_2","y":150},{"x":1020,"id":"v_3","y":150},{"x":1020,"id":"v_4","y":160}]},{"angle":0,"x":0,"id":"instance145","y":0,"vertices":[{"x":0,"id":"v_1","y":0},{"x":20,"id":"v_2","y":0},{"x":20,"id":"v_3","y":180},{"x":140,"id":"v_4","y":180},{"x":220,"id":"v_5","y":160},{"x":360,"id":"v_6","y":140},{"x":440,"id":"v_7","y":140},{"x":520,"id":"v_8","y":160},{"x":1020,"id":"v_9","y":160},{"x":1020,"id":"v_10","y":285},{"x":1015,"id":"v_11","y":295},{"x":1005,"id":"v_12","y":300},{"x":995,"id":"v_13","y":300},{"x":985,"id":"v_14","y":295},{"x":980,"id":"v_15","y":285},{"x":980,"id":"v_16","y":255},{"x":975,"id":"v_17","y":245},{"x":965,"id":"v_18","y":240},{"x":655,"id":"v_19","y":240},{"x":645,"id":"v_20","y":245},{"x":640,"id":"v_21","y":255},{"x":640,"id":"v_22","y":365},{"x":645,"id":"v_23","y":375},{"x":655,"id":"v_24","y":380},{"x":1045,"id":"v_25","y":380},{"x":1055,"id":"v_26","y":375},{"x":1060,"id":"v_27","y":365},{"x":1060,"id":"v_28","y":160},{"x":1240,"id":"v_29","y":160},{"x":1520,"id":"v_30","y":130},{"x":1700,"id":"v_31","y":140},{"x":1820,"id":"v_32","y":140},{"x":1820,"id":"v_33","y":0},{"x":1840,"id":"v_34","y":0},{"x":1840,"id":"v_35","y":400},{"x":0,"id":"v_36","y":400}]}],"x":0,"id":"ground","material":{"rollingFriction":0,"dynamicFriction":0,"staticFriction":0}}]}');

		}

		[After]
		public function tearDown():void
		{

		}

		/*[Test]
		public function testParse():void
		{
			var w:WorldDataVo = PhysicsVoFactory.parseWorld(worldJson);

			Assert.assertEquals(w.gravity.x, 0);
			Assert.assertEquals(w.gravity.y, 100);
			Assert.assertEquals(w.bodyDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].type, BodyDataVo.TYPE_DYNAMIC);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList.length, 3);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList.length, 1);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].x, 5);
			Assert.assertEquals(w.bodyDataList[0].shapeDataList[0].vertexDataList[0].y, 7);
		}*/

		[Ignore]
		[Test]
		public function testWithMapping():void
		{
			var factory:IAppFactory = new AppFactory();
			factory.mapToValue(IAppFactory, factory);

			var data:WorldDataVo = factory.getInstance(WorldDataVo, [worldJson]);
			var world:IWorldObject = factory.getInstance(IWorldObject, [data]);
		}
	}
}

import com.crazyfm.extensions.physics.BodyObject;
import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

internal class MyShapeDataVo extends ShapeDataVo
{
	public function MyShapeDataVo(json:Object)
	{
		super(json);
	}
}

internal class MyBodyObject extends BodyObject
{
	public function MyBodyObject(data:BodyDataVo)
	{
		super(data);
	}
}
