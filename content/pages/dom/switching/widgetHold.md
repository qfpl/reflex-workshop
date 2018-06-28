This is an extension of the previous exercise.

The goal is the same, but now you need to create widgets for the waiting mode and the clicking mode. 
You will also need to write the code to switch between them and to collect the outputs appropriately.

You should fill out this function:

```haskell
widgetHoldExercise :: MonadWidget t m
                   => Event t Bool
                   -> m (Dynamic t Int)
widgetHoldExercise eClickable =
  pure (pure 0)
```

to make this happen.
