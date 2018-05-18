In this exercise we have an `Event t Int` which is ticking away, and we want to turn that into a `Behavior t Int`.

This `Behavior` is going to drive your solution to `~/reflex-workshop/code/src/Workshop/Behavior/Instances/Fmap/Exercise.hs`, so make sure you have finished that exercise first.
If you get this exercise right you should see familiar results.

You should open
`~/reflex-workshop/code/src/Workshop/Behavior/Creating/Fmap/Exercise.hs`
and fill out this function:

```haskell
fmapExercise :: (Reflex t, MonadHold t m)
             => Event t Int
             -> m (Behavior t Int)
fmapExercise eIn =
  pure (pure 0)
```

to make this happen.
