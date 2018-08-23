In this exercise, your goal is to wrap another widget in a `div`.

The div should have the "text-uppercase" class like in the last exercise, but should now have the "hidden" attribute whenever the input `Dynamic` has the value `True`.

You should fill out this function:

```haskell
attributesExercise :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesExercise dIn w =
  w
```

to make this happen.
