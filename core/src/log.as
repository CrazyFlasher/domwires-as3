/**
 * Created by Anton Nefjodov on 29.04.2016.
 */
package
{
	import flash.system.Capabilities;

	public function log(...args):void
	{
		if (Capabilities.isDebugger)
		{
			trace("[" + new Error().getStackTrace().split("\n")[2].split("at ")[1].split("/")[0] + "]: " + args);
		}else
		{
			trace(args);
		}
	}
}
