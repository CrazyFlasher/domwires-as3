/**
 * Created by Anton Nefjodov on 2.05.2016.
 */
package com.crazyfm.devkit.goSystem.components.physyics.view.starling.gaf
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.AbstractPhysBodyObjectView;

	import starling.display.DisplayObjectContainer;

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
			_skin.addChild(gafSkin);
		}
	}
}
