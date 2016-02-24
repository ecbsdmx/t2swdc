# Actions

Actions are objects that are the sole way to mutate the state of the app. They contain the minimum amount of information necessary to successfully mutate the state. Actions can be triggered by a user (for example, by clicking on a UI widget) or by background processes (for example, for fetching data from a remote source).

There is a [standard way of representing actions](https://github.com/acdlite/flux-standard-action) and this application complies with the proposed representation. In particular, all actions have a `type` and a `payload`.

Actions are created using the `redux-actions` library.

The different types of actions are listed in `constants\action-types.coffee`.
