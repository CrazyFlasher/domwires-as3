/**
 * Created by Anton Nefjodov on 30.05.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.factory.AppFactory;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.command.AbstractCommand;
	import com.domwires.core.mvc.command.CommandMapper;
	import com.domwires.core.mvc.command.ICommandMapper;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	import testObject.MyCoolEnum;
	import testObject.TestObj1;
	import testObject.TestVo;

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

			factory.unmapValue(TestObj1);

			var m2:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m2);

			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));

			assertEquals(m2.d, 7);
		}

		[Test]
		public function testInjectMessageData():void
		{
			commandMapper.map(MyCoolEnum.BOGA, TestCommand2);

			var vo:TestVo = new TestVo();
			var itemId:String = "puk";
			
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA, {vo:vo, itemId:itemId}));

			assertEquals(vo.age, 11);
			assertEquals(vo.name, "Izja");
			assertEquals(vo.str, "puk");
		}

		[Test]
		public function testMapOnce():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand, null, true);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			assertFalse(commandMapper.hasMapping(MyCoolEnum.BOGA));
		}

		[Test]
		public function testMapWithData():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand3, {olo: 5});
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			assertEquals(m.d, 5);
		}

		[Test]
		public function testMessageDataOverridesMappedData():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand3, {olo: 5});
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA, {olo: 4}));
			assertEquals(m.d, 4);
		}

		[Test]
		public function testCoolGuards():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand3, {olo: 5}).addGuards(CoolGuards);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA, {olo: 4}));
			assertEquals(m.d, 4);
		}

		[Test]
		public function testNotCoolGuards():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand3, {olo: 5}).addGuards(NotCoolGuards);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA, {olo: 4}));
			assertEquals(m.d, 0);
		}

		[Test]
		public function testInjectMessageDataToGuards():void
		{
			commandMapper.map(MyCoolEnum.BOGA, AbstractCommand).addGuards(NiceGuards);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA, {olo: 4}));
		}

		[Test]
		public function testMapWithDataUnmaps():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			commandMapper.executeCommand(TestCommand4, {olo: "puk"});
			assertEquals(m.s, "puk");
			commandMapper.executeCommand(TestCommand4);
			assertNull(m.s);
		}

		[Test]
		public function testExecuteWithVoAsData():void
		{
			//Expecting no errors
			var vo:MyVo = new MyVo();
			vo.olo = "test";
			commandMapper.executeCommand(VoTestCommand, vo);
		}

		[Test]
		public function testExecuteWithVoGettersAsData():void
		{
			//Expecting no errors
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			var vo:MyVo2 = new MyVo2();
			vo._olo = "test";
			commandMapper.executeCommand(VoTestCommand, vo);
			assertEquals(m.s, "test");
		}

		[Test]
		public function testStopOnExecute():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			factory.mapToValue(String, "test", "olo");
			commandMapper.map(MyCoolEnum.BOGA, TestCommand4, null, false, true);
			commandMapper.map(MyCoolEnum.BOGA, TestCommand);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			assertEquals(m.d, 0);
		}

		[Test]
		public function testStopOnExecuteWithBatchMapping():void
		{
			var m:TestObj1 = factory.getInstance(TestObj1);
			factory.mapToValue(TestObj1, m);
			factory.mapToValue(String, "test", "olo");
			commandMapper.map1(MyCoolEnum.BOGA, new <Class>[TestCommand4, TestCommand], null, false, true);
			commandMapper.tryToExecuteCommand(new MyMessage(MyCoolEnum.BOGA));
			assertEquals(m.d, 7);
		}
	}
}

import com.domwires.core.common.Enum;
import com.domwires.core.mvc.command.AbstractCommand;
import com.domwires.core.mvc.command.IGuards;
import com.domwires.core.mvc.message.IMessage;

import testObject.TestObj1;
import testObject.TestVo;


internal dynamic class MyVo2
{
	internal var _olo:String;

	public function get olo():String
	{
		return _olo;
	}
}

internal dynamic class MyVo
{
	public var olo:String;
}

internal class VoTestCommand extends AbstractCommand
{
	[Autowired(name="olo")]
	public var olo:String;

	[Autowired(optional="true")]
	public var obj:TestObj1;

	override public function execute():void
	{
		super.execute();

		if (obj) obj.s = olo;
	}
}

////////////////////////////////////
internal class NiceGuards implements IGuards
{
	[Autowired(name="olo")]
	public var olo:int;

	public function get allows():Boolean
	{
		return this;
	}
}

////////////////////////////////////
internal class NotCoolGuards implements IGuards
{
	public function get allows():Boolean
	{
		return false;
	}
}
internal class CoolGuards implements IGuards
{
	public function get allows():Boolean
	{
		return true;
	}
}
/////////////////////////////////////
internal class TestCommand4 extends AbstractCommand
{
	[Autowired]
	public var obj:TestObj1;

	[Autowired(name="olo", optional="true")]
	public var olo:String;

	override public function execute():void
	{
		obj.s = olo;
	}
}

internal class TestCommand3 extends AbstractCommand
{
	[Autowired]
	public var obj:TestObj1;

	[Autowired(name="olo")]
	public var olo:int;

	override public function execute():void
	{
		obj.d += olo;
	}
}

internal class TestCommand extends AbstractCommand
{
	[Autowired]
	public var obj:TestObj1;

	override public function execute():void
	{
		obj.d += 7;
	}
}

internal class TestCommand2 extends AbstractCommand
{
	[Autowired(name="itemId")]
	public var itemId:String;

	[Autowired(name="vo")]
	public var vo:TestVo;

	override public function execute():void
	{
		vo.age = 11;
		vo.name = "Izja";
		vo.str = itemId;
	}
}

internal class MyMessage implements IMessage
{
	internal var _type:Enum;
	internal var _data:Object;
	internal var _bubbles:Boolean;
	internal var _target:Object;
	internal var _previousTarget:Object;

	private var _currentTarget:Object;

	public function MyMessage(type:Enum, data:Object = null, bubbles:Boolean = true)
	{
		_type = type;
		_data = data;
		_bubbles = bubbles;
	}

	internal function setCurrentTarget(value:Object):Object
	{
		_previousTarget = _currentTarget;

		_currentTarget = value;

		return _currentTarget;
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

	public function get previousTarget():Object
	{
		return _previousTarget;
	}
}