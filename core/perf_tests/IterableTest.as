/**
 * Created by Anton Nefjodov on 14.02.2016.
 */
package
{
	import com.domwires.core.mvc.message.IMessage;
	import com.domwires.core.mvc.model.AbstractModel;
	import com.domwires.core.mvc.model.IModel;

	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	import testObject.MyCoolEnum;

	public class IterableTest
	{
		private var v:Vector.<IModel>;
		private var a:Array;
		private var d:Dictionary;

		[Before]
		public function setUp():void
		{
			v = new <IModel>[];
			a = [];
			d = new Dictionary();
			for (var i:int = 0; i < 1000; i++)
			{
				var m:IModel = new AbstractModel();

				v.push(m);
				a.push(m);
				d[m] = m;
			}
		}

		[After]
		public function tearDown():void
		{
			v = null;
			d = null;
			a = null;

			trace("---------------------------------------");

			//System.pauseForGCIfCollectionImminent(0);
		}

		[Test]
		public function testVectorFor():void
		{
			trace("testVectorFor");

			var l:Function = function(event:IMessage):void{};

			var startTime:Number = getTimer();

			for (var i2:int = 0; i2 < v.length; i2++)
			{
				v[i2].addMessageListener(MyCoolEnum.PREVED, l);
			}

			for (var i3:int = 0; i3 < v.length; i3++)
			{
				v[i3].removeAllMessageListeners();
			}

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function testVectorForEach():void
		{
			trace("testVectorForEach");

			var l:Function = function(event:IMessage):void{};

			var startTime:Number = getTimer();

			for each (var m2:IModel in v)
			{
				m2.addMessageListener(MyCoolEnum.PREVED, l);
			}
			for each (var m3:IModel in v)
			{
				m3.removeAllMessageListeners();
			}

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function testVectorGetElementForEach():void
		{
			trace("testVectorGetElementForEach");

			var model:IModel = new AbstractModel();
			v.push(model);

			var startTime:Number = getTimer();

			for each (var m:IModel in v)
			{
				if(m == model)
				{
					break;
				}
			}

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function testVectorGetElementFor():void
		{
			trace("testVectorGetElementFor");

			var model:IModel = new AbstractModel();
			v.push(model);

			var startTime:Number = getTimer();

			for (var i:int = 0; i < v.length; i++)
			{
				if(v[i] == model)
				{
					break;
				}
			}

			trace("time passed: ", (getTimer() - startTime));
		}
		//Dictionary
		[Test]
		public function testDictFor():void
		{
			trace("testDictFor");

			var l:Function = function(event:IMessage):void{};

			var startTime:Number = getTimer();

			for (var m:* in d)
			{
				d[m].addMessageListener(MyCoolEnum.PREVED, l);
			}

			for (var m2:* in d)
			{
				d[m2].removeAllMessageListeners();
			}

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function testDictGetElementFor():void
		{
			trace("testDictGetElementFor");

			var model:IModel = new AbstractModel();
			d[model] = model;

			var startTime:Number = getTimer();

			var m:IModel = d[model];

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function removeFromVectorRemoveAt():void
		{
			trace("removeFromVectorRemoveAt");

			var model:IModel = new AbstractModel();
			v.push(model);

			var startTime:Number = getTimer();
			v.removeAt(v.indexOf(model));

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function removeFromVectorSplice():void
		{
			trace("removeFromVectorSplice");

			var model:IModel = new AbstractModel();
			v.push(model);

			var startTime:Number = getTimer();
			v = v.splice(v.indexOf(model), 1);

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function removeFromArraySplice():void
		{
			trace("removeFromArraySplice");

			var model:IModel = new AbstractModel();
			a.push(model);

			var startTime:Number = getTimer();
			a = a.splice(a.indexOf(model), 1);

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function removeFromArrayRemoveAt():void
		{
			trace("removeFromArrayRemoveAt");

			var model:IModel = new AbstractModel();
			a.push(model);

			var startTime:Number = getTimer();
			a.removeAt(a.indexOf(model));

			trace("time passed: ", (getTimer() - startTime));
		}

		[Test]
		public function removeFromDict():void
		{
			trace("removeFromDict");

			var model:IModel = new AbstractModel();
			d[model] = model;

			var startTime:Number = getTimer();
			delete d[model];

			trace("time passed: ", (getTimer() - startTime));
		}
	}
}
