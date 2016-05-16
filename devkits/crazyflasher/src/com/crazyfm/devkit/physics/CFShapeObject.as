/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	public class CFShapeObject extends ShapeObject implements ICFShapeObject
	{
		private const LADDER_ID_PREFIX:String = "ladder";

		public function CFShapeObject(data:ShapeDataVo)
		{
			super(data);
		}

		public function get isLadder():Boolean
		{
			return data.id.search(LADDER_ID_PREFIX) != -1;
		}
	}
}
