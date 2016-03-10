/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModel;

	public interface IGameComponent extends IModel
	{
		function advanceTime(time:Number):void;
	}
}
