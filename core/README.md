##CrazyFM-Core
Core is the main framework module. It is responsible to organize communication and hierarchy among models and views.
![](https://github.com/CrazyFlasher/crazyfm/blob/gh-pages/assets/core-m.jpg?raw=true)  
The core includes several main objects. Below is their interfaces description:
- **IModel** - simple class that can contain data and do some logic. Can dispatch and receive signals from model hierarchy.
- **IModelContainer** - extends IModel and is able to add or remove other IModel objects (can be parent of them). Also receives all
signals from children, sub-children and so on.
- **IContext** - extends IModelContainer and is able to communicate with IViewController objects via signals and/or direct connection
(interface methods calls). Re-dispatches received from model hierarchy signals to IViewControllers, that are connected to current
IContext.
- **IViewController** - object that can be connected to IContext for further model <-> view communication via signals or direct
connection. Dispatches signals to connected IContext. Can contain reference to DisplayObjectContainer.