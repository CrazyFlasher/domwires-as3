/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.model
{
	import com.domwires.core.mvc.model.IModelImmutable;

	public interface IAppModelImmutable extends IModelImmutable
	{
		function get firstName():String;
		function get lastName():String;
		function get age():int;
		function get country():int;
	}
}
