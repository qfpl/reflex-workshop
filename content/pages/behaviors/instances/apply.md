In this exercise we have two `Behavior t Int`s, and the goal is to create a new `Behavior t Int`.
At every point in time, the `Behavior` will have a value that is the multiplication of the values of the two input `Behavior`s.

You should fill out this function:

```haskell
applyExercise :: Reflex t
              => Behavior t Int
              -> Behavior t Int
              -> Behavior t Int
applyExercise bIn1 bIn2 =
  pure 0
```

to make this happen.
