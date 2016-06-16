/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.IDisposable;
	import com.crazyfm.extensions.physics.vo.units.VertexDataVo;

	import nape.geom.Vec2;

	VertexObject;
	public interface IVertexObject extends IDisposable
	{
		function get x():Number;
		function get y():Number;
		function get data():VertexDataVo;
		function get vertex():Vec2;
		function clone():IVertexObject;
	}
}
