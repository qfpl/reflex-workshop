Sometimes we want to create an `Event` that is based on another `Event`, but which doesn't always fire when the input `Event` fires.

The most straight-forward way to do this is with the `ffilter`:
```haskell
ffilter :: Reflex t => (a -> Bool) -> Event t a -> Event t a
```
which takes predicate which is used to decide whether the output `Event` should fire.

<div id="exercise-ffilter"></div>

We can combine the transforming and filtering of an `Event` with `fmapMaybe`:
```haskell
fmapMaybe :: Reflex t => (a -> Maybe b) -> Event t a -> Event t b
```

What is the type of `fmapMaybe id`?
It can be pretty handy...

We can inhibit an `Event` from firing in the same frame as another `Event`:
```haskell
difference :: Reflex t => Event t a -> Event t b -> Event t a
```

We can break an `Event` or `Either`s into a pair of `Event`s corresponding to which of the `Left` and `Right` constructors were used:
```haskell
fanEither :: Reflex t => Event t (Either a b) -> (Event t a, Event t b)
```

<div id="exercise-fmapMaybe"></div>

