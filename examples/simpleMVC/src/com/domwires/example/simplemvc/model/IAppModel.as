/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.model
{
	import com.domwires.core.mvc.model.IModel;

	AppModel;
	public interface IAppModel extends IModel, IAppModelImmutable
	{
		function setFirstName(value:String):IAppModel;
		function setLastName(value:String):IAppModel;
		function setAge(value:int):IAppModel;
		function setCountry(value:int):IAppModel;
	}
}
