/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IModel extends IDisposable
	{
		function set parent(value:IModelContainer):void;
		function get parent():IModelContainer;
	}
}
