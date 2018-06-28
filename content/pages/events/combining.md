
The other thing we often want to do with `Event`s is to combine them.

Externally triggered `Event`s all happen in separate frames/transactions, but when we start deriving `Event`s from them we can end up with `Event`s that are firing in the same frame as each other.

In this situation
```haskell
  eOut = (* 100) <$> eIn
```
both `eIn` and `eOut` are always firing in the same frame, and here
```haskell
  eOut = (* 100) <$> ffilter even eIn
```
we have `eOut` firing only in frames where `eIn` is firing.

As `Event`s are modified and passed through our program, we might lose track of whether a given `Event` may or may not be firing in the same frame.
That is a good thing!

We want to be able to reason about our programs with just the locally available information.
To that end, `reflex` provides functions that allow us to combine values from `Event`s that occur in the same frame while not making any assumptions about when or whether the input `Event`s will fire.

The most general of these functions is `mergeWith`:
```haskell
mergeWith :: Reflex t => (a -> a -> a) -> [Event t a] -> Event t a
```

This will use the function to do something akin to `foldl1` over all of the `Event`s in the list that are firing in the current frame.

If we have a `Monoid` instance for `a`, then we can use this instance as a convenience:
```haskell
instance (Reflex t, Monoid a) => Monoid (Event t a) where
  ...
```
which is implemented in terms of `mergeWith (<>)`.

<div id="exercise-mergeWith"></div>

There is a convenience function, which is more-or-less equivalent to `mergeWith const` in `reflex`, called `leftmost`:

```haskell
leftmost :: Reflex t => [Event t a] -> Event t a
```

This is particularly handy for giving some `Event`s priority over others when they fire in the same frame.
If multiple `Event`s are firing, the one closest to the start of the list will be used for the output.

<div id="exercise-leftmost"></div>


