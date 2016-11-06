##DomWires
Flexible and extensible MVC framework.

###Features
* Splitting logic from visual part
* Possibility to use many implementations for interface easily
* Fast communication among components using [IMessageDispatcher](http://188.166.108
.195/projects/domwires/core/doc/com/domwires/core/mvc/message/IMessageDispatcher.html)
* Object instantiation with dependencies injections using cool [IAppFactory](http://188.166.108.195/projects/domwires/core/doc/com/domwires/core/factory/IAppFactory.html#includeExamplesSummary)
* Easy object pooling management
* Custom message bus (event bus) for easy and strict communication among components

###Build from source (Windows)
To build entire framework with all extensions and modules you need to:

1. Install **ANT**
2. Install [Apache Flex SDK](http://flex.apache.org/)
3. Specify environment variables:
  - **JAVA_HOME** - path to JDK (also add to PATH)
  - **ANT_HOME** - path to ant.bat (also add to PATH)
  - **FLEX_HOME** - path to Flex SDK
  - **FLASH_PLAYER_EXE** - path to flash standalone exe (for unit tests)
4. Clone [domwires-builder](https://github.com/CrazyFlasher/domwires-builder) to the same parent folder
5. Open CMD and target to **/domwires/build/ant/** folder
6. Type **ant** and build process will start
7. When build finish with success result, all modules with documents will appear here: **/out/dependencies/**

***

- [SWC](http://188.166.108.195/projects/domwires/core/domwires-core_latest.zip)
- [ASDoc](http://188.166.108.195/projects/domwires/core/doc)
