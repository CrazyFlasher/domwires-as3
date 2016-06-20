##CrazyFM
**_NB! This project is in early alpha development version, and I don't recommend to use it for your third party projects development now._**

###Features
* Splitting logic from visual part
* Possibility to use many implementations easily
* Fast communication among components using [IMessageDispatcher](http://188.166.108.195/projects/crazyfm/core/doc/com/crazyfm/core/mvc/message/IMessageDispatcher.html)
* Object instantiation with dependencies injections using cool [IAppFactory](http://188.166.108.195/projects/crazyfm/core/doc/com/crazyfm/core/factory/IAppFactory.html#includeExamplesSummary)
* Easy object pooling management

###Quick build from source (Windows)
To build entire frameworks with all extensions and modules you need to:
1. Install ANT
2. Download [http://flex.apache.org/](Apache Flex SDK)
3. Specify environment variables:
	* **ANT_HOME**: path to ant.bat
	* **FLASH_PLAYER_EXE**: path to flash standalone exe
	* **_JAVA_OPTIONS**: -Xmx512M -XX:MaxPermSize=512m
	* **FLASH_IDE_EXE** (optional): path to Flash.exe (Animate.exe)
	* **FLEX_HOME**: path to Flex SDK
4. Open CMD and target to **crazyfm/build/ant/** folder
5. Type **ant** and build process will start
6. When build finish with success result, all modules with documents will appear here: **crazyfm/dependencies/**

***

- [Download SWC's](http://188.166.108.195/projects/crazyfm/crazyfm_latest.zip)
- [View ASDoc](http://188.166.108.195/projects/crazyfm/doc/index.html)

***

- [Read more about core](core)
- [Read more about extensions](extensions)
- [View examples](https://github.com/CrazyFlasher/crazyfm-examples)