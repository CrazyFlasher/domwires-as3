/**
 * Created by Anton Nefjodov on 6.02.2016.
 */
package com.crazyfm.extension.preloader
{
	import com.crazyfm.mvc.model.IContext;

	import flash.display.LoaderInfo;

	public interface IPreloaderContext extends IContext
	{
		function set loaderInfo(value:LoaderInfo):void;
		function addNativeEventListener(type:String, listener:Function):void;
	}
}
