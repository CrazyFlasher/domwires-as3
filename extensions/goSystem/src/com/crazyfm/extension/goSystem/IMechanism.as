/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IModelContainer;

	import flash.utils.Dictionary;

	public interface IMechanism extends IModelContainer
	{
		function addGear(value:IGearWheel):IMechanism;
		function removeGear(value:IGearWheel, dispose:Boolean = false):IMechanism;
		function removeAllGears(dispose:Boolean = false):IMechanism;
		function get numGears():int;
		function containsGear(value:IGearWheel):Boolean;
		function get gearList():Dictionary;
		function interact(passedTime:Number):void;
	}
}
