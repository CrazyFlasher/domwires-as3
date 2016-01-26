/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.starlingSample.mvc.models
{
	import com.crazy.mvc.Model;

	import flash.utils.setTimeout;

	public class PhysicsModel extends Model
	{
		public function PhysicsModel()
		{
			super();

			setTimeout(wallHit, 2000);
		}

		private function wallHit():void
		{
			dispatch("wallHit");
		}
	}
}
