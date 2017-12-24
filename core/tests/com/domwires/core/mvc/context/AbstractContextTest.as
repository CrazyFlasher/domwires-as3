/**
 * Created by CrazyFlasher on 3.10.2016.
 */
package com.domwires.core.mvc.context
{
	import com.domwires.core.factory.AppFactory;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.mvc.context.config.ContextConfigVoBuilder;
	import com.domwires.core.mvc.model.AbstractModel;
	import com.domwires.core.mvc.view.AbstractView;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;

	public class AbstractContextTest
	{
		private var f:IAppFactory;

		private var c:IContext;

		[Before]
		public function setUp():void
		{
			f = new AppFactory();
			f.mapToType(IContext, AbstractContext);
			f.mapToValue(IAppFactory, f);

			var cb:ContextConfigVoBuilder = new ContextConfigVoBuilder();
			cb.forwardMessageFromViewsToModels = true;

			c = f.getInstance(IContext, cb.build());
			c.addModel(new AbstractModel());
			c.addView(new AbstractView());
		}

		[After]
		public function tearDown():void
		{
			if (!c.isDisposed)
			{
				c.disposeWithAllChildren();
			}
		}

		[Test]
		public function testDisposeWithAllChildren():void
		{
			c.disposeWithAllChildren();

			assertTrue(c.isDisposed);
		}

		[Test]
		public function testExecuteCommandFromBubbledMessage():void
		{
			var c1:TestContext1 = f.getInstance(TestContext1);
			var c2:TestContext2 = f.getInstance(TestContext2);
			c.addModel(c1);
			c.addModel(c2);

			c2.ready();

			assertEquals(c1.getTestModel().testVar, 1);
		}

		[Test]
		public function testBubbledMessageNotRedirectedToContextItCameFrom():void
		{
			var c1:TestContext1 = f.getInstance(TestContext1);
			var c2:TestContext2 = f.getInstance(TestContext2);
			c.addModel(c1);
			c.addModel(c2);

			c2.ready();

			assertEquals(c2.getTestModel().testVar, 1);
		}

		[Test]
		public function testReceivingExternalEvents():void
		{
			var c:ParentContext = f.getInstance(ParentContext);
			assertEquals(c.getTestModel().testVar, 1);
		}

		[Test]
		public function testViewMessageBubbledOnceForChildContext():void
		{
			TestView2.VAL = 0;
			var c:ParentContext2 = f.getInstance(ParentContext2);
			assertEquals(c.getModel().testVar, 1);
			assertEquals(TestView2.VAL, 1);
		}

		[Test]
		public function testMapToInterface():void
		{
			var f:IAppFactory = new AppFactory();
			f.mapToValue(IAppFactory, f);
			f.mapToValue(Class, TestCommand);
			var c:TestContext3 = f.getInstance(TestContext3);
			c.ready();
			assertEquals(c.getTestModel().testVar, 1);


			f.mapToValue(Class, TestCommand3);
			var c2:TestContext3 = f.getInstance(TestContext3);
			c2.ready();
			assertEquals(c.getTestModel().testVar, 2);
		}
	}
}

import com.domwires.core.mvc.command.AbstractCommand;
import com.domwires.core.mvc.context.AbstractContext;
import com.domwires.core.mvc.context.ITestCommand;
import com.domwires.core.mvc.context.config.ContextConfigVoBuilder;
import com.domwires.core.mvc.message.IMessage;
import com.domwires.core.mvc.model.AbstractModel;
import com.domwires.core.mvc.view.AbstractView;

import testObject.MyCoolEnum;

/////////////////////////
internal class ParentContext2 extends AbstractContext
{
	private var v:TestView0;
	private var m:TestModel4;

	public function ParentContext2()
	{
		var cb:ContextConfigVoBuilder = new ContextConfigVoBuilder();
		cb.forwardMessageFromViewsToModels = true;

		super(cb.build());
	}

	public function getModel():TestModel4
	{
		return m;
	}

	[PostConstruct]
	override public function init():void
	{
		super.init();

		v = factory.getInstance(TestView0);
		addView(v);

		m = factory.getInstance(TestModel4);
		factory.mapToValue(TestModel4, m);
		addModel(m);

		addModel(factory.getInstance(ChildContext2));

		map(MyCoolEnum.PREVED, TestCommand4);

		v.dispatch();
	}
}
internal class ChildContext2 extends AbstractContext
{
	[PostConstruct]
	override public function init():void
	{
		super.init();

		addView(factory.getInstance(TestView2));
	}
}
internal class TestView0 extends AbstractView
{
	[PostConstruct]
	public function init():void
	{
		addMessageListener(MyCoolEnum.BOGA, onBoga);
	}

	private function onBoga(m:IMessage):void
	{
		dispatchMessage(MyCoolEnum.SHALOM, null, true);
	}

	public function dispatch():void
	{
		dispatchMessage(MyCoolEnum.PREVED, null, true)
	}
}
internal class TestView2 extends AbstractView
{
	public static var VAL:int;

	[PostConstruct]
	public function init():void
	{
		addMessageListener(MyCoolEnum.SHALOM, onShalom);
	}

	private function onShalom(m:IMessage):void
	{
		trace("SOSISKI");
		TestView2.VAL++;
	}
}
internal class TestCommand4 extends AbstractCommand
{
	[Autowired]
	public var testModel:TestModel4;

	override public function execute():void
	{
		testModel.testVar++;
	}
}
internal class TestModel4 extends AbstractModel
{
	private var _testVar:int;

	public function set testVar(value:int):void
	{
		_testVar = value;
		dispatchMessage(MyCoolEnum.BOGA, null, true);
	}

	public function get testVar():int
	{
		return _testVar;
	}
}
/////////////////////////
/////////////////////////
internal class ParentContext extends AbstractContext
{
	private var m:TestModel7;

	[PostConstruct]
	override public function init():void
	{
		super.init();
		
		m = factory.getInstance(TestModel7);
		addModel(m);

		factory.mapToValue(TestModel7, m);

		addModel(factory.getInstance(ChildContext));

		m.dispatch();
	}

	public function getTestModel():TestModel7
	{
		return m;
	}
}

internal class ChildContext extends AbstractContext
{
	[Autowired]
	public var m:TestModel7;

	[PostConstruct]
	override public function init():void
	{
		super.init();
		
		factory.mapToValue(TestModel7, m);
		map(MyCoolEnum.PREVED, TestCommand7);

		m.registerExtraMessageHandler(this);
	}
}

internal class TestModel7 extends AbstractModel
{
	public var testVar:int;

	public function dispatch():void
	{
		dispatchMessage(MyCoolEnum.PREVED, null, true);
	}
}

internal class TestCommand7 extends AbstractCommand
{
	[Autowired]
	public var testModel:TestModel7;

	override public function execute():void
	{
		testModel.testVar++;
	}
}
//////////////////////////////////////
internal class TestCommand extends AbstractCommand implements ITestCommand
{
	[Autowired]
	public var testModel:TestModel;

	override public function execute():void
	{
		testModel.testVar++;
	}
}

internal class TestCommand3 extends AbstractCommand implements ITestCommand
{
	[Autowired]
	public var testModel:TestModel;

	override public function execute():void
	{
		testModel.testVar += 2;
	}
}

internal class TestCommand2 extends AbstractCommand
{
	[Autowired]
	public var testModel:TestModel2;

	override public function execute():void
	{
		testModel.testVar++;
	}
}

internal class TestModel extends AbstractModel
{
	public var testVar:int;
}

internal class TestModel2 extends AbstractModel
{
	public var testVar:int;
}

internal class TestView extends AbstractView
{
	public function TestView()
	{
		super();
	}
	
	public function dispatch():void
	{
		dispatchMessage(MyCoolEnum.PREVED, null, true)
	}
}

internal class TestContext2 extends AbstractContext
{
	private var testView:TestView;
	private var testModel2:TestModel2;

	public function TestContext2()
	{
		super();
	}

	[PostConstruct]
	override public function init():void
	{
		super.init();

		testView = factory.getInstance(TestView);
		addView(testView);

		testModel2 = factory.getInstance(TestModel2);
		addModel(testModel2);

		factory.mapToValue(TestModel2, testModel2);

		map(MyCoolEnum.PREVED, TestCommand2);
	}

	public function getTestModel():TestModel2
	{
		return testModel2;
	}

	public function ready():void
	{
		testView.dispatch();
	}

	override public function onMessageBubbled(message:IMessage):Boolean
	{
		super.onMessageBubbled(message);

		//to pass message to parent context
		return true;
	}
}

internal class TestContext1 extends AbstractContext
{
	private var testModel:TestModel;

	[PostConstruct]
	override public function init():void
	{
		super.init();

		testModel = factory.getInstance(TestModel);
		addModel(testModel);
		
		factory.mapToValue(TestModel, testModel);

		map(MyCoolEnum.PREVED, TestCommand);
	}

	public function getTestModel():TestModel
	{
		return testModel;
	}
}

internal class TestContext3 extends AbstractContext
{
	[Autowired]
	public var commandImpl:Class;

	private var testView:TestView;
	private var testModel:TestModel;

	[PostConstruct]
	override public function init():void
	{
		super.init();

		testView = factory.getInstance(TestView);
		addView(testView);

		testModel = factory.getInstance(TestModel);
		addModel(testModel);

		factory.mapToType(ITestCommand, commandImpl);
		factory.mapToValue(TestModel, testModel);

		map(MyCoolEnum.PREVED, ITestCommand);
	}

	public function getTestModel():TestModel
	{
		return testModel;
	}

	public function ready():void
	{
		testView.dispatch();
	}

	override public function onMessageBubbled(message:IMessage):Boolean
	{
		super.onMessageBubbled(message);

		//to pass message to parent context
		return true;
	}
}
