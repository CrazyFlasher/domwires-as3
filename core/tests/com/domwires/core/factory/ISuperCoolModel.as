/**
 * Created by CrazyFlasher on 18.11.2016.
 */
package com.domwires.core.factory
{
	import com.domwires.core.mvc.model.IModel;

	public interface ISuperCoolModel extends IModel
	{
		function getCoolValue():int;
		function get value():int;
		function get def():IDefault;
		function get object():Object;
		function get array():Array;
	}
}
