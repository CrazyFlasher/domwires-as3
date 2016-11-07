##DomWires
Flexible and extensible MVC framework.

###Features
* Splitting logic from visual part
* Immutable interfaces are separated from mutable to safe usage of read-only models (for example in views)
* Possibility to use many implementations for interface easily
* Fast communication among components using [IMessageDispatcher](http://188.166.108
.195/projects/domwires/core/doc/com/domwires/core/mvc/message/IMessageDispatcher.html)
* Object instantiation with dependencies injections using cool [IAppFactory](http://188.166.108.195/projects/domwires/core/doc/com/domwires/core/factory/IAppFactory.html#includeExamplesSummary)
* Easy object pooling management
* Custom message bus (event bus) for easy and strict communication among objects

***

###Maven artifact
**Repository URL:** https://raw.github.com/CrazyFlasher/maven-repo/master
```
<dependency>
  <groupId>com.domwires</groupId>
  <artifactId>core</artifactId>
  <version>0.9.0-SNAPSHOT</version>
  <type>swc</type>
</dependency>
```

***

- [Building from source](https://github.com/CrazyFlasher/domwires-as3/wiki/Building-(Windows))
- [SWC](http://188.166.108.195/projects/domwires/core/domwires-core_latest.zip)
- [ASDoc](http://188.166.108.195/projects/domwires/core/doc)
