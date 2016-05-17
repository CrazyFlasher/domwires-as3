/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.utils
{
	import com.crazyfm.devkit.physics.ICFShapeObject;
	import com.crazyfm.extensions.physics.IShapeObject;

	import nape.shape.Shape;

	public class CFShapeObjectUtils
	{
		public static function isLadder(shape:Shape):Boolean
		{
			return shape.userData.dataObject &&
					shape.userData.dataObject is ICFShapeObject &&
					(shape.userData.dataObject as ICFShapeObject).isLadder;
		}

		public static function isExitOfLadder(shape:Shape, ladderShape:Shape):Boolean
		{
			return (shape.userData.dataObject as IShapeObject).data.id ==
					(ladderShape.userData.dataObject as ICFShapeObject).exitFromShapeId;
		}
	}
}
