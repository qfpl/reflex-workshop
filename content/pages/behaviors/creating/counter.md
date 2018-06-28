In this exercise we have an `Event t (Int -> Int)` and want to create a `Behavior t Int` from it.

The initial value should be `0`, and -- for reasons related to how the results are displayed -- you should return both the `Behavior` and the `Event` that is used to build the `Behavior`.

You should fill out this function:

```haskell
counterExercise :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterExercise eFn =
  pure (pure 0, never)
```

to make this happen.
