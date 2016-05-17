/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.IShapeObject;

	public interface ICFShapeObject extends IShapeObject
	{
		function get cfData():CFShapeDataVo;
		function get isLadder():Boolean;
		function get isTeleportEntrance():Boolean;
		function get isTeleportExit():Boolean;
		function get relatedTeleportEntrance():IShapeObject;
		function get relatedTeleportExit():IShapeObject;
	}
}
