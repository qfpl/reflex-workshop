In this exercise, we are working with an `eIn :: Event t Int` that fires once a second.

The goal of this exercise is to create an `Event` that fires with the value of the input `Event`, but which only fires when that value is a multiple of `3`.

You should fill out this function:

```haskell
ffilterExercise :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterExercise eIn =
  never
```

to make this happen.
