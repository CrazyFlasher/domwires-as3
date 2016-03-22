/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.Model;

	public class GameComponent extends Model implements IGameComponent
	{
		public function GameComponent()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function get gameObject():IGameObject
		{
			return parent as IGameObject;
		}

		/**
		 * @inheritDoc
		 */
		public function interact(timePassed:Number):void
		{

		}
	}
}
