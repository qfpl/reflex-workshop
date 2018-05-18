The goal of this exercise is to derive `Event`s from a pair of buttons, so that:

- the first `Event` will fire with a `3` whenever the first button is clicked
- the second `Event` will fire with a `5` whenever the second button is clicked

You should open `~/reflex-workshop/code/src/Workshop/Event/Transforming/FmapConst/Exercise.hs` and fill out these functions:

```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
  never

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
  never
```

to make this happen.

The `fmapConstExercise3` function takes the `Event t ()` corresponding to the "Click for 3" button as input,
and the `fmapConstExercise5` function takes the `Event t ()` corresponding to the "Click for 5" button as input.
