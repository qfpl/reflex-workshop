
A `Dynamic t a` is like a `Behavior t a` that has been upgraded to includ an `Event t a` that signals when it is going to change.

Creating a `Behavior` / `Event` pair like this was a common pattern in FRP code in the wild, and it has proved particularly useful when working with the DOM.
`Behavior`s manage our state, but without a way to signal when they were updating we would need to poll them to detect and react to changes.
With a `Dynamic` we can use the `Behavior` for state management, and let the `Event` notify the DOM of any changes.

You can get hold of the `Behavior`:
```haskell
current :: Reflex t => Dynamic t a -> Behavior t a
```
or the `Event`:
```haskell
updated :: Reflex t => Dynamic t a -> Event t a
```
although something has probably gone a bit wrong if you are making more use of `updated` than `current`.

There are `Functor`, `Applicative`, `Monad`, `Semigroup`, `Monoid` and `IsString` instances which behave much like the instances for `Behavior`.

There is a function in the `MonadHold` typeclass for building `Dynamic`s from `Event`s:
```haskell
class Reflex t => MonadHold t m where
  ...
  holdDyn :: a -> Event t a -> m (Dynamic t a)
  ...
```

There is a really handy function called `foldDyn`:
```haskell
foldDyn     :: (Reflex t, MonadFix m, MonadHold t m) 
            => (a -> b -> b) 
            -> b 
            -> Event t a 
            -> m (Dynamic t b)
```
which I often use with `($)`, which specializes to:
```haskell
foldDyn ($) :: (Reflex t, MonadFix m, MonadHold t m) 
            => a
            -> Event t (a -> a)
            -> m (Dynamic t a)
```

This is picked up in the `Accumulator` class:
```haskell
class Reflex t => Accumulator t f | f -> t where
  ...
  accum :: (MonadHold t m, MonadFix m) 
        => (a -> b -> a) 
        -> a 
        -> Event t b 
        -> m (f a)
  ...
```
which has instances for `Event`, `Behavior` and `Dynamic`.

The function has the arguments around the other way, so I tend to use `(&)` from `Data.Function` with `accum`, because it is quicker to type than `(flip ($))`.

<div id="exercise-counter"></div>

There is another handy function worth pointing out.

We can use the `Applicative` instance to group together various `Dynamic`s, and then we can pass that `Dynamic` around our program.

```haskell
data Foo = Foo { bar :: Int, baz :: Bool }
let dState = Foo <$> dBar <*> dBaz
```
Some other part of our program might only be interested in part of that result, and we can use the `Functor` instance to project that out.

```haskell
let dInterestingBit = bar <$> dState
```

The problem is that if `baz` gets updated in `dState`, `dInterestingBit` is going to see `Event`s firing to indicate an update has occurred even though that value isn't changing.


The function `holdUniqDyn`:
```haskell
holdUniqDyn :: (Reflex t, MonadFix m, MonadHold t m, Eq a) 
            => Dynamic t a 
            -> m (Dynamic t a)
```
will take a `Dynamic` and build a similar `Dynamic`, where the internal `Event` will not fire if the value of the `Dynamic` has not changed.

So if you're building up `Dynamic`s and tearing them down again, remember that `holdUniqDyn` might help you out.

<div id="exercise-unique"></div>

