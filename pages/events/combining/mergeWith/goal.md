
In this exercise we are working with two `Event t Int`s which always fire at the same time.

=====

The goal is to produce an `Event t Int` which fires at the same time as these inputs, where the value of the output `Event` is the sum of the two input `Event`s.


You should open `~/reflex-workshop/code/src/Workshop/Event/Combining/MergeWith/Exercise.hs` and fill out this function:

```haskell
mergeWithExercise :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithExercise eIn1 eIn2 =
  never
```

to make this happen.
