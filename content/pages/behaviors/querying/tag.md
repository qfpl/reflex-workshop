In this exercise we have a `Behavior t Int` and an `Event t ()` which fires whenever a button is pressed.

The goal is to produce an `Event t Int` which fires whenever the button is pressed, with a value that is `5` times the value of the input `Behavior` at that instant.

You should fill out this function:

```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  never
```

to make this happen.
