/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.utils
{
	import com.crazyfm.devkit.physics.ICFShapeObject;

	import nape.geom.AABB;

	import nape.shape.Shape;

	public class CFShapeObjectUtils
	{
		public static function isLadder(shape:Shape):Boolean
		{
			return shape.userData.dataObject &&
					shape.userData.dataObject is ICFShapeObject &&
					(shape.userData.dataObject as ICFShapeObject).isLadder;
		}

		public static function getLadderBounds(shape:Shape):AABB
		{
			if (isLadder(shape))
			{
				return shape.bounds;
			}

			return null;
		}
	}
}
