/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics.factories
{
	import com.crazyfm.devkit.physics.*;
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.factories.PhysicsObjectFactory;
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;

	use namespace ns_cfdevkit_phys;

	public class CFPhysicsObjectFactory extends PhysicsObjectFactory
	{
		public function CFPhysicsObjectFactory()
		{
			super();
		}

		override public function getShape(data:ShapeDataVo):IShapeObject
		{
			if (!(data is CFShapeDataVo))
			{
				throw new Error("Invalid type: CFShapeDataVo required!");
			}

			return new CFShapeObject(data as CFShapeDataVo, this);
		}


		override public function getBody(data:BodyDataVo):IBodyObject
		{
			var body:IBodyObject = super.getBody(data);

			var teleportExitObject:CFShapeObject;

			for each (var shapeObject:CFShapeObject in body.shapeObjectList)
			{
				if (shapeObject.cfData.teleportExitId != null)
				{
					teleportExitObject = getTeleportExitObject(body, shapeObject.cfData.teleportExitId);
					if (teleportExitObject != null)
					{
						shapeObject.setRelatedTeleportExit(teleportExitObject);
						teleportExitObject.setRelatedTeleportEntrance(shapeObject);
					}
				}
			}

			return body;
		}

		private static function getTeleportExitObject(body:IBodyObject, id:String):CFShapeObject
		{
			for each (var shapeObject:CFShapeObject in body.shapeObjectList)
			{
				if (shapeObject.data.id == id)
				{
					return shapeObject;
				}
			}

			return null;
		}
	}
}
