In this exercise we have the same old `Event t Int` ticking once a second.

The goal is to create two `Behavior`s from this `Event`.  Both of them should start at `0`, the first one should increment every `2` seconds, and the second one should increment every `3` seconds.

This `Behavior` is going to drive your solution to `src/Exercises/Behavior/Instances/Apply.hs`, so make sure you have finished that exercise first.
If you get this exercise right you should see familiar results.

You should fill out this function:

```haskell
applyExercise :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applyExercise eIn =
  pure (pure 0, pure 0)
```

to make this happen.
