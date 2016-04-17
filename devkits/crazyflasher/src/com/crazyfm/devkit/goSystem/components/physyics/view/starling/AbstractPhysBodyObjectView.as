/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view.starling
{
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.devkit.goSystem.components.view.starling.StarlingView;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class AbstractPhysBodyObjectView extends StarlingView implements IPhysBodyObjectView
	{
		protected var model:IPhysBodyObjectModel;

		protected var _skin:DisplayObject;

		public function AbstractPhysBodyObjectView(viewContainer:DisplayObjectContainer)
		{
			super(viewContainer);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!model)
			{
				model = gameObject.getComponentByType(IPhysBodyObjectModel) as IPhysBodyObjectModel;
			}

			if (!skin)
			{
				_skin = new Sprite();
				viewContainer.addChild(_skin);

				drawSkin();
			}

			skin.x = model.body.position.x;
			skin.y = model.body.position.y;
			skin.rotation = model.body.rotation;
		}

		protected function drawSkin():void
		{
			//override to draw skin here
			throw new Error("Abstract method. Require override!");
		}

		override public function dispose():void
		{
			model = null;

			if (_skin)
			{
				if (_skin.parent)
				{
					_skin.removeFromParent(true);
				}

				_skin = null;
			}

			super.dispose();
		}

		public function get skin():DisplayObject
		{
			return _skin;
		}
	}
}
