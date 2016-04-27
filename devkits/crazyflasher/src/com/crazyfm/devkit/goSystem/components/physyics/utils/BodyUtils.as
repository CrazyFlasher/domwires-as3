/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.utils
{
	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	public class BodyUtils
	{
		public static function rotate(body:Body, angle:Number):void
		{
			body.rotation = angle;
		}

		public static function rotateBodyToInteractionCallbackNormal(body:Body, collision:InteractionCallback):void
		{
			if (collision.arbiters.length > 0)
			{
				var angle:Number = collision.arbiters.at(0).collisionArbiter.normal.angle - Math.PI / 2;

				if ((angle < Math.PI / 3.5 && angle > 0) || (angle > -Math.PI / 3.5 && angle < 0))
				{
					rotate(body, angle);
				}else
				{
					rotate(body, 0);
				}
			}
		}
	}
}
