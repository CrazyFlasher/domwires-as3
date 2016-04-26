/**
 * Created by Anton Nefjodov on 22.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.hierarchy.IHierarchyObjectContainer;

	public interface IGearWheel extends IHierarchyObjectContainer
	{
		function interact(timePassed:Number):void;
	}
}
