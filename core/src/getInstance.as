/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package
{
	import com.crazyfm.core.factory.AppFactory;

	public function getInstance(type:Class, ...constructorArgs):*
	{
		var factory:AppFactory = AppFactory.getSingletonInstance();

		switch (constructorArgs.length)
		{
			case 0: return factory.getInstance(type);
			case 1: return factory.getInstance(type, constructorArgs[0]);
			case 2: return factory.getInstance(type, constructorArgs[0], constructorArgs[1]);
			case 3: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2]);
			case 4: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]);
			case 5: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4]);
			case 6: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5]);
			case 7: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6]);
			default: throw new Error("getNewInstance supports maximum 7 constructor arguments.");
		}
	}
}
