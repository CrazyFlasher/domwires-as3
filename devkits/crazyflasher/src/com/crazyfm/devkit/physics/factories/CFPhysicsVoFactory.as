/**
 * Created by Anton Nefjodov on 17.05.2016.
 */
package com.crazyfm.devkit.physics.factories
{
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.factories.PhysicsVoFactory;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

	public class CFPhysicsVoFactory extends PhysicsVoFactory
	{
		public function CFPhysicsVoFactory()
		{
			super();
		}

		override public function parseShape(shapeJson:Object, toData:ShapeDataVo = null):ShapeDataVo
		{
			var data:CFShapeDataVo;

			if (!toData)
			{
				data = new CFShapeDataVo();
			}else
			{
				if (!(toData is CFShapeDataVo))
				{
					throw new Error("Invalid type: CFShapeDataVo required!")
				}
			}

			super.parseShape(shapeJson, data);

			data.isLadder = data.customData.isLadder;
			data.exitFromShapeId = data.customData.exitFromShapeId;
			data.exitToShapeId = data.customData.exitToShapeId;

			return data;
		}
	}
}
