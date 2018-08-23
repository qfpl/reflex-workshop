In this exercise you are given a `Behavior t Int` and an `Event t Text` that is tied to updates to a text input.

The goals is to create a `Behavior t [Text]` that contains the last `n` changes to the `Event t Text`, where `n` is being passed in as a `Behavior` and the list is culled to the length `n` whenever the `Event t Text` fires.

The initial value should be the empty list, and -- for reasons related to how the results are displayed -- you should return both the `Behavior` and the `Event` that is used to build the `Behavior`.

You should fill out this function:

```haskell
textExercise :: (Reflex t, MonadFix m, MonadHold t m)
             => Behavior t Int
             -> Event t Text
             -> m (Behavior t [Text], Event t [Text])
textExercise bIn eIn = mdo
  pure (pure [], never)
```

to make this happen.
