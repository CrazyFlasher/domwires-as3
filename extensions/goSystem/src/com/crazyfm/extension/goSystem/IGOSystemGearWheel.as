/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObject;

	public interface IGOSystemGearWheel extends IHierarchyObject
	{
		function interact(timePassed:Number):void;
		//TODO
//		function interactStarted():void;
	}
}
