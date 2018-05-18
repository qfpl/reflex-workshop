
The second type that we will use will be `Behavior`:
```haskell
data Behavior t a 
```

The semantics are often expressed as:
```haskell
Behavior t a ~ (t -> a)
```
which roughly means that a `Behavior` of type `a` is equivalent to function from time to values of `a`.

`Behavior`s give us first class values that represent time-varying state.
Like any other value, these can be passed to function, returned from functions, or stored in data structures.
We also have the ability to combine them and to take them apart whenever we like.

It is worth noting that `Behavior`s have values at every point of time -- including before the time when your application's first `Event` fires.

Some examples of `Behavior`s are:

- `bIsAdminUser           :: Behavior t Bool`
- `bTextInputContents     :: Behavior t Text`
- `bNumRequestsInProgress :: Behavior t Int`

We interact with `Behavior`s through the use of `Event`s. 
The firings of the `Event`s are used to determine at which time we want to know or prepare to alter a `Behavior`.
We can also combine and manipulate other `Behavior`s, which is what we're going to look at first.


