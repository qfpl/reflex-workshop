In this exercise you have a `Dynamic` of pairs, and the goal is to create a pair of `Dynamic`s and to make sure that neither of the `Dynamic`s has any spurious updates.

You should open
`~/reflex-workshop/code/src/Workshop/Behavior/Dynamics/Unique/Exercise.hs `
and fill out this function:

```haskell
uniqueExercise :: (Reflex t, MonadFix m, MonadHold t m)
               => Dynamic t (Int, Int)
               -> m (Dynamic t Int, Dynamic t Int)
uniqueExercise dIn =
  pure (fst <$> dIn, snd <$> dIn)
```

to make this happen.
