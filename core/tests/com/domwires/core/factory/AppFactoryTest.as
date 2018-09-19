/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.domwires.core.factory
{
	import flash.media.Camera;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.BusyPoolObject;

	import testObject.IMyPool;
	import testObject.MyPool;

	public class AppFactoryTest
	{
		private var factory:IAppFactory;

		[Before]
		public function setUp():void
		{
			factory = new AppFactory();
			factory.verbose = true;
		}

		[After]
		public function tearDown():void
		{
			factory.clear();
		}

		[Test(expects="Error")]
		public function testUnmapClass():void
		{
			factory.mapToType(IMyType, MyType1);
			var o:IMyType = factory.getInstance(IMyType, [5, 7]) as IMyType;
			factory.unmapType(IMyType);
			var o2:IMyType = factory.getInstance(IMyType, [5, 7]) as IMyType;
		}

		[Test(expects="Error")]
		public function testUnmapInstance():void
		{
			var instance:IMyType = new MyType1(5, 7);
			factory.mapToValue(IMyType, o);

			var o:IMyType = factory.getInstance(IMyType) as IMyType;
			assertEquals(o, instance);

			factory.unmapType(IMyType);
			var o2:IMyType = factory.getInstance(IMyType) as IMyType;
		}

		[Test]
		public function testGetNewInstance():void
		{
			factory.mapToType(IMyType, MyType1);
			factory.mapToValue(Class, MyType1);
			var o:IMyType = factory.getInstance(IMyType, [5, 7]) as IMyType;
			assertEquals(o.a, 5);
			assertEquals(o.b, 7);
		}

		[Test]
		public function testGetFromPool():void
		{
			factory.mapToType(IMyType, MyType2);
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
		public function testMapClass():void
		{
			assertFalse(factory.hasTypeMappingForType(IMyType));
			factory.mapToType(IMyType, MyType2);
			assertTrue(factory.hasTypeMappingForType(IMyType));
		}

		[Test]
		public function testMapInstance():void
		{
			var o:IMyType = new MyType2();
			assertFalse(factory.hasValueMappingForType(IMyType));
			factory.mapToValue(IMyType, o);
			assertTrue(factory.hasValueMappingForType(IMyType));
			assertEquals(o, factory.getInstance(IMyType));
		}

		[Test]
		public function testRegisterPool():void
		{
			assertFalse(factory.hasPoolForType(IMyType));
			factory.registerPool(IMyType);
			assertTrue(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function testClear():void
		{
			factory.mapToType(IMyType, MyType2);
			factory.registerPool(IMyType);
			factory.clear();
			assertFalse(factory.hasTypeMappingForType(IMyType));
			assertFalse(factory.hasPoolForType(IMyType));
		}

		[Test]
		public function testAutowiredAutoInject():void
		{
			var factory:AppFactory = new AppFactory();
			factory.mapToValue(Camera, new Camera());
			factory.mapToValue(Array, []);
			factory.mapToValue(Object, {});

			var obj:DIObject = factory.getInstance(DIObject);
			assertNotNull(obj.c);
			assertNotNull(obj.arr);
			assertNotNull(obj.obj);
		}

		[Test]
		public function testAutowiredManualInject():void
		{
			var factory:AppFactory = new AppFactory();
			factory.mapToValue(Camera, new Camera());
			factory.mapToValue(Array, []);
			factory.mapToValue(Object, {});

			factory.autoInjectDependencies = false;

			var obj:DIObject = factory.getInstance(DIObject);
			assertNull(obj.c);
			factory.injectDependencies(obj);
			assertNotNull(obj.c);
			assertNotNull(obj.arr);
			assertNotNull(obj.obj);
		}

		[Test]
		public function testAutowiredAutoInjectPostConstruct():void
		{
			var factory:AppFactory = new AppFactory();
			factory.mapToValue(Camera, new Camera());
			factory.mapToValue(Array, []);
			factory.mapToValue(Object, {});

			var obj:DIObject = factory.getInstance(DIObject);

			assertNotNull(obj.c);
			assertNotNull(obj.arr);
			assertNotNull(obj.obj);
			assertEquals(obj.message, "OK!");
		}

		[Test]
		public function testHasMappingForType():void
		{
			assertFalse(factory.hasTypeMappingForType(IMyType));
			factory.mapToType(IMyType, MyType1);
			assertTrue(factory.hasTypeMappingForType(IMyType));
		}

		[Test]
		public function testGetInstanceByName():void
		{
			var i:int = 1;
			factory.mapToValue(int, i, "olo");
			var result:int = factory.getInstance(int, null, "olo");
			assertEquals(result, 1);
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

		[Test]
		public function testMapDefaultImplementation_yes():void
		{
			var factory:IAppFactory = new AppFactory();
			var d:IDefault = factory.getInstance(IDefault);
			assertEquals(d.result, 123);
		}

		[Test(expects="Error")]
		public function testMapDefaultImplementation_no():void
		{
			var factory:IAppFactory = new AppFactory();
			var d:IDefault2 = factory.getInstance(IDefault2);
			assertEquals(d.result, 123);
		}

		[Test]
		public function testClassToClassValue():void
		{
			factory.mapToType(IMyType, MyType1);
			factory.mapToValue(Class, MyType1);
			var o:IMyType = factory.getInstance(IMyType, [5, 7]) as IMyType;
			assertEquals(o.a, 5);
			assertEquals(o.b, 7);
			assertFalse(o.clazz is MyType1);
		}

		[Test]
		public function testMappingToName():void
		{
			var arr1:Array = [1,2,3];
			var arr2:Array = [4,5,6];

			factory.mapToValue(Array, arr1, "shachlo");
			factory.mapToValue(Array, arr2, "olo");

			var myObj:MySuperCoolObj = factory.getInstance(MySuperCoolObj) as MySuperCoolObj;

			assertEquals(myObj.arr1, arr2);
			assertEquals(myObj.arr2, arr1);
		}

		[Test(expects="Error")]
		public function testUnMappingFromName():void
		{
			var arr1:Array = [1,2,3];
			var arr2:Array = [4,5,6];

			factory.mapToValue(Array, arr1, "shachlo");
			factory.mapToValue(Array, arr2, "olo");

			var myObj:MySuperCoolObj = factory.getInstance(MySuperCoolObj) as MySuperCoolObj;

			assertEquals(myObj.arr1, arr2);
			assertEquals(myObj.arr2, arr1);

			factory.unmapValue(Array, "shachlo");

			factory.getInstance(MySuperCoolObj);
		}

		[Test]
		public function testBooleanMapping():void
		{
			factory.mapToValue(Boolean, true);

			var value:Boolean = factory.getInstance(Boolean);
			assertTrue(value);

			factory.mapToValue(Boolean, false);

			value = factory.getInstance(Boolean);
			assertFalse(value);
		}

		[Test]
		public function testBooleanMapping2():void
		{
			var condition:Boolean;

			factory.mapToValue(Boolean, condition, "popa");

			var myObj:MySuperCoolObj2 = factory.getInstance(MySuperCoolObj2) as MySuperCoolObj2;
			assertEquals(myObj.b, false);

			condition = true;

			factory.mapToValue(Boolean, condition, "popa");
			
			var myObj2:MySuperCoolObj2 = factory.getInstance(MySuperCoolObj2) as MySuperCoolObj2;
			assertEquals(myObj2.b, true);
		}

		[Test]
		public function testOptionalInjection():void
		{
			factory.mapToValue(Number, 1);

			var obj:MyOptional = factory.getInstance(MyOptional);

			assertFalse(obj.b);
			assertNull(obj.siski);
			assertEquals(obj.n, 1);
		}

		[Test]
		public function testSingleConstructorArg():void
		{
			var obj:MyType3 = factory.getInstance(MyType3, 7);
			assertEquals(obj.a, 7);
		}

		[Test]
		public function testPostConstruct():void
		{
			var o:PCTestObj = factory.getInstance(PCTestObj);
			assertEquals(o.t, 1);

			factory.injectDependencies(o);
			assertEquals(o.t, 1);
		}

		[Test]
		public function testPostInject():void
		{
			var o:PITestObj = factory.getInstance(PITestObj);
			assertEquals(o.t, 1);

			factory.injectDependencies(o);
			factory.injectDependencies(o);
			assertEquals(o.t, 3);
		}

		[Test]
		public function testMappingViaConfig():void
		{
			SuperCoolModel;
			Default;

			var json:Object =
			{
				"com.domwires.core.factory.IDefault$def": {
					implementation: "com.domwires.core.factory.Default",
					newInstance:true
				},
				"com.domwires.core.factory.ISuperCoolModel": {
					implementation: "com.domwires.core.factory.SuperCoolModel"
				},
				"int$coolValue": {
					value:7
				},
				"Boolean$myBool": {
					value: false
				},
				"int": {
					value:5
				},
				"Object$obj": {
					value:{
						firstName:"nikita",
						lastName:"dzigurda"
					}
				},
				"Array": {
					value:["botan","sjava"]
				}
			};

			var config:MappingConfigDictionary = new MappingConfigDictionary(json);

			factory.appendMappingConfig(config);
			var m:ISuperCoolModel = factory.getInstance(ISuperCoolModel);
			assertEquals(m.getCoolValue(), 7);
			assertEquals(m.getMyBool(), false);
			assertEquals(m.value, 5);
			assertEquals(m.def.result, 123);
			assertEquals(m.object.firstName, "nikita");
			assertEquals(m.array[1], "sjava");
		}

		[Test]
		public function testMapPoolToInterface():void
		{
			factory.mapToType(IPool, Pool1);
			factory.registerPool(IPool);

			var p:IPool = factory.getInstance(IPool);
			assertEquals(p.value, 1);

			factory.mapToType(IPool, Pool2);
			factory.registerPool(IPool);

			var p2:IPool = factory.getInstance(IPool);
			assertEquals(p2.value, 2);
		}

		[Test]
		public function testMapSingletonToInterface():void
		{
			factory.mapToType(IPool, Pool1);
			var p1:IPool = factory.getSingleton(IPool);
			assertEquals(p1.value, 1);
		}

		[Test]
		public function testFromPoolWithConstructorArgs():void
		{
			factory.mapToType(IPool2, Pool3);
			factory.registerPool(IPool2);
			var p1:IPool2 = factory.getInstance(IPool2, ["olo", 1.5]);
			assertEquals(p1.s,  "olo");
			assertEquals(p1.n,  1.5);
		}

		[Test]
		public function testInjectDependenciesToPoolObject():void
		{
			factory.mapToType(IPool, Pool4);
			factory.registerPool(IPool);
			factory.mapToValue(int, 5, "v");
			var p1:IPool = factory.getInstance(IPool);
			assertEquals(p1.value,  6);
		}

		[Test]
		public function testGetInstanceFromNotFullPool():void
		{
			factory.mapToType(IPool2, Pool3);
			factory.registerPool(IPool2, 100);

			var instance:IPool2 = factory.getInstance(IPool2, ["olo", 1.5]);
			var instance2:IPool2 = factory.getInstanceFromPool(IPool2);

			assertEquals(instance, instance2);
		}

		[Test]
		public function testGetPoolCapacity():void
		{
			factory.registerPool(IPool2, 100);

			var capacity:int = factory.getPoolCapacity(IPool2);

			assertEquals(capacity, 100);
		}

		[Test]
		public function testGetPoolTotalInstancesCount():void
		{
			factory.mapToType(IPool2, Pool3);
			factory.registerPool(IPool2, 100);

			for (var i:int = 0; i < 5; i++)
			{
				factory.getInstance(IPool2, ["olo", 1.5]);
			}

			var count:int = factory.getPoolInstanceCount(IPool2);

			assertEquals(count, 5);
		}

		[Test]
		public function testExtendPool():void
		{
			factory.registerPool(IPool2, 100);
			factory.increasePoolCapacity(IPool2, 5);

			var capacity:int = factory.getPoolCapacity(IPool2);

			assertEquals(capacity, 105);
		}

		[Test]
		public function testGetInstanceFromPool():void
		{
			factory.mapToType(IPool2, Pool3);
			factory.registerPool(IPool2, 10);

			var instance_1:IPool2 = factory.getInstance(IPool2, ["olo", 1.5]);
			var instance_2:IPool2 = factory.getInstance(IPool2, ["olo", 1.5]);

			var instanceFromPool:IPool2;
			instanceFromPool = factory.getInstanceFromPool(IPool2);
			assertEquals(instanceFromPool, instance_1);

			instanceFromPool = factory.getInstanceFromPool(IPool2);
			assertEquals(instanceFromPool, instance_2);

			instanceFromPool = factory.getInstanceFromPool(IPool2);
			assertEquals(instanceFromPool, instance_1);
		}

		[Test]
		public function testOfPoolObjectsAreUnique():void
		{
			factory.registerPool(IMyPool, 2, true);

			var o1:IMyPool = factory.getInstance(IMyPool);
			var o2:IMyPool = factory.getInstance(IMyPool);

			assertFalse(o1 == o2);
		}

		[Test]
		public function testReturnOnlyNotBusyObjectsFromPool():void
		{
			factory.registerPool(BusyPoolObject, 2, true, null, "isBusy");

			var o1:BusyPoolObject = factory.getInstance(BusyPoolObject);
			o1.isBusy = true;

			factory.getInstance(BusyPoolObject);

			var o2:BusyPoolObject = factory.getInstance(BusyPoolObject);
			assertFalse(o2.isBusy);
			assertFalse(o1 == o2);
		}

		[Test]
		public function testAllPoolItemAreBusy():void
		{
			factory.registerPool(BusyPoolObject, 2, true, null, "isBusy");

			assertFalse(factory.getAllPoolItemsAreBusy(BusyPoolObject));

			var o1:BusyPoolObject = factory.getInstance(BusyPoolObject);
			o1.isBusy = true;

			assertFalse(factory.getAllPoolItemsAreBusy(BusyPoolObject));

			var o2:BusyPoolObject = factory.getInstance(BusyPoolObject);
			o2.isBusy = true;

			assertTrue(factory.getAllPoolItemsAreBusy(BusyPoolObject));

			factory.increasePoolCapacity(BusyPoolObject, 1);

			assertFalse(factory.getAllPoolItemsAreBusy(BusyPoolObject));

			var o3:BusyPoolObject = factory.getInstance(BusyPoolObject);
			o3.isBusy = true;

			assertTrue(factory.getAllPoolItemsAreBusy(BusyPoolObject));
		}
	}
}

internal interface IPool
{
	function get value():int;
}

internal interface IPool2 extends IPool
{
	function get s():String;
	function get n():Number;
}

internal class Pool1 implements IPool {

	public function get value():int
	{
		return 1;
	}
}

internal class Pool2 implements IPool {

	public function get value():int
	{
		return 2;
	}
}

internal class Pool3 implements IPool2 {

	private var _s:String;
	private var _n:Number;

	public function Pool3(s:String, n:Number)
	{
		this._s = s;
		this._n = n;
	}

	public function get value():int
	{
		return 2;
	}

	public function get s():String
	{
		return _s;
	}

	public function get n():Number
	{
		return _n;
	}
}

internal class Pool4 implements IPool {

	[Autowired(name="v")]
	public var v:int;

	[PostConstruct]
	public function pc():void
	{
		v++;
	}

	public function get value():int
	{
		return v;
	}
}

import flash.media.Camera;

internal class PITestObj
{
	private var _t:int;

	[PostInject]
	public function pi():void
	{
		_t += 1;
	}

	public function get t():int
	{
		return _t;
	}
}

internal class PCTestObj
{
	private var _t:int;

	[PostConstruct]
	public function pc():void
	{
		_t += 1;
	}

	public function get t():int
	{
		return _t;
	}
}

internal class MyOptional
{
	[Autowired(name="popa", optional="true")]
	public var b:Boolean;

	[Autowired]
	public var n:Number;

	[Autowired(optional="true")]
	public var siski:Camera;

	public function MyOptional()
	{

	}
}

internal class MySuperCoolObj2
{
	[Autowired(name="popa")]
	public var b:Boolean;

	public function MySuperCoolObj2()
	{

	}
}

internal class MySuperCoolObj
{
	[Autowired(name="olo")]
	public var arr1:Array;

	[Autowired(name="shachlo")]
	public var arr2:Array;

	public function MySuperCoolObj()
	{

	}
}

internal class DIObject
{
	[Autowired]
	public var c:Camera;

	[Autowired]
	public var arr:Array;

	[Autowired]
	public var obj:Object;

	private var _message:String;

	public function DIObject()
	{

	}

	[PostConstruct]
	public function init():void
	{
		_message = "OK!";
	}

	public function get message():String
	{
		return _message;
	}
}

internal class MyType1 implements IMyType
{
	private var _a:int;
	private var _b:int;

	[Autowired]
	public var _clazz:Class;

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

	public function get clazz():Class
	{
		return _clazz;
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

	public function get clazz():Class
	{
		return null;
	}
}

internal class MyType3
{
	private var _a:int;

	public function MyType3(a:int)
	{
		_a = a;
	}

	public function get a():int
	{
		return _a;
	}
}

internal interface IMyType
{
	function get a():int;
	function get b():int;
	function get clazz():Class;
}
