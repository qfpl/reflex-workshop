There are several handy typeclass instances for `Behavior`s

One of the most commonly used instances is the `Functor` instance:
```haskell
(<$>) :: Reflex t => (a -> b) -> Behavior t a -> Behavior t b
```
which lets us transform a `Behavior` at every point in time.
=====
Another commonly instance is the `Applicative` instance which gives us:
```haskell
pure  :: Reflex t => a -> Behavior t a
(<*>) :: Reflex t => Behavior t (a -> b) -> Behavior t a -> Behavior t b
```

This allows us to create `Behavior`s with a single value at all point in time, and to apply `Behavior`s of functions to `Behavior`s of arguments.
=====
There is also a `Monad` instance -- which we will look at soon -- as well as instances for `Num`, `Semigroup`, `Monoid` and `IsString`.
