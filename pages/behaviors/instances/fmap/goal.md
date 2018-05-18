In this exercise we have a `Behavior t Int`, and the goal is to create a new `Behavior t Int`. 
At every point in time, the `Behavior` will have a value that is `5` times larger than the value in the input `Behavior`.

You should open `~/reflex-workshop/code/src/Workshop/Behavior/Instances/Fmap/Exercise.hs` and fill out this function:

```haskell
fmapExercise :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapExercise bIn =
  pure 0
```

to make this happen.
