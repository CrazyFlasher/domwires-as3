/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModel;

	public interface IComponent extends IModel
	{
		function update(time:Number):void;
	}
}
