/**
 * Created by Anton Nefjodov on 7.06.2016.
 */
package com.crazyfm.core.factory
{
	import flash.utils.Dictionary;

	public class AppFactoryTest2
	{
		[Before]
		public function setUp():void
		{

		}

		[After]
		public function tearDown():void
		{

		}

		[Ignore]
		[Test]
		public function testPerformance():void
		{
			var factory:AppFactory = new AppFactory();
			factory.mapToValue(Array, []);
			factory.mapToValue(Dictionary, new Dictionary());
			factory.mapToValue(Object, {});

			for (var i:int = 0; i < 10000; i++)
			{
				factory.getInstance(DIObject);
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