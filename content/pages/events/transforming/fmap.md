In this exercise, we are working with an `Event t Int` that fires once a second, where the value of the `Event` will be the number of seconds since the panel was loaded.

The event looks like this:

<div id="demonstration-count"></div>

The goal of this exercise is to create an `Event` that fires every time that `eIn` fires, where the value of the output `Event` is double the value of the input `Event`.

You should fill out this function:

```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  never
```

to make this happen.


