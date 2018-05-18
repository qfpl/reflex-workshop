In this exercise, your goal is to wrap another widget in a `div`.

The div should have the "text-uppercase" class, and should have the "invisible" class on it whenever the input `Dynamic` has the value `True`.
Both of these classes come from Bootstrap 4, which is available to you through all of these exercises.

You should open
`~/reflex-workshop/code/src/Workshop/DOM/Elements/Class/Exercise.hs`
and fill out this function:

```haskell
classExercise :: MonadWidget t m
              => Dynamic t Bool
              -> m a
              -> m a
classExercise dIn w =
  w
```

to make this happen.
