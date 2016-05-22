/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.common
{
	import com.crazyfm.core.factory.AppFactory;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
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
