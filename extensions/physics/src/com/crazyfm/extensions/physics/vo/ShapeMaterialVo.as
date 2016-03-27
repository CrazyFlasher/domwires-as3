/**
 * Created by Anton Nefjodov on 13.03.2016.
 */
package com.crazyfm.extensions.physics.vo
{
	public class ShapeMaterialVo
	{
		private var _elasticity:Number = 0.0;
		private var _dynamicFriction:Number = 1.0;
		private var _staticFriction:Number = 2.0;
		private var _density:Number = 1.0;
		private var _rollingFriction:Number = 0.001;

		public function ShapeMaterialVo()
		{
		}

		public function get elasticity():Number
		{
			return _elasticity;
		}

		public function set elasticity(value:Number):void
		{
			_elasticity = value;
		}

		public function get dynamicFriction():Number
		{
			return _dynamicFriction;
		}

		public function set dynamicFriction(value:Number):void
		{
			_dynamicFriction = value;
		}

		public function get staticFriction():Number
		{
			return _staticFriction;
		}

		public function set staticFriction(value:Number):void
		{
			_staticFriction = value;
		}

		public function get density():Number
		{
			return _density;
		}

		public function set density(value:Number):void
		{
			_density = value;
		}

		public function get rollingFriction():Number
		{
			return _rollingFriction;
		}

		public function set rollingFriction(value:Number):void
		{
			_rollingFriction = value;
		}
	}
}
