The goal of this exercise is to take your solution to
`~/reflex-workshop/code/src/Workshop/DOM/Elements/Attributes/Exercise.hs`
and to make it emit an `Event` when the `div` is clicked.

You should open
`~/reflex-workshop/code/src/Workshop/DOM/Elements/Events/Exercise.hs`
and fill out this function:

```haskell
eventsExercise :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsExercise dIn w =
  pure never
```

to make this happen.
