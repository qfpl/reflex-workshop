In this exercise we have an `Event t (Int -> Int)` and want to create a `Dynamic t Int` from it.

We have done something like this before, but now we know about some new tools we can use.

You should open
`~/reflex-workshop/code/src/Workshop/Behavior/Dynamics/Counter/Exercise.hs `
and fill out this function:

```haskell
counterExercise :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Dynamic t Int)
counterExercise eFn =
  pure (pure 0)
```

to make this happen.
