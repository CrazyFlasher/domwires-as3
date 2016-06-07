/**
 * Created by Anton Nefjodov on 7.06.2016.
 */
package com.crazyfm.core.factory
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	public class AppFactoryTest2
	{
		public function AppFactoryTest2()
		{
		}

		[Before]
		public function setUp():void
		{

		}

		[After]
		public function tearDown():void
		{

		}

		[Test]
		public function testPerformance():void
		{
			var factory:AppFactory = new AppFactory(true);

			for (var i:int = 0; i < 1000; i++)
			{
				var obj:DIObject = factory.getInstance(DIObject);
				/*assertNotNull(obj.c);
				assertNotNull(obj.arr);
				assertNotNull(obj.obj);
				assertEquals(obj.message, "OK!");*/
			}
		}
	}
}

import flash.utils.Dictionary;

internal class DIObject
{
	[Autowired]
	public var c:Dictionary;

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