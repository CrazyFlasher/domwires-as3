/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import nape.space.Space;

	public interface IWorldObject
	{
		function set data(value:WorldDataVo):void;
		function get data():WorldDataVo;
		function get bodyObjectList():Vector.<IBodyObject>;
		function get space():Space;
		//TODO: get joints
	}
}
