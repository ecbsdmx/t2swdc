# Overview

This application is based on [React](https://facebook.github.io/react) and [Redux](https://rackt.github.io/redux).

Redux is based on 3 principles:
- The state of an entire application is stored in a single object (the store).
- The state can only be changed by emitting actions.
- Reducers receive these actions and modify the state accordingly.

React allows to create visual components for the web.

Based on the above, the following directory layout has been adopted:
- actions/: Contains all the actions supported by the app. The action names are defined as constants available below constants/. Opening constants/action-types.coffee is a nice and quick way to see all the actions supported by the app.
- reducers/: Contains all the reducers, i.e. the functions that will change the state following the trigger of an action.
- components/: Contains all the React components used in the app.
- app/: Contains the React component that acts as entry point for the app.
- assets/: Contains static files such as CSS and images.
