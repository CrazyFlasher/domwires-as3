/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazyfm.extensions.physics.factory
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extensions.physics.BodyObject;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.ShapeObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;

	public class PhysFactory extends AppFactory
	{
		private static var _instance:IAppFactory;

		public static function get instance():IAppFactory
		{
			if (!_instance)
			{
				log("Warning: PhysFactory.instance is not specified. Creating default one with default implementations.");
				_instance = new AppFactory();
				_instance.map(IWorldObject, WorldObject)
						 .map(IBodyObject, BodyObject)
						 .map(IJointObject, JointObject)
						 .map(IShapeObject, ShapeObject)
						 .map(IVertexObject, VertexObject);
			}

			return _instance;
		}

		public static function set instance(value:IAppFactory):void
		{
			if (_instance)
			{
				log("Warning: PhysFactory.instance already specified. Changing to new one: " + value);
			}
			_instance = value;
		}
	}
}
