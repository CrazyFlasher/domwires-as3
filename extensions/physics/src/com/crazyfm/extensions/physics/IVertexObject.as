/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.IDisposable;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import nape.geom.Vec2;

	public interface IVertexObject extends IDisposable
	{
		function get x():Number;
		function get y():Number;
		function set data(value:VertexDataVo):void;
		function get data():VertexDataVo;
		function get vertex():Vec2;
	}
}
