This exercise will extend the counter so that it takes the number to add to counter from a text box. The text box value is provided as a `Behavior t Text`.

The output should be a pair of `Event`s.
The first of these should fire with an error message when the user clicks "Add" when the text box does not contain a number.
The second of these should fire with the new value of the counter whenever that should be updated.

You should fill out this function:

```haskell
counterTextExercise :: Reflex t
                    => Behavior t Int
                    -> Behavior t Text
                    -> Event t ()
                    -> Event t ()
                    -> (Event t Text, Event t Int)
counterTextExercise bCount bText eAdd eReset =
  (never, never)
```

to make this happen.
