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
			var m:TestObj1 = factory.getSingleton(TestObj1) as TestObj1;
			factory.mapToValue(TestObj1, m);

			commandMapper.map(MyCoolEnum.PREVED, TestCommand);

			assertEquals(m.d, 0);
			commandMapper.tryToExecuteCommand(MyCoolEnum.PREVED);
			assertEquals(m.d, 7);
		}

		[Test]
		public function testManyEvents1Command():void
		{
			var m:TestObj1 = factory.getSingleton(TestObj1) as TestObj1;
			factory.mapToValue(TestObj1, m);

			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.tryToExecuteCommand(MyCoolEnum.BOGA);
			commandMapper.tryToExecuteCommand(MyCoolEnum.PREVED);
			commandMapper.tryToExecuteCommand(MyCoolEnum.SHALOM);
			assertEquals(m.d, 21);

			commandMapper.unmap(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.tryToExecuteCommand(MyCoolEnum.BOGA);
			commandMapper.tryToExecuteCommand(MyCoolEnum.PREVED);
			commandMapper.tryToExecuteCommand(MyCoolEnum.SHALOM);
			assertEquals(m.d, 35);
		}
	}
}

import com.crazyfm.core.mvc.command.AbstractCommand;

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