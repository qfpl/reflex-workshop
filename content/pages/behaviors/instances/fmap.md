In this exercise we have a `Behavior t Int`, and the goal is to create a new `Behavior t Int`. 
At every point in time, the `Behavior` will have a value that is `5` times larger than the value in the input `Behavior`.

You should fill out this function:

```haskell
fmapExercise :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapExercise bIn =
  pure 0
```

to make this happen.
