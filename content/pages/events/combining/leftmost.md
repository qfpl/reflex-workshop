In this exercise we are going to complete the FizzBuzz exercise.

The input `Event t Int` will be monotonically increasing.
There will be four output `Event t Text`s:

- the first output will fire with the text "Fizz" whenever the input fires with a multiple of `3`
- the second output will fire with the text "Buzz" whenever the input fires with a multiple of `5`
- the third output will combine the first two outputs, except
    - it will fire with the text "FizzBuzz" whenever the input fires with a value that is a multiple of `3` _and_ a multiple of `5`
- the fourth output will fire with the value of the third output, or 
    - it will fire with the text corresponding to the input whenever the third output is not firing

If that is confusing, perhaps watch the sample outputs in the "Progress" tag for a while to work out what is going on.

You should fill out this function:

```haskell
leftmostExercise :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostExercise eIn =
  (never, never, never, never)
```

to make this happen.
