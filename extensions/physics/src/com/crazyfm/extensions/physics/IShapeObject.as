/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;

	import nape.shape.Shape;

	public interface IShapeObject
	{
		function get vertexObjectList():Vector.<IVertexObject>;
		function set data(value:ShapeDataVo):void;
		function get data():ShapeDataVo;
		function get shapes():Vector.<Shape>;
	}
}
