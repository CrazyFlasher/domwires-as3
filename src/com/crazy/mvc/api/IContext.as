/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc.api
{
	public interface IContext extends IModelContainer
	{
		/*function mapSignalTypeToCommand(signalType:String, commandClass:Class, affectedModels:Vector.<IModel> = null):void;
		function mapViewToMediator(view:IView, mediator:IController):void;
		function unmapSignalTypeFromCommand(signalType:String, commandClass:Class):void;
		function unmapViewFromMediator(view:IView, mediator:IController):void;*/
		function addView(view:IView):void;
		function addViews(views:Vector.<IView>):void;
		function removeView(view:IView, dispose:Boolean = false):void;
		function removeViews(views:Vector.<IView>, dispose:Boolean = false):void;
		function removeAllViews(dispose:Boolean = false):void;
		function get numViews():int;
		function containsView(view:IView):Boolean;
	}
}
