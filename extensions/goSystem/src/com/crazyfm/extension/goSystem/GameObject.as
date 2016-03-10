/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.Context;
	import com.crazyfm.core.mvc.model.IModel;

	import starling.animation.Juggler;
	import starling.core.Starling;

	public class GameObject extends Context implements IGameObject
	{
		protected var juggler:Juggler;

		public function GameObject(juggler:Juggler = null)
		{
			super();

			if (juggler)
			{
				this.juggler = juggler;
			}else
			{
				this.juggler = Starling.juggler;
			}

			init();
		}

		private function init():void
		{
			startSimulation();
		}

		public function advanceTime(time:Number):void
		{
			for (var model:* in _modelList)
			{
				(model as IGameComponent).advanceTime(time);
			}
		}

		override public function addModel(model:IModel):void
		{
			if (!(model is IGameComponent))
			{
				throw new Error("Model should implement IGameComponent!");
			}

			super.addModel(model);
		}

		public function get isSimulating():Boolean
		{
			return juggler != null && juggler.contains(this);
		}

		override public function dispose():void
		{
			if (juggler)
			{
				juggler.remove(this);
				juggler = null;
			}

			super.dispose();
		}

		public function stopSimulation():void
		{
			if (isDisposed)
			{
				throw new Error("Object disposed!");
			}

			if (!juggler)
			{
				throw new Error("No juggler!");
			}

			juggler.remove(this);
		}

		public function startSimulation():void
		{
			if (isDisposed)
			{
				throw new Error("Object disposed!");
			}

			if (!juggler)
			{
				throw new Error("No juggler!");
			}

			juggler.add(this);
		}
	}
}
