/**
 * Created by Anton Nefjodov on 2.05.2016.
 */
package com.crazyfm.devkit.gearSys.components.physyics.view.starling.gaf
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazyfm.devkit.gearSys.components.physyics.view.starling.AbstractPhysBodyObjectView;

	public class GAFPhysObjectView extends AbstractPhysBodyObjectView
	{
		protected var gafSkin:GAFMovieClip;

		public function GAFPhysObjectView(gafSkin:GAFMovieClip)
		{
			super();

			this.gafSkin = gafSkin;
		}

		override protected function drawSkin():void
		{
			_skin.addChild(gafSkin);
		}
	}
}
