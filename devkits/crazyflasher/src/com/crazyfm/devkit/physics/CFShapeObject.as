/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package com.crazyfm.devkit.physics
{
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.ShapeObject;

	import nape.shape.Shape;

	public class CFShapeObject extends ShapeObject implements ICFShapeObject
	{
		private var _cfData:CFShapeDataVo;

		private var _relatedTeleportEntrance:IShapeObject;
		private var _relatedTeleportExit:IShapeObject;

		public function CFShapeObject(data:CFShapeDataVo)
		{
			_cfData = data;

			super(data);
		}

		override protected function applyCustomData(shape:Shape):void
		{
			super.applyCustomData(shape);

			if (isLadder)
			{
				shape.sensorEnabled = true;
			}
		}

		override public function dispose():void
		{
			_cfData = null;

			_relatedTeleportEntrance = null;
			_relatedTeleportExit = null;

			super.dispose();
		}

		public function get isLadder():Boolean
		{
			return _cfData.isLadder;
		}

		public function get isTeleportEntrance():Boolean
		{
			return _relatedTeleportExit != null;
		}

		public function get isTeleportExit():Boolean
		{
			return _relatedTeleportEntrance != null;
		}

		public function get relatedTeleportEntrance():IShapeObject
		{
			return _relatedTeleportEntrance;
		}

		public function get relatedTeleportExit():IShapeObject
		{
			return _relatedTeleportExit;
		}

		ns_cfdevkit_phys function setRelatedTeleportEntrance(value:IShapeObject):ICFShapeObject
		{
			_relatedTeleportEntrance = value;

			if (value)
			{
				makeShapeAsSensor();
			}

			return this;
		}

		ns_cfdevkit_phys function setRelatedTeleportExit(value:IShapeObject):ICFShapeObject
		{
			_relatedTeleportExit = value;

			if (value)
			{
				makeShapeAsSensor();
			}

			return this;
		}

		private function makeShapeAsSensor():void
		{
			for each (var shape:Shape in shapes)
			{
				shape.sensorEnabled = true;
			}
		}

		public function get cfData():CFShapeDataVo
		{
			return _cfData;
		}
	}
}
