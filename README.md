##CrazyFM
###Idea
ActionScript 3 framework based on idea to split view from logic, but leave possibility for easy communication between them.
Also the main idea of the framework is to fill it with new [extensions](extensions) easily.
Developer must have possibility to have several implementations of the same issue.
For example he can use physics extension and choose (also in run-time if needed) between 2 ways of its implementation.
For example between [Box2D](https://github.com/erincatto/Box2D) or [Nape](https://github.com/deltaluca/www.napephys.com). Ideally
developer can map somewhere in IContext which implementation for IPhysicsModel he wants to use.
No additional logic changes are needed.

###Why not to use other MVC frameworks?
The idea of most MVC frameworks to communicate between logic and view with commands and events, which is not comfortable sometimes and
reduces application performance.
For example, to update view of physics object, physics model must dispatch 10 (or even 60!) events per second and create many-many
commands due application workflow. Garbage collection will be called often to clear events and commands. Also if developer uses real-time
 injections (ex. [SwiftSuspenders](https://github.com/robotlegs/swiftsuspenders)) to commands, that will require extra resources and reduce performance.
 CrazyFM framework provides communication among models and views with signal system which works faster than native flash event system and
  keeps signal data in pool to avoid frequent object creation. Also, in case of physics model and view communication there can be used
  direct communication via interface methods and that won't ruin application architecture. These actions allow to reduce frequent memory
  allocation and garbage collections and increase whole application performance.

###How to use?
Framework consist of 2 main parts: core and [extensions](extensions).
Each of them has its own build configuration. You can build only those modules, that you need.
For example, if your project doesn't use [Starling](https://github.com/Gamua/Starling-Framework), there is no need to build [starlingApp]
(extensions/starlingApp) and connect it to your project.

To start developing project using CrazyFM, you need to connect [core](core) logic to your project.
There are several ways to do it:
 * Use core src path as source path for you project.
 * Build core using Ant and connect SWC dependencies.
 * Build core using your IDE and connect SWC dependencies.
 * Download SWC dependencies and connect them to project.

Add dependencies that are used by [core](core):
 * [as3-signals](https://github.com/robertpenner/as3-signals)
 * or use SWCs in [dependencies](dependencies) folder (recommended for version compatibility).

###Build whole CrazyFM framework
To build whole framework and generate AsDocs for all modules ([core](core) and [extensions](extensions)) setup correct paths in build
.properties and run build.xml configuration with Ant. This will compile everything into separate SWC files, run tests and generate docs.

- [Read more about core](core)
- [Read more about extensions](extensions)