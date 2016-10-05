/**
 * Created by Anton Nefjodov on 10.06.2016.
 */
package com.crazyfm.core.mvc.message
{
	import com.crazyfm.core.common.Enum;

	public interface IMessage
	{
		function get type():Enum;
		function get data():Object;
		function get bubbles():Boolean;
		function get target():Object;
		function get currentTarget():Object;
		function get previousTarget():Object;
	}
}
