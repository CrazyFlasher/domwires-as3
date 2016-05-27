/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package
{
	import com.crazyfm.core.factory.AppFactory;

	public function getInstance(type:Class, ...constructorArgs):*
	{
		AppFactory.getSingletonInstance()
			.getInstance.apply(null, constructorArgs);
	}
}
