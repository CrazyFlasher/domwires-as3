/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.BodyDataVo;

	import nape.phys.Body;

	public interface IBodyObject
	{
		function get shapeObjectList():Vector.<IShapeObject>;
		function set data(value:BodyDataVo):void;
		function get data():BodyDataVo;
		function get body():Body;
	}
}
