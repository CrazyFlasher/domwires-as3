/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.HierarchyObject;

	public class GameComponent extends HierarchyObject implements IGameComponent
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
