/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.core.common
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	use namespace ns_app_factory;

	public class AppFactoryTest
	{
		[Before]
		public function setUp():void
		{

		}

		[After]
		public function tearDown():void
		{
			AppFactory.clear();
		}

		[Test(expects="Error")]
		public function testUnmap():void
		{
			AppFactory.map(IMyType, MyType1);
			var o:IMyType = AppFactory.getNewInstance(IMyType, 5, 7) as IMyType;
			AppFactory.unmap(IMyType);
			var o2:IMyType = AppFactory.getNewInstance(IMyType, 5, 7) as IMyType;
		}

		[Test]
		public function testGetNewInstance():void
		{
			AppFactory.map(IMyType, MyType1);
			var o:IMyType = AppFactory.getNewInstance(IMyType, 5, 7) as IMyType;
			assertEquals(o.a, 5);
			assertEquals(o.b, 7);
		}

		[Test(expects="Error")]
		public function testGetFromPoolNoRegister():void
		{
			AppFactory.getFromPool(IMyType);
		}

		[Test]
		public function testGetFromPool():void
		{
			AppFactory.map(IMyType, MyType2);
			AppFactory.registerPool(IMyType);
			var o:IMyType = AppFactory.getFromPool(IMyType);
			assertEquals(o.a, 500);
			assertEquals(o.b, 700);
		}

		[Test]
		public function testUnregisterPool():void
		{
			AppFactory.registerPool(IMyType);
			assertTrue(AppFactory.hasPoolForType(IMyType));
			AppFactory.unregisterPool(IMyType);
			assertFalse(AppFactory.hasPoolForType(IMyType));
		}

		[Test]
		public function testMap():void
		{
			assertFalse(AppFactory.hasMappingForType(IMyType));
			AppFactory.map(IMyType, MyType2);
			assertTrue(AppFactory.hasMappingForType(IMyType));
		}

		[Test]
		public function testRegisterPool():void
		{
			assertFalse(AppFactory.hasPoolForType(IMyType));
			AppFactory.registerPool(IMyType);
			assertTrue(AppFactory.hasPoolForType(IMyType));
		}

		[Test]
		public function clear():void
		{
			AppFactory.map(IMyType, MyType2);
			AppFactory.registerPool(IMyType);
			AppFactory.clear();
			assertFalse(AppFactory.hasMappingForType(IMyType));
			assertFalse(AppFactory.hasPoolForType(IMyType));
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
