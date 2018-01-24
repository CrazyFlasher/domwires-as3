/**
 * Created by CrazyFlasher on 21.10.2016.
 */
package com.domwires.core.factory
{
	import com.domwires.core.common.IDisposableImmutable;

	/**
	 * Immutable interface.
	 * @see com.domwires.core.factory.IAppFactory
	 */

	public interface IAppFactoryImmutable extends IDisposableImmutable
	{
		/**
		 * Returns true, if <code>IAppFactory</code> has mapping for current type.
		 * @param type Class or interface type
		 * @param name Name of value mapping in metatag
		 * @return
		 */
		function hasTypeMappingForType(type:Class, name:String = null):Boolean;

		/**
		 * Returns true, if <code>IAppFactory</code> has mapping for current value.
		 * @param type Class or interface type
		 * @param name Name of value mapping in metatag
		 * @return
		 */
		function hasValueMappingForType(type:Class, name:String = null):Boolean;

		/**
		 * Returns either new instance of class or instance from pool.
		 * In case of new instance, constructorArgs can be passed and dependencies will be automatically injected (if
		 * <code>autoInjectDependencies</code> is set to true). if object is taken from pool or <code>autoInjectDependencies</code> is
		 * false, then dependencies can be injected using
		 * <code>injectDependencies</code>
		 * @param type Type of instance to return
		 * @param constructorArgs constructor arguments. Can be any type. Use Array, if need to pass several args.
		 * @param name Name of value mapping in metatag
		 * @param ignorePool If true, then factory skips sarch instance in pools
		 * @return
		 * @see #injectDependencies()
		 */
		function getInstance(type:Class, constructorArgs:* = null, name:String = null, ignorePool:Boolean = false):*;

		/**
		 * Returns true, if <code>IAppFactory</code> has registered pool for provided type.
		 * @param type
		 * @return
		 */
		function hasPoolForType(type:Class):Boolean;

		/**
		 * Returns (creates in needed) singleton of provided type.
		 * @param type
		 * @return
		 */
		function getSingleton(type:Class):*;
	}
}
