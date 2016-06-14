/**
 * Created by Anton Nefjodov on 9.03.2016.
 */
package com.crazyfm.extension.gearSys
{
	public interface IGearSysComponent extends IGearSysGearWheel
	{
		function get gameObject():IGearSysObject;
	}
}
