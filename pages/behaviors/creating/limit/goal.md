The goal of this exercise is to create the `Behavior` that was used as the limit in `~/reflex-workshop/code/src/Workshop/Behavior/Querying/Limit/Exercise.hs`.
The `Behavior` you create is going to be used with your solution to that exercise, so make sure you have finished that exercise first.

The "Progress" tab will show you what you saw in the previous exercise, but this time you are supplying the logic that drives the limit `Behavior` instead of having it provided for you.

You should open
`~/reflex-workshop/code/src/Workshop/Behavior/Creating/Limit/Exercise.hs`
and fill out this function:

```haskell
limitExercise :: (Reflex t, MonadFix m, MonadHold t m)
              => Behavior t Int
              -> Event t ()
              -> Event t ()
              -> m (Behavior t Int)
limitExercise bCount eAdd eReset = mdo
  pure (pure 0)
```

to make this happen.
