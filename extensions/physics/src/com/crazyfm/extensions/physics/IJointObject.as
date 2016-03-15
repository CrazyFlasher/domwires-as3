/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.JointDataVo;

	import nape.constraint.AngleJoint;

	import nape.phys.Body;

	public interface IJointObject
	{
		function get data():JointDataVo;
		function set data(value:JointDataVo):void;
		function get joint():AngleJoint;
		function connect(body_1:Body, body_2:Body):void;
	}
}
