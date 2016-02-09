##CrazyFM
###Idea
ActionScript 3 framework based on idea to split view from logic, but leave possibility for easy communication between them.
Also the main idea of the framework is to fill it with new extensions easily.
Developer must have possibility to have several implementations of the same issue.
For example he can use physics extension and choose (also in run-time if needed) between 2 ways of its implementation.
For example between Box2D or Nape. Ideally developer can map somewhere in IContext which implementation for IPhysicsModel he wants to use.
No additional logic changes are needed.

###Why not to use other MVC frameworks?
The idea of most MVC frameworks to communicate between logic and view with commands and events, which is not comfortable sometimes and
reduces application performance.
For example, to update view of physics object, physics model must dispatch 10 (or even 60!) events per second and create many-many
commands due application workflow. Garbage collection will be called often to clear events and commands. Also if developer uses real-time
 injections (ex. SwiftSuspenders) to commands, that will require extra resources and reduce performance.
 CrazyFM framework provides communication among models and views with signal system which works faster than native flash event system and
  keeps signal data in pool to avoid frequent object creation. Also, in case of physics model and view communication there can be used
  direct communication via interface methods and that won't ruin application architecture. These actions allow to reduce frequent memory
  allocation and garbage collections and increase whole application performance.

###Configure to use
Framework consist of 2 main parts: core and extensions.
To start developing project using CrazyFM, you need to setup core.
There are 3 ways to do it:
1. Use core src path as source path for you project.
2. Build core using Ant.
3. Download SWC dependencies and connect them to project.

[Read more about core](core)
[Read more about extensions](extensions)

![alt tag](https://github.com/CrazyFlasher/crazyfm/blob/gh-pages/assets/core-m.jpg?raw=true)
