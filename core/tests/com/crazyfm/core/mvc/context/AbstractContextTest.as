/**
 * Created by CrazyFlasher on 3.10.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.core.mvc.view.AbstractView;

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
			
			c = f.getInstance(IContext);
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
	}
}

import com.crazyfm.core.mvc.command.AbstractCommand;
import com.crazyfm.core.mvc.context.AbstractContext;
import com.crazyfm.core.mvc.message.IMessage;
import com.crazyfm.core.mvc.model.AbstractModel;
import com.crazyfm.core.mvc.view.AbstractView;

import testObject.MyCoolEnum;

internal class TestCommand extends AbstractCommand
{
	[Autowired]
	public var testModel:TestModel;

	override public function execute():void
	{
		testModel.testVar++;
	}
}

internal class TestModel extends AbstractModel
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

	public function TestContext1()
	{
		super();
	}

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
