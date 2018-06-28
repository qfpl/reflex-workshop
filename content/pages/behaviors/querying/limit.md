This exercise is a variant on the previous exercises.

We are now given an additional input -- a `Behavior t Int` -- which represents the upper limit that the counter is allowed to reach.

We are passing in a `Behavior t Int` as the limit instead of an `Int` to make the function as general as we can.
If want the limit to be `5` we can pass in `pure 5`.
If we want some other part of our program to decide on the limit or want to do something fancier, we can do that as well.

This is a common technique in FRP programs.
Passing around arbitrary pieces of time-varying state as values is handy, so we do it often.

You should fill out this function:

```haskell
limitExercise :: Reflex t
              => Behavior t Int
              -> Behavior t Int
              -> Event t ()
              -> Event t ()
              -> Event t Int
limitExercise bCount bLimit eAdd eReset =
  never
```

to make this happen.

Feel free to import and use solutions to previous exercises if you think that will help.
