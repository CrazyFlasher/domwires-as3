/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package
{
	import com.crazyfm.core.factory.AppFactory;

	/**
	 * Returns instance of specified type.
	 * @param type
	 * @param constructorArgs
	 * @return
	 * @see com.crazyfm.core.factory.AppFactory#getInstance()
	 */
	public function getInstance(type:Class, ...constructorArgs):*
	{
		var factory:AppFactory = AppFactory.getSingletonInstance();

		//TODO: find better solution
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
			case 8: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7]);
			case 9: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8]);
			case 10: return factory.getInstance(type, constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8], constructorArgs[9]);
			default: throw new Error("getNewInstance supports maximum 10 constructor arguments.");
		}
	}
}
