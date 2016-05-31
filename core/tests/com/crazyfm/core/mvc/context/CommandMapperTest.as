/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.ns_app_factory;
	import com.crazyfm.core.factory.AppFactory;

	import org.flexunit.asserts.assertEquals;

	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;
	import testObject.TestObj1;

	use namespace ns_app_factory;

	public class CommandMapperTest
	{
		private var commandMapper:ICommandMapper;

		[Before]
		public function setUp():void
		{
			commandMapper = new CommandMapper(AppFactory.getSingletonInstance());
		}

		[After]
		public function tearDown():void
		{
			AppFactory.getSingletonInstance().clear();
			commandMapper.dispose();
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

			commandMapper.dispose();

			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.PREVED));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.SHALOM));

			assertTrue(commandMapper.isDisposed);
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
			var m:TestObj1 = AppFactory.getSingletonInstance().getSingleton(TestObj1) as TestObj1;
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);

			assertEquals(m.d, 0);
			commandMapper.dispatchSignal(MyCoolEnum.PREVED);
			assertEquals(m.d, 7);
		}

		[Test]
		public function testManyEvents1Command():void
		{
			var m:TestObj1 = AppFactory.getSingletonInstance().getSingleton(TestObj1) as TestObj1;
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.map(MyCoolEnum.PREVED, TestCommand);
			commandMapper.map(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.dispatchSignal(MyCoolEnum.BOGA);
			commandMapper.dispatchSignal(MyCoolEnum.PREVED);
			commandMapper.dispatchSignal(MyCoolEnum.SHALOM);
			assertEquals(m.d, 21);
			commandMapper.unmap(MyCoolEnum.SHALOM, TestCommand);
			commandMapper.dispatchSignal(MyCoolEnum.BOGA);
			commandMapper.dispatchSignal(MyCoolEnum.PREVED);
			commandMapper.dispatchSignal(MyCoolEnum.SHALOM);
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