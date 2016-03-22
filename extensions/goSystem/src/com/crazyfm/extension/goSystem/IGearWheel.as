/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModel;

	public interface IGearWheel extends IModel
	{
		function interact(timePassed:Number):void;
	}
}
