/**
 * Created by CrazyFlasher on 20.11.2016.
 */
package com.domwires.core.mvc.context.config
{
	/**
	 * <code>IContext</code> configuration value object.
	 */
	public class ContextConfigVo
	{
		/**
		 * @private
		 */
		internal var _forwardMessageFromViewsToModels:Boolean;
		/**
		 * @private
		 */
		internal var _forwardMessageFromViewsToViews:Boolean;
		/**
		 * @private
		 */
		internal var _forwardMessageFromModelsToViews:Boolean;
		/**
		 * @private
		 */
		internal var _forwardMessageFromModelsToModels:Boolean;

		/**
		 * Returns true, if messages bubbled up from views should be forwarded to models.
		 */
		public function get forwardMessageFromViewsToModels():Boolean
		{
			return _forwardMessageFromViewsToModels;
		}

		/**
		 * Returns true, if messages bubbled up from views should be forwarded to views.
		 */
		public function get forwardMessageFromViewsToViews():Boolean
		{
			return _forwardMessageFromViewsToViews;
		}

		/**
		 * Returns true, if messages bubbled up from models should be forwarded to views.
		 */
		public function get forwardMessageFromModelsToViews():Boolean
		{
			return _forwardMessageFromModelsToViews;
		}

		/**
		 * Returns true, if messages bubbled up from models should be forwarded to models.
		 */
		public function get forwardMessageFromModelsToModels():Boolean
		{
			return _forwardMessageFromModelsToModels;
		}
	}
}
