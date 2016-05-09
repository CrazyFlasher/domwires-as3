/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.utils
{
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;

	import nape.callbacks.InteractionCallback;

	public class PhysObjectModelUtils
	{
		public static function rotate(model:IPhysBodyObjectModel, angle:Number):void
		{
			model.rotation = angle;
		}

		public static function rotateBodyToInteractionCallbackNormal(model:IPhysBodyObjectModel, collision:InteractionCallback):void
		{
			if (collision.arbiters.length > 0)
			{
				var angle:Number = collision.arbiters.at(0).collisionArbiter.normal.angle - Math.PI / 2;

				if ((angle < Math.PI / 4.5 && angle > 0) || (angle > -Math.PI / 4.5 && angle < 0))
				{
					rotate(model, angle);
				}else
				{
					rotate(model, 0);
				}
			}
		}
	}
}
