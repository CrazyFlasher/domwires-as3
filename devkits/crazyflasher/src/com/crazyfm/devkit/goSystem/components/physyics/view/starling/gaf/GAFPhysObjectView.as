/**
 * Created by Anton Nefjodov on 2.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view.starling.gaf
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.ns_inter_physobject;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.AbstractPhysBodyObjectView;

	import nape.geom.Vec2;
	import nape.phys.Body;

	import starling.display.DisplayObjectContainer;

	use namespace ns_inter_physobject;

	public class GAFPhysObjectView extends AbstractPhysBodyObjectView
	{
		protected var gafSkin:GAFMovieClip;

		public function GAFPhysObjectView(container:DisplayObjectContainer, gafSkin:GAFMovieClip)
		{
			super(container);

			this.gafSkin = gafSkin;
		}

		override protected function drawSkin():void
		{
			var body:Body = (model as PhysBodyObjectModel).body;
			var boundsMin:Vec2 = body.worldPointToLocal(body.bounds.min);

			gafSkin.x = boundsMin.x;
			gafSkin.y = boundsMin.y;

			_skin.addChild(gafSkin);
		}
	}
}
