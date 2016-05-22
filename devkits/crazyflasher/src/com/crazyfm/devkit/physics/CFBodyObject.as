/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.extensions.physics.BodyObject;
	import com.crazyfm.extensions.physics.vo.units.BodyDataVo;

	use namespace ns_cfdevkit_phys;

	public class CFBodyObject extends BodyObject
	{
		public function CFBodyObject(data:BodyDataVo)
		{
			super(data);

			var teleportExitObject:CFShapeObject;

			for each (var shapeObject:CFShapeObject in shapeObjectList)
			{
				if (shapeObject.cfData.teleportExitId != null)
				{
					teleportExitObject = getTeleportExitObject(shapeObject.cfData.teleportExitId);
					if (teleportExitObject != null)
					{
						shapeObject.setRelatedTeleportExit(teleportExitObject);
						teleportExitObject.setRelatedTeleportEntrance(shapeObject);
					}
				}
			}
		}

		private function getTeleportExitObject(id:String):CFShapeObject
		{
			for each (var shapeObject:CFShapeObject in shapeObjectList)
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
