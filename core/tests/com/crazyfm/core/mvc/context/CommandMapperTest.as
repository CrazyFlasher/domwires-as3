/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;
	import testObject.TestObj1;

	public class CommandMapperTest
	{
		private var commandMapper:ICommandMapper;

		private var factory:IAppFactory;

		[Before]
		public function setUp():void
		{
			factory = new AppFactory();
			factory.mapToValue(IAppFactory, factory);

			commandMapper = factory.getInstance(CommandMapper);
		}

		[After]
		public function tearDown():void
		{
			factory.dispose();
			commandMapper.clear();
		}

		[Test]
		public function testUnmap():void
		{
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.unmap(MyCoolEnum.BOGA, TestCommand);
			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
		}

		[Test]
		public function testClear():void
		{
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);

			commandMapper.clear();

			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.PREVED));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.SHALOM));
		}

		[Test]
		public function testDispose():void
		{
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);

			commandMapper.clear();

			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.PREVED));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.SHALOM));
		}

		[Test]
		public function testUnmapAll():void
		{
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.unmapAll(MyCoolEnum.BOGA);
			commandMapper.unmapAll(MyCoolEnum.PREVED);
			commandMapper.unmapAll(MyCoolEnum.SHALOM);

			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.PREVED));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.SHALOM));
		}

		[Test]
		public function testMap():void
		{
			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			assertTrue(commandMapper.hasMapping(MyCoolEnum.BOGA));
		}

		[Test]
		public function testTryToExecuteCommand():void
		{
			var m:TestObj1 = factory.getSingleton(TestObj1);
			factory.mapToValue(TestObj1, m);

			commandMapper.map(MyCoolEnum.PREVED, TestCommand);

			assertEquals(m.d, 0);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.PREVED));
			assertEquals(m.d, 7);
		}

		[Test]
		public function testManyEvents1Command():void
		{
			var m:TestObj1 = factory.getSingleton(TestObj1);
			factory.mapToValue(TestObj1, m);

			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.PREVED));
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.SHALOM));
			assertEquals(m.d, 21);

			commandMapper.unmap(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.PREVED));
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.SHALOM));
			assertEquals(m.d, 35);
		}

		[Test]
		public function testRemapModel():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);

			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));

			assertEquals(m.d, 7);

			factory.unmap(TestObj1);

			var m2:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m2);

			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));

			assertEquals(m2.d, 7);
		}
	}
}

import com.crazyfm.core.common.Enum;
import com.crazyfm.core.mvc.command.AbstractCommand;
import com.crazyfm.core.mvc.message.IMessage;

import testObject.TestObj1;

internal class TestCommand extends AbstractCommand
{
	[Autowired]
	public var obj:TestObj1;

	override public function execute():void
	{
		obj.d += 7;
	}
}

internal class MyMessage implements IMessage
{
	internal var _type:Enum;
	internal var _data:Object;
	internal var _bubbles:Boolean;
	internal var _target:Object;
	internal var _currentTarget:Object;

	public function MyMessage(type:Enum, data:Object = null, bubbles:Boolean = true)
	{
		_type = type;
		_data = data;
		_bubbles = bubbles;
	}

	public function get type():Enum
	{
		return _type;
	}

	public function get data():Object
	{
		return _data;
	}

	public function get bubbles():Boolean
	{
		return _bubbles;
	}

	public function get target():Object
	{
		return _target;
	}

	public function get currentTarget():Object
	{
		return _currentTarget;
	}
}