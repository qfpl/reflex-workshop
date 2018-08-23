The goal of this exercise is to build up functionality that will be used to create a counter.

You should fill out this function:

```haskell
counterExercise' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterExercise' bCount eAdd eReset =
  never
```

The function takes the current value of the counter as a `Behavior t Int` along with an `Event t Int` which fires with the value to add to the counter and an `Event t ()` which signals when to reset the counter.

The output `Event t Int` should fire with the new value of the counter whenever either of the input `Event`s fire.

You should then use it to write this function:
```haskell
counterExercise :: Reflex t
                => Behavior t Int
                -> Event t ()
                -> Event t ()
                -> Event t Int
counterExercise bCount eAdd eReset =
  never
```
which is what is used in the next tab.

