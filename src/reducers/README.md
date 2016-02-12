# Reducers

Reducers are responsible for changing the state of the app, as a result of an action.

Reducers are functions that take a state and an action as parameter, and compute the next state as a result.

Reducers should be **pure functions**, i.e. given the same arguments, it should always compute the same result. Furthermore, the state is supposed to be immutable so a new state must be returned as a result. This application uses `Immutable.js` to guarantee the state immutability.

Redux offers facilities so that reducers only handle the part of the state they are responsible for. This is known as *reducer composition*
