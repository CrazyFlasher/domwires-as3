/**
 * Created by Anton Nefjodov on 2.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics
{
	import com.crazyfm.core.common.Disposable;

	import nape.callbacks.InteractionCallback;
	import nape.shape.Shape;

	public class PhysObjectSignalData extends Disposable
	{
		private var _collision:InteractionCallback;
		private var _collidedShape:Shape;

		public function PhysObjectSignalData()
		{

		}

		public function get collision():InteractionCallback
		{
			return _collision;
		}

		public function get collidedShape():Shape
		{
			return _collidedShape;
		}

		override public function dispose():void
		{
			_collision = null;
			_collidedShape = null;

			super.dispose();
		}

		public function set collision(value:InteractionCallback):void
		{
			_collision = value;
		}

		public function set collidedShape(value:Shape):void
		{
			_collidedShape = value;
		}
	}
}
