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

		public function ShapeMaterialVo(json:Object)
		{
			if (json)
			{
				if(json.elasticity != null)
				{
					_elasticity = getNumberValue(json.elasticity);
				}
				if(json.dynamicFriction != null)
				{
					_dynamicFriction = getNumberValue(json.dynamicFriction);
				}
				if(json.staticFriction != null)
				{
					_staticFriction = getNumberValue(json.staticFriction);
				}
				if(json.density != null)
				{
					_density = getNumberValue(json.density);
				}
				if(json.rollingFriction != null)
				{
					_rollingFriction = getNumberValue(json.rollingFriction);
				}
			}
		}

		public function get elasticity():Number
		{
			return _elasticity;
		}

		public function get dynamicFriction():Number
		{
			return _dynamicFriction;
		}

		public function get staticFriction():Number
		{
			return _staticFriction;
		}

		public function get density():Number
		{
			return _density;
		}

		public function get rollingFriction():Number
		{
			return _rollingFriction;
		}
	}
}
