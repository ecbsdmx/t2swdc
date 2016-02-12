# React components

React allows creating web components to be used in web applications.

With Redux, these components can be *presentational components* or *container components*. Presentational components focus on how things look and are unaware of Redux. Container components focus on how things work and act as *glue* between the presentational components and the underlying Redux framework. Container components can be written from scratch but Redux offers a `connect()` method that eases this process.
