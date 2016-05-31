/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.factory
{
	import com.crazyfm.core.common.*;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	use namespace ns_app_factory;

	public class AppFactoryTest
	{
		private var factory:AppFactory;

		[Before]
		public function setUp():void
		{
			factory = AppFactory.getSingletonInstance();
		}

		[After]
		public function tearDown():void
		{
			factory.clear();
		}

		[Test(expects="Error")]
		public function testUnmap():void
		{
			factory.map(IMyType, MyType1);
			var o:IMyType = factory.getInstance(IMyType, 5, 7) as IMyType;
			factory.unmap(IMyType);
			var o2:IMyType = factory.getInstance(IMyType, 5, 7) as IMyType;
		}

		[Test]
		public function testGetNewInstance():void
		{
			factory.map(IMyType, MyType1);
			var o:IMyType = factory.getInstance(IMyType, 5, 7) as IMyType;
			assertEquals(o.a, 5);
			assertEquals(o.b, 7);
		}

		[Test]
		public function testGetFromPool():void
		{
			factory.map(IMyType, MyType2);
			factory.registerPool(IMyType);
			var o:IMyType = factory.getInstance(IMyType);
			assertEquals(o.a, 500);
			assertEquals(o.b, 700);
		}

		[Test]
		public function testUnregisterPool():void
		{
			factory.registerPool(IMyType);
			assertTrue(factory.hasPoolForType(IMyType));
			factory.unregisterPool(IMyType);
			assertFalse(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function testMap():void
		{
			assertFalse(factory.hasMappingForType(IMyType));
			factory.map(IMyType, MyType2);
			assertTrue(factory.hasMappingForType(IMyType));
		}

		[Test]
		public function testRegisterPool():void
		{
			assertFalse(factory.hasPoolForType(IMyType));
			factory.registerPool(IMyType);
			assertTrue(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function clear():void
		{
			factory.map(IMyType, MyType2);
			factory.registerPool(IMyType);
			factory.clear();
			assertFalse(factory.hasMappingForType(IMyType));
			assertFalse(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function testDI():void
		{
			var obj:DIObject = factory.getInstance(DIObject);
			assertNull(obj.c);
			factory.injectDependencies(obj);
			assertNotNull(obj.c);
			assertNotNull(obj.arr);
			assertNotNull(obj.obj);
		}

		[Test]
		public function testHasMappingForType():void
		{
			assertFalse(factory.hasMappingForType(IMyType));
			factory.map(IMyType, MyType1);
			assertTrue(factory.hasMappingForType(IMyType));
		}

		[Test]
		public function testGetInstance():void
		{

		}

		[Test]
		public function testHasPoolForType():void
		{
			assertFalse(factory.hasPoolForType(IMyType));
			factory.registerPool(IMyType);
			assertTrue(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function testGetSingleton():void
		{
			var obj:MyType2 = factory.getSingleton(MyType2) as MyType2;
			var obj2:MyType2 = factory.getSingleton(MyType2) as MyType2;
			var obj3:MyType2 = factory.getSingleton(MyType2) as MyType2;

			assertEquals(obj, obj2, obj3);
		}

		[Test]
		public function testRemoveSingleton():void
		{
			var obj:MyType2 = factory.getSingleton(MyType2) as MyType2;
			var obj2:MyType2 = factory.getInstance(MyType2) as MyType2;

			assertTrue(obj == obj2);

			factory.removeSingleton(MyType2);

			obj2 = factory.getInstance(MyType2) as MyType2;

			assertFalse(obj == obj2);
		}
	}
}

import flash.media.Camera;

internal class DIObject
{
	[Autowired]
	public var c:Camera;

	[Autowired]
	public var arr:Array;

	[Autowired]
	public var obj:Object;

	public function DIObject()
	{

	}
}

internal class MyType1 implements IMyType
{
	private var _a:int;
	private var _b:int;

	public function MyType1(a:int, b:int)
	{
		_a = a;
		_b = b;
	}

	public function get a():int
	{
		return _a;
	}

	public function get b():int
	{
		return _b;
	}
}

internal class MyType2 implements IMyType
{
	public function MyType2()
	{
	}

	public function get a():int
	{
		return 500;
	}

	public function get b():int
	{
		return 700;
	}
}

internal interface IMyType
{
	function get a():int;
	function get b():int;
}
