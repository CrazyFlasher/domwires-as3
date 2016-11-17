/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.domwires.core.factory
{
	import com.domwires.core.common.IDisposable;

	/**
	 * <p>Universal instance factory.</p>
	 * <p>Features:</p>
	 * <ul>
	 * <li>New instances creation</li>
	 * <li>Pools creation</li>
	 * <li>Map interface (or any other class) to class</li>
	 * <li>Map interface (or any other class) to instance</li>
	 * <li>Automatically create default interface implementation (without manual mapping)</li>
	 * <li>Possibility to pass constructor arguments in ordinary way</li>
	 * <li>Inject dependencies to objects</li>
	 * <li>Manage singletons</li>
	 * </ul>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject
	 *     var obj:IMyObject = factory.getInstance(IMyObject);
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     //Factory will search for default implementation of IMyObject (because mapToType is missing)
	 *	   //and if found, will return new instance.
	 *	   //Rules to use default implementation:
	 *	   //1. Interface should start from "I" character;
	 *	   //2. Default implementation should be in the same package as interface;
	 *	   //3. Default implementation class should have the same name as it's interface,
	 *	   //but without the first "I" character (in this case IMyObject and MyObject);
	 *
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 *     var obj:IMyObject = factory.getInstance(IMyObject);
	 *     ...
	 *     MyObject; //we define default implementation here, so compiler will fetch this class in any case.
	 *     public interface IMyObject
	 *     {
	 *     }
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject and passes new Camera() as constructor argument
	 *     var obj:IMyObject = factory.getInstance(IMyObject, new Camera());
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		public function MyObject(camera:Camera)
	 *     		{
	 *   		}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject and passes arguments to constructor
	 *     var obj:IMyObject = factory.getInstance(IMyObject, [new Camera(), [], true]);
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		public function MyObject(camera:Camera, array:Array, flag:Boolean)
	 *     		{
	 *   		}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool.
	 *     //If any constructor arguments will be passed, they will be ignored.
	 *     var obj:IMyObject = factory.getInstance(IMyObject);
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //maps ICamera interface to Camera instance
	 *     factory.mapToValue(ICamera, new Camera());
	 *
	 *     //returns new instance of MyObject
	 *     var obj:IMyObject = factory.getInstance(IMyObject);
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		[Autowired]
	 *     		public var camera:ICamera; //object will be automatically injected
	 *
	 *     		public function MyObject()
	 *     		{
	 *   		}
	 *
	 *			[PostConstruct]
	 *			public function init():void
	 *			{
	 *				//will be called automatically after instance is created and dependencies are injected
	 *			}
	 *
	 *			[PostInject]
	 *			public function init():void
	 *			{
	 *				//will be called automatically each time after dependencies are injected (e.q. camera in this case)
	 *				//For ex. you can manually inject dependencies by calling <code>factory.injectDependencies</code>
	 *			}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:IAppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.mapToType(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool
	 *     var obj:IMyObject = factory.getInstance(IMyObject);
	 *     //Injects dependencies to object and calls method (if any), that is marked with [PostInject] metatag
	 *     factory.injectDependencies(obj);
	 * </listing>
	 */
	public interface IAppFactory extends IAppFactoryImmutable, IDisposable
	{
		function appendMappingConfig(config:MappingConfigVo):IAppFactory;
		
		/**
		 * Maps one class (or interface) type to another.
		 * @param type Type, that has to be mapped to another type
		 * @param to Type or instance, that type type should be mapped to
		 * @see #mapToValue()
		 * @return
		 */
		function mapToType(type:Class, to:Class):IAppFactory;

		/**
		 * Maps one class (or interface) type to instance.
		 * @param type Type, that has to be mapped to another type
		 * @param to Instance, that type type should be mapped to
		 * @param name Optional parameter, to map dependency to value with current name parameter in metatag
		 * @see #mapToType()
		 * @return
		 */
		function mapToValue(type:Class, to:Object, name:String = null):IAppFactory;

		/**
		 * Unmaps current type.
		 * @param type Class, that is mapped to some value
		 * @param name Name of value mapping in metatag
		 * @see #mapToValue()
		 * @return
		 */
		function unmapValue(type:Class, name:String = null):IAppFactory;

		/**
		 * Unmaps current type.
		 * @param type Class, that is mapped to another class.
		 * @see #mapToType()
		 * @return
		 */
		function unmapType(type:Class):IAppFactory;

		/**
		 * Registers pool for instances of provided type.
		 * @param type Type of object to register pool for
		 * @param capacity Maximum objects of current type in pool
		 * @return
		 */
		function registerPool(type:Class, capacity:uint = 5):IAppFactory;

		/**
		 * Unregisters and disposes pool for provided type.
		 * @param type Type of object to register pool for
		 * @return
		 */
		function unregisterPool(type:Class):IAppFactory;

		/**
		 * Removes singleton of provided type.
		 * @param type
		 * @return
		 */
		function removeSingleton(type:Class):IAppFactory;

		/**
		 * Clears all pools of current <code>IAppFactory</code>.
		 * @return
		 */
		function clearPools():IAppFactory;

		/**
		 * Clears of mappings of current <code>IAppFactory</code>.
		 * @return
		 */
		function clearMappings():IAppFactory;

		/**
		 * Clears of pools and mappings of current <code>IAppFactory</code>.
		 * @return
		 */
		function clear():IAppFactory;

		/**
		 * Automatically injects dependencies to newly created objects, using <code>getInstance</code> method.
		 */
		function set autoInjectDependencies(value:Boolean):void;

		/**
		 * Prints out extra information to logs.
		 * Useful for debugging, but leaks performance.
		 */
		function set verbose(value:Boolean):void;

		/**
		 * Inject dependencies to properties marked with [Autowired] to provided object and calls [PostConstruct] method if has any.
		 * @param object Object to inject dependencies to
		 * @return
		 */
		function injectDependencies(object:*):*;
	}
}
