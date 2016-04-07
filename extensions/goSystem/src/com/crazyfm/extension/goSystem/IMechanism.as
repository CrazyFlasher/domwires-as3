/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IMechanism extends IHierarchyObjectContainer
	{
		function addGear(value:IGearWheel):IMechanism;
		function removeGear(value:IGearWheel, dispose:Boolean = false):IMechanism;
		function removeAllGears(dispose:Boolean = false):IMechanism;
		function get numGears():int;
		function containsGear(value:IGearWheel):Boolean;
		function get gearList():Array;
		function interact(passedTime:Number):void;
	}
}
