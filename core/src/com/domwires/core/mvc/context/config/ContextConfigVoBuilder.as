/**
 * Created by CrazyFlasher on 20.11.2016.
 */
package com.domwires.core.mvc.context.config
{
	/**
	 * <code>ContextConfigVo</code> builder.
	 */
	public class ContextConfigVoBuilder
	{
		/**
		 * If bubbled up messages from views should be forwarded to models.
		 */
		public var forwardMessageFromViewsToModels:Boolean;

		/**
		 * If bubbled up messages from views should be forwarded to views.
		 */
		public var forwardMessageFromViewsToViews:Boolean = true;

		/**
		 * If bubbled up messages from models be forwarded to views.
		 */
		public var forwardMessageFromModelsToViews:Boolean = true;

		/**
		 * If bubbled up messages from models be forwarded to models.
		 */
		public var forwardMessageFromModelsToModels:Boolean;

		/**
		 * Builds and returns new <code>ContextConfigVo</code> instance.
		 * @return
		 */
		public function build():ContextConfigVo
		{
			var config:ContextConfigVo = new ContextConfigVo();

			config._forwardMessageFromModelsToModels = forwardMessageFromModelsToModels;
			config._forwardMessageFromModelsToViews = forwardMessageFromModelsToViews;
			config._forwardMessageFromViewsToViews = forwardMessageFromViewsToViews;
			config._forwardMessageFromViewsToModels = forwardMessageFromViewsToModels;

			return config;
		}
	}
}
