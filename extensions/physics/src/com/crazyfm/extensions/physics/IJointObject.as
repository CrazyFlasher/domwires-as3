/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.core.common.IDisposable;
	import com.crazyfm.extensions.physics.vo.JointDataVo;

	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.phys.Body;

	public interface IJointObject extends IDisposable
	{
		function get data():JointDataVo;
		function get pivotJoint():PivotJoint;
		function get angleJoint():AngleJoint;
		function connect(body_1:Body, body_2:Body):void;
		function clone():IJointObject;
	}
}
