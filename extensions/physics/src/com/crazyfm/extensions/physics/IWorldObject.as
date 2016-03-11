/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import nape.phys.Body;

	public interface IWorldObject
	{
		function set data(value:WorldDataVo):void;
		function get data():WorldDataVo;
		function get bodyObjectList():Vector.<IBodyObject>;
		//TODO: get joints
	}
}
