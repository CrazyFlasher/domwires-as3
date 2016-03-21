/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazyfm.extension.goSystem
{
	import com.crazyfm.core.mvc.model.IContext;

	import flash.utils.Dictionary;

	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public interface IGOSystem extends IContext, IAnimatable
	{
		function addGameObject(value:IGameObject):IGOSystem;
		function removeGameObject(value:IGameObject, dispose:Boolean = false):IGOSystem;
		function removeAllGameObjects(dispose:Boolean = false):IGOSystem;
		function get numGameObjects():int;
		function containsGameObject(value:IGameObject):Boolean;
		function get gameObjectList():Dictionary;
		function setJuggler(juggler:Juggler):IGOSystem;
		function get juggler():Juggler;
	}
}
