In this exercise you are given a `Dynamic t Int` to display.

You should render this as:

- a `div` with the text "Input" in it
- a `div` which renders the `Dynamic` 

You should open
`~/reflex-workshop/code/src/Workshop/DOM/Elements/Text/Exercise.hs`
and fill out this function:

```haskell
textExercise :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textExercise dIn =
  pure ()
```

to make this happen.
